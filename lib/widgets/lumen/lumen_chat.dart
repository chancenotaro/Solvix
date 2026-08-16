import 'package:flutter/material.dart';

class LumenChat extends StatelessWidget {
  final VoidCallback onClose;

  const LumenChat({
    super.key,
  required this.onClose,
});

  @override
  Widget build(BuildContext context){
    return Container(
      width: 320,
      height: 450,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: [
              const Text('Lumen'),
              const Spacer(),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
    ],
      ),
    );
  }
}