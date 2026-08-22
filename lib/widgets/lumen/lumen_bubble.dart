import 'package:flutter/material.dart';
import 'lumen_chat.dart';



class LumenBubble extends StatefulWidget {
  final Size availableSize;

  const LumenBubble({
    super.key,
    required this.availableSize,});

  @override
  State<LumenBubble> createState() => _LumenBubbleState();
}

class _LumenBubbleState extends State<LumenBubble> {
  Offset? position;

  bool isOpen = false;



  Offset? savedPosition;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    position ??= Offset(
      widget.availableSize.width - 84,
      widget.availableSize.height - 84,
    );

          return AnimatedPositioned(

            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            left: position!.dx,
            top: position!.dy,
            child: isOpen
                ? LumenChat(
              onClose: () {
                setState(() {
                  isOpen = false;
                });
              },
            )
                : GestureDetector(
              onPanUpdate: (details) {

                const bubbleSize = 64;
                const padding = 16.0;

                setState(() {
                  final newX = position!.dx + details.delta.dx;
                  final newY = position!.dy + details.delta.dy;

                  position = Offset(
                    newX.clamp(
                      padding,
                      widget.availableSize.width - bubbleSize - padding,
                    ),
                    newY.clamp(
                      padding,
                      widget.availableSize.height - bubbleSize - padding,
                    ),
                  );
                });
              },

              onTap: () {
                setState(() {
                  if (!isOpen) {
                    savedPosition = position;

                    isOpen = true;
                  } else {
                    position = savedPosition;
                    isOpen = false;
                  }
                });
              },

              onPanEnd: (details) {
                final screenWidth = widget.availableSize.width;
                const bubbleSize = 64;

                final currentX = position!.dx;

                final leftEdge = 16.0;
                final rightEdge = screenWidth - bubbleSize - 16.0;

                final targetX =
                currentX < screenWidth / 2
                    ? leftEdge
                    : rightEdge;
                setState(() {
                  position = Offset(
                    targetX,
                    position!.dy,
                  );
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.chat_bubble,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .error,
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
