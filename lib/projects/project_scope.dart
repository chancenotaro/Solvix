import 'package:flutter/material.dart';
import 'project_manager.dart';

class ProjectScope extends InheritedWidget {
  final ProjectManager projectManager;

  const ProjectScope({
    super.key,
    required this.projectManager,
    required super.child,
});

  static ProjectManager of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ProjectScope>();

    assert(scope != null, 'ProjectScope not found in widget tree.');

    return scope!.projectManager;
  }

  @override
  bool updateShouldNotify(ProjectScope oldWidget){
    return projectManager != oldWidget.projectManager;
  }
}