import 'package:flutter/material.dart';
import 'package:solvix/projects/project_file.dart';
import 'package:solvix/projects/project_folder.dart';
import 'solvix_project.dart';
import 'project_manager.dart';
import 'local_project_storage.dart';
import 'project_workspace.dart';

class CreateProjectPage extends StatefulWidget {
  final ProjectManager projectManager;

  const CreateProjectPage({
    super.key,
    required this.projectManager
  });

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
  }
  class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
    void dispose(){
    _nameController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
      ),




      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Name',
              style: Theme.of(context).textTheme.titleMedium,
            ),


            const SizedBox(height: 8),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter project name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: () async {
                final name = _nameController.text.trim();

                if(name.isEmpty){
                  return;
                }

                try {
                  final storage = LocalProjectStorage();

                  final project = await storage.createProject(name);

                  debugPrint('REAL PROJECT CREATED: ${project.name}');
                  debugPrint('REAL PROJECT PATH: ${project.path}');

                  widget.projectManager.addProject(project);

                  if (!mounted) return;

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ProjectWorkspace(
                        project: project
                    ),
                  ),
                );
              } catch(e) {
                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()),
                  ),
                );
                }
              },
              child: const Text('Create Project'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}