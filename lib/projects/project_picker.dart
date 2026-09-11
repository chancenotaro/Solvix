import 'package:flutter/material.dart';
import 'local_project_storage.dart';
import 'project_workspace.dart';

class ProjectPicker extends StatelessWidget {
  const ProjectPicker({super.key});

  Future<void> _openProject(
      BuildContext context,
      String path,
      ) async {
    try {
      final storage = LocalProjectStorage();

      final project = await storage.loadProject(path);

      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProjectWorkspace(
            project: project,
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = LocalProjectStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Project'),
      ),
      body: FutureBuilder(
        future: storage.listProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Unable to load projects.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final projects = snapshot.data ?? [];

          if (projects.isEmpty) {
            return const Center(
              child: Text('No projects found'),
            );
          }

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(project.name),
                subtitle: Text(project.path),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _openProject(
                    context,
                    project.path,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}