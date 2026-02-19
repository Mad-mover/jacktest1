import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_movement.dart';
import 'package:jacktest1/src/features/inventory/domain/movement_type.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:intl/intl.dart';

/// Transfer History Page - Shows all transfers between branches
class TransferHistoryPage extends ConsumerStatefulWidget {
  const TransferHistoryPage({super.key});

  @override
  ConsumerState<TransferHistoryPage> createState() =>
      _TransferHistoryPageState();
}

class _TransferHistoryPageState extends ConsumerState<TransferHistoryPage> {
  String? _selectedProductId;
  String? _selectedBranchId;

  @override
  Widget build(BuildContext context) {
    // Get all transfer movements (transfer_in and transfer_out)
    final movementsAsync = ref.watch(
      FutureProvider((ref) async {
        final repo = ref.read(inventoryMovementRepositoryProvider);

        // Get all movements
        final allMovements = await repo.getMovementHistory(
          productId: _selectedProductId,
          branchId: _selectedBranchId,
        );

        // Filter only transfer movements
        return allMovements
            .where(
              (m) =>
                  m.movementType == MovementType.transferIn ||
                  m.movementType == MovementType.transferOut,
            )
            .toList();
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: movementsAsync.when(
        data: (movements) {
          if (movements.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swap_horiz, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No transfers found'),
                  SizedBox(height: 8),
                  Text(
                    'Use the Transfer Center to move items between branches',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Group transfers by reference_id
          final Map<String, List<InventoryMovement>> groupedTransfers = {};
          for (final movement in movements) {
            final refId = movement.referenceId ?? 'no-ref';
            groupedTransfers.putIfAbsent(refId, () => []);
            groupedTransfers[refId]!.add(movement);
          }

          // Sort by date (newest first)
          final sortedRefs = groupedTransfers.keys.toList()
            ..sort((a, b) {
              final aDate =
                  groupedTransfers[a]!.first.createdAt ?? DateTime.now();
              final bDate =
                  groupedTransfers[b]!.first.createdAt ?? DateTime.now();
              return bDate.compareTo(aDate);
            });

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: sortedRefs.length,
            itemBuilder: (context, index) {
              final refId = sortedRefs[index];
              final transferPair = groupedTransfers[refId]!;

              // Find the out and in movements
              final outMovement = transferPair.firstWhere(
                (m) => m.movementType == MovementType.transferOut,
                orElse: () => transferPair.first,
              );
              final inMovement = transferPair.firstWhere(
                (m) => m.movementType == MovementType.transferIn,
                orElse: () => transferPair.first,
              );

              return _TransferCard(
                transferOut: outMovement,
                transferIn: inMovement,
                referenceId: refId,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $err'),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Transfers'),
        content: const Text('Filter options coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _TransferCard extends StatelessWidget {
  const _TransferCard({
    required this.transferOut,
    required this.transferIn,
    required this.referenceId,
  });

  final InventoryMovement transferOut;
  final InventoryMovement transferIn;
  final String referenceId;

  @override
  Widget build(BuildContext context) {
    final date = transferOut.createdAt ?? DateTime.now();
    final quantity = transferOut.quantityChange.abs();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.swap_horiz, color: Colors.white),
        ),
        title: Text(
          'Transfer: $quantity units',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${transferOut.productId.substring(0, 8)}...',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              DateFormat.yMd().add_jm().format(date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.expand_more),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Transfer Details
                Row(
                  children: [
                    Expanded(
                      child: _BranchBadge(
                        branchId: transferOut.branchId,
                        label: 'From',
                        icon: Icons.arrow_upward,
                        color: Colors.red,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, size: 32),
                    Expanded(
                      child: _BranchBadge(
                        branchId: transferIn.branchId,
                        label: 'To',
                        icon: Icons.arrow_downward,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quantity
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity Transferred:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$quantity units',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Reference ID
                Text(
                  'Reference ID: $referenceId',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontFamily: 'monospace',
                  ),
                ),

                // Notes
                if (transferOut.notes != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notes:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transferOut.notes!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],

                // Created By
                if (transferOut.createdBy != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'By: ${transferOut.createdBy}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BranchBadge extends StatelessWidget {
  const _BranchBadge({
    required this.branchId,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String branchId;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                branchId.substring(0, 8),
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
