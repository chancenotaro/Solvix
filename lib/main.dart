import 'package:flutter/material.dart';
import 'widgets/lumen/lumen_bubble.dart';
import 'theme/solvix_theme.dart';
import 'widgets/global_nav_drawer.dart';
import 'shell/solvix_shell.dart';

void main() {
  runApp(const SolvixApp());
}

class SolvixApp extends StatelessWidget {
  const SolvixApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solvix',
      theme: SolvixTheme.darkTheme,
      home: const SolvixShell(),
    );
  }
}
