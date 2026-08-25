import 'package:flutter/foundation.dart';
import 'solvix_project.dart';

class ProjectManager extends ChangeNotifier{
  final List<SolvixProject> _projects = [];

  List<SolvixProject> get projects => List.unmodifiable(_projects);

  void addProject(SolvixProject project) {
    _projects.add(project);
    notifyListeners();
  }
}