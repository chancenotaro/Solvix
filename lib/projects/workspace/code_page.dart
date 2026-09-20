import 'package:flutter/material.dart';
import 'package:solvix/projects/solvix_project.dart';
import 'package:solvix/projects/workspace/project_drawer.dart';
import '../project_file.dart';
import 'package:re_editor/re_editor.dart';
import 'package:solvix/projects/local_project_storage.dart';
import 'package:solvix/projects/project_folder.dart';

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
  ProjectFolder? selectedFolder;
  bool isLoadingFile = false;
  bool isDrawerOpen = false;
  List<ProjectFolder> _getAllFolders(ProjectFolder folder) {
    final folders = <ProjectFolder>[];

    for (final childFolder in folder.folders) {
      folders.add(childFolder);
      folders.addAll(_getAllFolders(childFolder));
    }
    return folders;
  }

  final CodeLineEditingController codeController = CodeLineEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }


  void _showCreateDialog(){

    debugPrint('SHOW CREATE DIALOG START');

    ProjectFolder targetFolder =
        selectedFolder ?? widget.project.rootFolder;
    
    final folders = [
      widget.project.rootFolder,
      ..._getAllFolders(widget.project.rootFolder),
    ];
    
    final nameController = TextEditingController();
    
    String selectedType = 'Dart File';

    debugPrint('ABOUT TO SHOW CREATE DIALOG');
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Create'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'MyFile',
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Dart File',
                          child: Text('Dart File'),
                        ),
                        DropdownMenuItem(
                          value: 'Folder',
                          child: Text('Folder'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          selectedType = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<ProjectFolder>(
                      initialValue: targetFolder,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      items: folders.map(
                            (folder) {
                          return DropdownMenuItem<ProjectFolder>(
                            value: folder,
                            child: Text(
                              folder == widget.project.rootFolder
                                  ? 'Project Root'
                                  : folder.name,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (folder) {
                        if (folder == null) return;

                        setDialogState(() {
                          targetFolder = folder;
                        });

                        debugPrint(
                          'CREATE TARGET FOLDER: ${folder.path}',
                        );
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Cancel'),
                ),

                FilledButton(
                  onPressed: () async {
                    final name = nameController.text.trim();

                    if (name.isEmpty) {
                      return;
                    }

                    try {
                      final storage = LocalProjectStorage();

                      if (selectedType == 'Dart File') {
                        final file = await storage.createFile(
                          targetFolder.path,
                          name.endsWith('.dart') ? name : '$name.dart',
                        );

                        setState(() {
                          targetFolder.files.add(file);
                        });

                        if (!context.mounted) return;

                        Navigator.of(context).pop();
                      } else if (selectedType == 'Folder') {
                        final folder = await storage.createFolder(
                          targetFolder.path,
                          name);

                        setState((){
                          targetFolder.folders.add(folder);
                        });
                        if (!context.mounted) return;

                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );


  }

  void _createNewFile() {
    final controller = TextEditingController();
    ProjectFolder? targetFolder = selectedFolder ?? widget.project.rootFolder;
    final folders = [
      widget.project.rootFolder,
      ..._getAllFolders(widget.project.rootFolder),
    ];

    showDialog(context: context, builder: (dialogContext) {
      return AlertDialog(
        title:const Text('New File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'File name',
                  hintText: 'example.dart',
                ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<ProjectFolder>(
              initialValue: targetFolder,
                decoration: const InputDecoration(
                  labelText: 'Folder',
                  border: OutlineInputBorder(),
                ),
                items: folders.map(
                    (folder) {
                      return DropdownMenuItem<ProjectFolder>(
                        value: folder,
                          child: Text(
                            folder == widget.project.rootFolder
                                ? 'Project Root'
                                : folder.name,
                          ),
                      );
                    }
                ).toList(),
                onChanged: (folder) {
                if(folder == null) return;

                  targetFolder = folder;

                  debugPrint(
                    'New File Target Folder: '
                        '${folder?.path ?? widget.project.path}',
                  );
                },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed:() {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
          onPressed: () async {
      final fileName = controller.text.trim();

      if (fileName.isEmpty) {
      return;
      }

      try {
      final storage = LocalProjectStorage();

      final folderPath =
          targetFolder?.path;

      debugPrint('Creating File in: ${targetFolder?.path}');

      final file = await storage.createFile(
        folderPath!,
        fileName
      );

      if (!mounted) return;

      Navigator.of(dialogContext).pop();

      setState(() {
      if (selectedFolder != null) {
        targetFolder?.files.add(file);
      }
      });


      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('Created ${file.name}'),
      ),
      );
      } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('Could not create file: $e'),
      ),
      );
      }
      },
      child: const Text('Create'),
      )
        ],
      );
    },
    );
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        activeFile?.name ?? 'No file selected',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.save),
                      tooltip: 'Save',
                      onPressed: activeFile == null
                          ? null
                          : () async {
                        try {
                          final storage = LocalProjectStorage();

                          activeFile!.content = codeController.text;

                          await storage.saveFile(activeFile!);

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File saved'),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Save failed: $e'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
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

                        if (isLoadingFile) return;

                        debugPrint('EDITOR CHANGED: "${value.codeLines.asString(TextLineBreak.lf)}"',
                        );

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
        if (isDrawerOpen) ...[
          Positioned.fill(
            child: GestureDetector(
    onTap: () {
      setState((){
        isDrawerOpen = false;
    });
    },
    child: Container(
    color: Colors.transparent,
    ),
    ),
    ),

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

                    onFolderSelected: (folder) {
                      setState(() {
                        selectedFolder = folder;
                      });

                      debugPrint('SELECTED FOLDER: ${folder.path}');
                    },

                    onFileSelected: (file) {

                      isLoadingFile = true;

                      codeController.text = file.content;
                      activeFile = file;

                      isLoadingFile = false;

                      setState(() {
                        isDrawerOpen = false;
                      });
                    },
                    onToggle: () {
                      setState(() {
                        isDrawerOpen = false;
                      });
                    },
                    onCreate: _showCreateDialog,
                  ),
                ),
              ),
            ),
          ),
        ],

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