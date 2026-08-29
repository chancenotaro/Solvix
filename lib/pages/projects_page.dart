import 'package:flutter/material.dart';
import '../projects/project_scope.dart';
import '../utils/date_formatter.dart';
import 'package:solvix/projects/project_workspace.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .colorScheme
        .primary;
    final projectManager = ProjectScope.of(context);


    return ListenableBuilder(
      listenable: projectManager,
      builder: (context, child) {
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

              const SizedBox(height: 16,),

              Expanded(
                child: projectManager.projects.isEmpty
                    ? const Center(
                  child: Text('No projects yet'),
                )
                    : ListView.builder(
                  itemCount: projectManager.projects.length,
                  itemBuilder: (context, index) {
                    final project = projectManager.projects[index];

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.code,
                          color: primaryColor,
                        ),
                        title: Text(project.name),
                        subtitle: Text(
                          'Last updated: ${SolvixDateFormatter.format(project.lastModified)}',
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}