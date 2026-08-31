import 'project_file.dart';

class ProjectFolder {
  String name;
  String path;

  List<ProjectFile> files;
  List<ProjectFolder> folders;

  ProjectFolder({
    required this.name,
    required this.path,
    List<ProjectFile>? files,
    List<ProjectFolder>? folders,
  }) :  files = files ?? [],
        folders = folders ?? [];
}