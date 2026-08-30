import 'package:flutter/material.dart';
import 'package:solvix/projects/solvix_project.dart';
import 'package:solvix/projects/workspace/project_drawer.dart';
import '../project_file.dart';

class CodePage extends StatefulWidget {
  final SolvixProject project;

  const CodePage({
    super.key,
    required this.project,
  });

  @override
  State<CodePage> createState() => _CodePageState();
}
class _CodePageState extends State<CodePage> {
  ProjectFile? activeFile;

  bool isDrawerOpen = true;

  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Editor
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 52,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Text(
                  activeFile?.name ?? 'No file selected',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: activeFile == null
                    ? const Center(
                  child: Text('Select a file'),
                )
                    : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          padding: const EdgeInsets.only(top:12),
                          child: Text(
                            List.generate(
                              '\n'.allMatches(codeController.text).length + 1,
                                  (index) => '${index + 1}',
                            ).join('\n'),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: codeController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: const TextStyle (
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                activeFile!.content = value;
                              });
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
        // Project explorer
        if (isDrawerOpen)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: 200,
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 8,
                child: SizedBox(
                  width: 200,
                  child: ProjectDrawer(
                    rootFolder: widget.project.rootFolder,
                    onFileSelected: (file) {
                      setState(() {
                        activeFile = file;
                        codeController.text = file.content;
                      });
                    },
                    onToggle: () {
                      setState(() {
                        isDrawerOpen = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),

        // Open explorer button
        if (!isDrawerOpen)
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  isDrawerOpen = true;
                });
              },
              tooltip: 'Show project explorer',
            ),
          ),
      ],
    );
  }
}