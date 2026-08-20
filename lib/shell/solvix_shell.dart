import 'package:flutter/material.dart';
import '../widgets/global_nav_drawer.dart';
import '../widgets/lumen/lumen_bubble.dart';
import '../pages/home_page.dart';

    class SolvixShell extends StatelessWidget{
      const SolvixShell({super.key});

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
          ],
        ),
        body: Stack(
          children:[
            const HomePage(),

            const LumenBubble(),
          ]

        ),
        endDrawer: const GlobalDrawer(),
      );
      }
    }