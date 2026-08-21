import 'package:flutter/material.dart';
import '../widgets/global_nav_drawer.dart';
import '../widgets/lumen/lumen_bubble.dart';
import '../pages/home_page.dart';
import '../navigation/solvix_page.dart';

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

          body: Stack(
              children:[
                currentPage == SolvixPage.home
                ? const HomePage()
                : const Center(
                  child: Text('Page coming soon'),
                ),

                const LumenBubble(),
              ]

          ),

        );
      }
    }