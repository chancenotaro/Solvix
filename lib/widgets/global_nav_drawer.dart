import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    bool isHomeSelected = true;

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
               Text('SOLVIX',
                 style: TextStyle(
                   color: Theme.of(context).colorScheme.primary,
                   fontSize: 24,
                   fontWeight: FontWeight.bold),
               ),

               Text('Developer Environment',
                 style: TextStyle(
                   fontSize: 12,
                   fontWeight: FontWeight.w400,
                 )
               ),
              ],
            ),
          ),

          Divider(),

          Container(
            decoration: BoxDecoration(
              border: isHomeSelected
                ? Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 4,
              ),
              )
              : null,
            ),
            child: ListTile(

            leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary
            ),
            title: Text(
              'Home',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            ),
            selected: isHomeSelected,
            selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
            ),
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

  const GlobalDrawer({super.key});

}