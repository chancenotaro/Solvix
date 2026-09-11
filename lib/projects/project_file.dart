class ProjectFile {
  String name;
  String path;
  String content;
  bool isTextFile;

    ProjectFile({
    required this.name,
    required this.path,
    required this.content,
      this.isTextFile = true,
});
}