import 'package:flutter/material.dart';
import '../widgets/global_nav_drawer.dart';
import '../widgets/lumen/lumen_bubble.dart';
import '../pages/home_page.dart';
import '../navigation/solvix_page.dart';
import '../pages/projects_page.dart';
import '../pages/settings_page.dart';
import '../pages/about_page.dart';

    class SolvixShell extends StatefulWidget{
      const SolvixShell({super.key});

      @override
      State<SolvixShell> createState() => _SolvixShellState();

    }

    class _SolvixShellState extends State<SolvixShell>{

      SolvixPage currentPage = SolvixPage.home;


      @override
      Widget build(BuildContext context){

        return Scaffold(
          appBar: AppBar(
            title: const Text('Solvix'),
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed:() {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],      ),
          endDrawer: GlobalDrawer(
            currentPage: currentPage,
            onPageSelected: (page) {
              setState((){
                currentPage = page;
              });
            },
          ),

          body: LayoutBuilder(
            builder:  (context, constraints){
              return  Stack(
                fit: StackFit.expand,
              children:[
                switch (currentPage){
                SolvixPage.home => const HomePage(),
                SolvixPage.projects => const ProjectsPage(),
                SolvixPage.settings => const SettingsPage(),
                SolvixPage.about => const AboutPage(),
                },

                LumenBubble(
                availableSize: Size(
                constraints.maxWidth,
                    constraints.maxHeight,

                  ),
                ),
              ],
              );
              },
          ),
        );
      }
    }