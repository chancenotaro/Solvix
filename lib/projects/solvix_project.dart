import 'project_folder.dart';

class SolvixProject{
  final String name;
  final String path;
  final DateTime lastModified;

  final ProjectFolder rootFolder;

  const SolvixProject({
    required this.name,
    required this.path,
    required this.lastModified,
    required this.rootFolder,
});
}