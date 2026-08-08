import 'package:flutter/material.dart';

class LumenBubble extends StatefulWidget {
  const LumenBubble({super.key});

  @override
  State<LumenBubble> createState() => _LumenBubbleState();
}

class _LumenBubbleState extends State<LumenBubble> {
  Offset? position;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    position ??= Offset(
      screenSize.width - 84,
      screenSize.height - 180,
    );

    return Positioned(
      left: position!.dx,
      top: position!.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position = position! + details.delta;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 30,
              ),
            ),
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}