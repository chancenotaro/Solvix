import 'package:flutter/material.dart';
import 'widgets/lumen_bubble.dart';

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
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple
      ),
    ),
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
    );
  }
}
