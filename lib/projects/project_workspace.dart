import 'package:flutter/material.dart';
import 'package:solvix/projects/workspace/code_page.dart';
import 'package:solvix/projects/workspace/console_page.dart';
import 'package:solvix/projects/workspace/simulation_page.dart';
import 'solvix_project.dart';

class ProjectWorkspace extends StatefulWidget {
  final SolvixProject project;

  const ProjectWorkspace({
    super.key,
    required this.project,
  });

  @override
  State<ProjectWorkspace> createState() => _ProjectWorkspaceState();
}

class _ProjectWorkspaceState extends State<ProjectWorkspace> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          IconButton (
          icon: const Icon(Icons.play_arrow),
              tooltip: 'Run',
              color: Theme.of(context).colorScheme.primary,
        onPressed: (){
          //Build Run funcionality will come later
        }
        ),
        ]
      ),
      body: IndexedStack(
        index: currentTab,
        children: [
          CodePage(
            project: widget.project,
          ),
          const ConsolePage(),
          const SimulationPage(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab,
        onDestinationSelected: (index) {
          setState(() {
            currentTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.code),
              label: 'Code',
          ),
          NavigationDestination(
              icon: Icon(Icons.terminal),
              label: 'Console',
          ),
          NavigationDestination(
            icon: Icon(Icons.science),
            label: 'Simulation',
          ),
        ],
      ),
    );
  }
}