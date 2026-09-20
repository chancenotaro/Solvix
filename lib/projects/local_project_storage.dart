import 'dart:io';
import 'solvix_project.dart';
import 'project_storage.dart';
import 'project_folder.dart';
import 'project_file.dart';
import 'package:path_provider/path_provider.dart';

class LocalProjectStorage implements ProjectStorage {

  Future<List<SolvixProject>> listProjects() async {
    final projectsDirectory = await getProjectsDirectory();

    final projects = <SolvixProject>[];

    await for (final entity in projectsDirectory.list()) {
      if (entity is Directory) {
        final project = await loadProject(entity.path);
        projects.add(project);
      }
    }

    projects.sort(
        (a,b) => b.lastModified.compareTo(a.lastModified)
    );
    return projects;
  }

  Future<Directory> getProjectsDirectory() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final projectsDirectory = Directory(
      '${appDirectory.path}/Projects',
    );

    if (!await projectsDirectory.exists()) {
      await projectsDirectory.create(recursive: true);
    }
    return projectsDirectory;
  }

  Future<SolvixProject> createProject(String projectName) async {
    final projectsDirectory = await getProjectsDirectory();

    final projectDirectory = Directory(
      '${projectsDirectory.path}/$projectName',
    );

    if (await projectDirectory.exists()) {
      throw Exception('A project named "$projectName" already exists.');
    }

    await projectDirectory.create(recursive: true);

    final libDirectory = Directory(
      '${projectDirectory.path}/lib',
    );

    await libDirectory.create();

    final mainFile = File(
      '${libDirectory.path}/main.dart',
    );

    await mainFile.writeAsString(
      'void main() {\n'
          '  print("Hello from Solvix!");\n'
          '}\n',
    );

    return loadProject(projectDirectory.path);
  }

  Future<ProjectFolder> createFolder(
      String parentFolderPath,
      String folderName,
      ) async {
    final folderPath = '$parentFolderPath/$folderName';

    final directory = Directory(folderPath);

    if(await directory.exists()) {
      throw Exception(
        'A folder named "$folderName" already exists.',
      );
    }

    await directory.create();

    return ProjectFolder(
      name: folderName,
      path: folderPath,
    );
  }


  Future<ProjectFile> createFile(
      String folderPath,
      String fileName,
      ) async {
    final filePath = '$folderPath/$fileName';

    final file = File(filePath);

    if (await file.exists()) {
      throw Exception ( 'A file named "$fileName" already exists.');
    }
    await file.writeAsString('');

    return ProjectFile(
      name: fileName,
      path: filePath,
      content: '',
      isTextFile: true,
    );
}

  @override
  Future<SolvixProject> loadProject(String path) async {
    final directory = Directory(path);

    if (!await directory.exists()) {
      throw Exception('Project directory does not exist: $path');
    }

    final projectName = directory.uri.pathSegments.isNotEmpty
    ? directory.uri.pathSegments[directory.uri.pathSegments.length - 2]
        : directory.path;

    final rootFolder = await _loadFolder(directory);

    return SolvixProject(
        name: projectName,
        path: directory.path,
        lastModified: await directory.stat().then((stat) => stat.modified),
        rootFolder: rootFolder);

  }

  Future<ProjectFolder> _loadFolder(Directory directory) async {
    final folder = ProjectFolder(
      name: directory.uri.pathSegments[
        directory.uri.pathSegments.length - 2
      ],
      path: directory.path,
    );

    await for (final entity in directory.list()) {
      if (entity is Directory) {
        final childFolder = await _loadFolder(entity);
        folder.folders.add(childFolder);
      } else if (entity is File) {

        final content = await entity.readAsString();

        folder.files.add(
          ProjectFile(
            name: entity.uri.pathSegments.last,
            path: entity.path,
            content: content,
            isTextFile: true,
          ),
        );
      }
    }
    return folder;
  }

  @override
  Future<void> saveProject(SolvixProject project) async {
    throw UnimplementedError();
  }

  Future<void> saveFile(ProjectFile file) async {
    if (!file.isTextFile) {
      throw Exception('Cannot save binary file as text.');
    }

    final diskFile = File(file.path);

    await diskFile.writeAsString(file.content);
  }
}