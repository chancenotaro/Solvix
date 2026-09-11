import 'solvix_project.dart';

abstract class ProjectStorage {
  Future<SolvixProject> loadProject(String path);

  Future<void> saveProject(SolvixProject project);
}