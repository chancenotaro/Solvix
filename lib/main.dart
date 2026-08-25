import 'package:flutter/material.dart';

import 'theme/solvix_theme.dart';

import 'shell/solvix_shell.dart';
import 'projects/project_manager.dart';
import 'projects/project_scope.dart';

void main() {
  runApp(
      const SolvixApp(),

  );
}

class SolvixApp extends StatelessWidget {
  const SolvixApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solvix',
      theme: SolvixTheme.darkTheme,
      home: ProjectScope(
        projectManager: ProjectManager(),
        child: const SolvixShell(),
      )
    );
  }
}
