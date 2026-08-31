import 'package:flutter/material.dart';
import 'package:solvix/projects/project_folder.dart';
import 'package:solvix/projects/project_file.dart';

class ProjectDrawer extends StatelessWidget {
  final ProjectFolder rootFolder;
  final void Function(ProjectFile file)? onFileSelected;
  final VoidCallback onToggle;
  final VoidCallback onNewFile;

  const ProjectDrawer({
    super.key,
    required this.rootFolder,
    this.onFileSelected,
    required this.onToggle,
    required this.onNewFile,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 8, 8),
                child: Text(
                  'PROJECT',
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

        ..._buildFolders(rootFolder.folders),
        ..._buildFiles(rootFolder.files),

        ListTile(
          leading: const Icon(Icons.add),
            title: const Text('New File'),
          onTap: () {
            //onNewFile
            debugPrint('New File Tapped');
            onNewFile();
          },
        )
      ],
    );

  }

  List<Widget> _buildFolders(List<ProjectFolder> folders) {
    return folders.map((folder) {
      return ExpansionTile(
        leading: const Icon(Icons.folder),
        title: Text(folder.name),
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
      );
    }).toList();
  }
}