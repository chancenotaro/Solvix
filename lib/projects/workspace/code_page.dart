import 'package:flutter/material.dart';
import 'package:solvix/projects/solvix_project.dart';
import 'package:solvix/projects/workspace/project_drawer.dart';
import '../project_file.dart';
import 'package:re_editor/re_editor.dart';

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

  final CodeLineEditingController codeController = CodeLineEditingController();

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

                   child: CodeEditor(
                      controller: codeController,
                      wordWrap: false,

                      indicatorBuilder: (
                          context,
                      editingController,
                      chunkController,
                      notifier,
                          ) {
                        return DefaultCodeLineNumber(
                          notifier: notifier,
                          controller: editingController,
                        );
                        },
                       padding: const EdgeInsets.all(12),
                       onChanged: (value) {
                        activeFile?.content =
                            value.codeLines.asString(TextLineBreak.lf);
                      }
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