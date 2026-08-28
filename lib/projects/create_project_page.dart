import 'package:flutter/material.dart';
import 'solvix_project.dart';
import 'project_manager.dart';

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
              child: FilledButton(onPressed: (){
                final name = _nameController.text.trim();

                if(name.isEmpty){
                  return;
                }
                final project = SolvixProject(
                  name: name,
                  path: '',
                  lastModified: DateTime.now(),
                );



                widget.projectManager.addProject(project);

                Navigator.of(context).pop();

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