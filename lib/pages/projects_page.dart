import 'package:flutter/material.dart';
import 'package:solvix/projects/local_project_storage.dart';
import 'package:solvix/projects/project_workspace.dart';
import '../utils/date_formatter.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final LocalProjectStorage storage = LocalProjectStorage();

  late Future<List<dynamic>> projectsFuture;

  @override
  void initState() {
    super.initState();
    projectsFuture = storage.listProjects();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: FutureBuilder(
              future: projectsFuture,
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
                    child: Text('No projects yet'),
                  );
                }

                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.code,
                          color: primaryColor,
                        ),
                        title: Text(project.name),
                        subtitle: Text(
                          'Last updated: '
                              '${SolvixDateFormatter.format(project.lastModified)}',
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProjectWorkspace(
                                project: project,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}