import 'package:flutter/material.dart';
import '../navigation/solvix_page.dart';

class GlobalDrawer extends StatelessWidget{

  final void Function(SolvixPage) onPageSelected;
  final SolvixPage currentPage;

  const GlobalDrawer({
    super.key,
    required this.onPageSelected,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context){

    Border? selectedBorder(SolvixPage page) {
      if (currentPage == page) {
        return Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
        );
      }
      return null;
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
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
              border: selectedBorder(SolvixPage.home),
            ),
            child: ListTile(

            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              onPageSelected(SolvixPage.home);
            },
            selected: currentPage == SolvixPage.home,
            selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
            ),
            ),
          Container(
            decoration: BoxDecoration(
              border: selectedBorder(SolvixPage.projects),
              ),

          child: ListTile(
            leading: Icon(Icons.folder),
            title: Text('Projects'),
            onTap: () {
              onPageSelected(SolvixPage.projects);
            },
            selected: currentPage == SolvixPage.projects,
            selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
          ),

          Container(
            decoration: BoxDecoration(
              border: selectedBorder(SolvixPage.settings),
            ),

          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              onPageSelected(SolvixPage.settings);
            },
            selected: currentPage == SolvixPage.settings,
            selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
          ),

          Container(
            decoration: BoxDecoration(
              border: selectedBorder(SolvixPage.about)
            ),
          child: ListTile(
            leading: Icon(Icons.code),
            title: Text('About'),
            onTap: () {
              onPageSelected(SolvixPage.about);
            },
            selected: currentPage == SolvixPage.about,
            selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
          ),
        ],
      ),
    );
  }
}