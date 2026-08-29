import 'project_file.dart';

class ProjectFolder {
  final String name;
  final String path;

  final List<ProjectFile> files;
  final List<ProjectFolder> folders;

  const ProjectFolder({
    required this.name,
    required this.path,
    this.files = const [],
    this.folders = const [],
});
}