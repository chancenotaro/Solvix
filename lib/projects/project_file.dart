class ProjectFile {
  final String name;
  final String path;
  String content;

    ProjectFile({
    required this.name,
    required this.path,
    this.content = '',
});
}