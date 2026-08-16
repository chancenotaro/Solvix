import 'package:flutter/material.dart';
import 'widgets/lumen/lumen_bubble.dart';
import 'theme/solvix_theme.dart';
import 'widgets/global_nav_drawer.dart';

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
      home: const SolvixHomePage(),
    );
  }
}

class SolvixHomePage extends StatelessWidget {
  const SolvixHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solvix'),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed:() {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
    ),
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Welcome to Solvix',
              style: TextStyle(fontSize: 24),
            ),

          ),
          const LumenBubble(),
       ],
      ),
      endDrawer: const GlobalDrawer(),
    );
  }
}
