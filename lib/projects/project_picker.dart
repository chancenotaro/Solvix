import 'package:flutter/material.dart';
import 'local_project_storage.dart';
import 'project_workspace.dart';

String _formatLastModified(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes < 1) {
    return 'Modified just now';
  }

  if (difference.inHours < 1) {
    return 'Modified ${difference.inMinutes}m ago';
  }

  if (difference.inDays < 1) {
    return 'Modified ${difference.inHours}h ago';
  }

  if (difference.inDays < 7) {
    return 'Modified ${difference.inDays}d ago';
  }

  return 'Modified ${date.month}/${date.day}/${date.year}';
}


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
            padding: const EdgeInsets.all(12),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: const Icon(
                    Icons.folder,
                    size: 32,
                  ),
                  title: Text(
                    project.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    _formatLastModified(project.lastModified),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    _openProject(
                      context,
                      project.path,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}