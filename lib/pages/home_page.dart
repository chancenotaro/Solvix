import 'package:flutter/material.dart';
import 'package:solvix/theme/solvix_theme.dart';
import 'package:solvix/projects/create_project_page.dart';
import '../projects/project_scope.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {

    Color primaryColor = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              'Continue Working',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.code,
                  color: primaryColor,
                ),
                title: const Text('My First Project'),
                subtitle: const Text('Last worked on recently'),
                trailing: const Icon(Icons.arrow_forward),
              )
            ),

            const SizedBox(height: 28),

            //Recent Projects Title
            Text(
              'Recent Projects',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 10),

            //Recent Projects List
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _projectCard(context, 'Project One'),
                  _projectCard(context, 'Project Two'),
                  _projectCard(context, 'Project Three'),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  _quickAction(
                      context,
                      Icons.add,
                      'New Project',
                          () {
                        Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CreateProjectPage(
                            projectManager: ProjectScope.of(context),
                          ),
                        ),
                      );
                    },
                  ),


                _quickAction(
                  context,
                  Icons.folder_open,
                  'Open Project',
                    (){

                    }
                ),
                _quickAction(
                  context,
                  Icons.file_download,
                  'Import',
                    () {

                    }
                ),
              ],
            ),
        ),
      ],
    ),
      ),
    );
  }


  Widget _quickAction(
      BuildContext context,
      IconData icon,
      String label,
      VoidCallback onTap
      ) {
    return SizedBox(
      width: 150,
      height: 80,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),

              Text(label),

            ],
          ),
        ),
      ),
    );
  }


  Widget _projectCard(BuildContext context, String name){
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                Icons.code,
                color: primaryColor,
              ),
              title: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}