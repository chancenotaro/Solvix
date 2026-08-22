import 'package:flutter/material.dart';



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

            Text(
              'Recent Projects',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

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
          ],
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

              const SizedBox(height: 4),

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