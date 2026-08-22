import 'package:flutter/material.dart';
import 'package:solvix/theme/solvix_theme.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {

    Color primaryColor = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Continue Working',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

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

            const SizedBox(height: 32),

            //Recent Projects Title
            Text(
              'Recent Projects',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

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

            const SizedBox(height: 32),

            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _quickAction(
                  context,
                  Icons.add,
                  'New Project',
                ),
                _quickAction(
                  context,
                  Icons.folder_open,
                  'Open Project',
                ),
                _quickAction(
                  context,
                  Icons.file_download,
                  'Import',
                ),
              ],
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
      ) {
    return SizedBox(
      width: 150,
      height: 80,
      child: Card(
        child: InkWell(
          onTap: () {
            //We'll implement this later
          },
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
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.code,
                color: primaryColor,
              ),

              const Spacer(),

              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Updated recently',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}