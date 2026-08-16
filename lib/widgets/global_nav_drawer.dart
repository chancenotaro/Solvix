import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget{
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context){

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
               Text('SOLVIX'),
               Text('Developer Environment'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Projects'),

          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('About'),
          ),
        ]

      )

    );

  }

}