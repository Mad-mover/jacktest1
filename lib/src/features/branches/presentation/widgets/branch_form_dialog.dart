import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jacktest1/src/features/branches/domain/branch.dart';
import 'package:jacktest1/src/features/branches/presentation/controllers/branch_controller.dart';

class BranchFormDialog extends HookConsumerWidget {
  const BranchFormDialog({super.key, this.branch});

  final Branch? branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: branch?.name);
    final locationController = useTextEditingController(text: branch?.location);
    final isActive = useState<bool>(branch?.isActive ?? true);

    return AlertDialog(
      title: Text(branch == null ? 'Create Branch' : 'Edit Branch'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Branch Name',
                hintText: 'e.g., Lavington',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location (Optional)',
                hintText: 'e.g., Lavington, Nairobi',
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Active'),
              value: isActive.value,
              onChanged: (value) => isActive.value = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (nameController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Branch name is required')),
              );
              return;
            }

            final newBranch = Branch(
              id: branch?.id,
              name: nameController.text.trim(),
              location: locationController.text.trim().isNotEmpty
                  ? locationController.text.trim()
                  : null,
              isActive: isActive.value,
            );

            if (branch == null) {
              await ref
                  .read(branchControllerProvider.notifier)
                  .addBranch(newBranch);
            } else {
              await ref
                  .read(branchControllerProvider.notifier)
                  .updateBranch(newBranch);
            }
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
