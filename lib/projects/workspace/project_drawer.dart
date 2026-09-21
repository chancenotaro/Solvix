import 'package:flutter/material.dart';
import 'package:solvix/projects/project_folder.dart';
import 'package:solvix/projects/project_file.dart';

class ProjectDrawer extends StatelessWidget {
  final ProjectFolder rootFolder;
  final void Function(ProjectFile file)? onFileSelected;
  final void Function(ProjectFile file)? onFileLongPressed;
  final void Function(ProjectFolder foler)? onFolderSelected;
  final void Function(ProjectFile file)? onFolderLongPressed;

  final VoidCallback onToggle;
  final VoidCallback onCreate;

  const ProjectDrawer({
    super.key,
    required this.rootFolder,
    this.onFileSelected,
    this.onFileLongPressed,
    this.onFolderSelected,
    this.onFolderLongPressed,
    required this.onToggle,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(16, 20, 8, 8),
                  child: Text('PROJECT',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ),
            IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onToggle,
                tooltip: 'Hide project explorer',
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ..._buildFolders(rootFolder.folders),
              ..._buildFiles(rootFolder.files),
            ],
          ),
        ),

        const Divider(height: 1),

        SizedBox(
          height: 48,
          child: Align(
            alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Create',
                onPressed: () {
                    debugPrint('Create Tapped');
                    onCreate();
                },
              ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFolders(List<ProjectFolder> folders) {
    return folders.map((folder) {
      return ExpansionTile(
        leading: const Icon(Icons.folder),
        title: Text(folder.name),
        onExpansionChanged: (expanded) {
          if (expanded) {
            onFolderSelected?.call(folder);
          }
        },
        children: [
          ..._buildFolders(folder.folders),
          ..._buildFiles(folder.files),
        ],
      );
    }).toList();
  }

  List<Widget> _buildFiles(List<ProjectFile> files) {
    return files.map((file) {
      return ListTile(
        leading: const Icon(Icons.insert_drive_file),
        title: Text(file.name),
        onTap: () {
          onFileSelected?.call(file);
        },
        onLongPress: () {
          onFileLongPressed?.call(file);
        },
      );
    }).toList();
  }
}