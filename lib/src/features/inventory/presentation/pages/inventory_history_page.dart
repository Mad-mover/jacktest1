import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:jacktest1/src/features/inventory/domain/movement_type.dart';
import 'package:intl/intl.dart';

/// Inventory Movement History Page
/// Displays filterable inventory movement history with running balance
class InventoryHistoryPage extends ConsumerStatefulWidget {
  const InventoryHistoryPage({super.key});

  @override
  ConsumerState<InventoryHistoryPage> createState() =>
      _InventoryHistoryPageState();
}

class _InventoryHistoryPageState extends ConsumerState<InventoryHistoryPage> {
  String? _selectedProductId;
  String? _selectedBranchId;
  DateTime? _startDate;
  DateTime? _endDate;
  MovementType? _selectedMovementType;

  @override
  void initState() {
    super.initState();
    // Load all movements on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movementHistoryControllerProvider.notifier).loadHistory();
    });
  }

  void _applyFilters() {
    ref
        .read(movementHistoryControllerProvider.notifier)
        .loadHistory(
          productId: _selectedProductId,
          branchId: _selectedBranchId,
          startDate: _startDate,
          endDate: _endDate,
          movementType: _selectedMovementType?.value,
        );
  }

  @override
  Widget build(BuildContext context) {
    final movementsAsync = ref.watch(movementHistoryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Movement History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _applyFilters),
        ],
      ),
      body: movementsAsync.when(
        data: (movements) {
          if (movements.isEmpty) {
            return const Center(child: Text('No movement history found'));
          }

          // Calculate running balance
          final movementsWithBalance = ref
              .read(movementHistoryControllerProvider.notifier)
              .calculateRunningBalance(movements);

          return ListView(
            children: [
              _buildFilterChips(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Date/Time')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Branch')),
                    DataColumn(label: Text('Change')),
                    DataColumn(label: Text('Balance')),
                    DataColumn(label: Text('Reference')),
                    DataColumn(label: Text('Notes')),
                  ],
                  rows: movementsWithBalance
                      .reversed // Show newest first in table
                      .map((item) => _buildDataRow(item))
                      .toList(),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: $error'),
              TextButton(onPressed: _applyFilters, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final hasFilters =
        _selectedProductId != null ||
        _selectedBranchId != null ||
        _startDate != null ||
        _endDate != null ||
        _selectedMovementType != null;

    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        children: [
          if (_selectedMovementType != null)
            Chip(
              label: Text(_selectedMovementType!.displayName),
              onDeleted: () {
                setState(() => _selectedMovementType = null);
                _applyFilters();
              },
            ),
          if (_startDate != null || _endDate != null)
            Chip(
              label: Text(
                'Date: ${_startDate != null ? DateFormat.yMd().format(_startDate!) : 'Any'} - ${_endDate != null ? DateFormat.yMd().format(_endDate!) : 'Any'}',
              ),
              onDeleted: () {
                setState(() {
                  _startDate = null;
                  _endDate = null;
                });
                _applyFilters();
              },
            ),
          TextButton.icon(
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear All'),
            onPressed: () {
              setState(() {
                _selectedProductId = null;
                _selectedBranchId = null;
                _startDate = null;
                _endDate = null;
                _selectedMovementType = null;
              });
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(MovementWithBalance item) {
    final movement = item.movement;
    final isPositive = movement.quantityChange > 0;

    return DataRow(
      cells: [
        DataCell(
          Text(
            movement.createdAt != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(movement.createdAt!)
                : 'N/A',
          ),
        ),
        DataCell(_buildMovementTypeBadge(movement.movementType)),
        DataCell(Text(movement.productId.substring(0, 8))), // Show short ID
        DataCell(Text(movement.branchId.substring(0, 8))), // Show short ID
        DataCell(
          Text(
            movement.quantityChange.toString(),
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Text(
            item.runningBalance.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Text(
            '${movement.referenceType ?? 'N/A'}: ${movement.referenceId?.substring(0, 8) ?? 'N/A'}',
          ),
        ),
        DataCell(Text(movement.notes ?? '')),
      ],
    );
  }

  Widget _buildMovementTypeBadge(MovementType type) {
    Color color;
    switch (type) {
      case MovementType.purchaseIn:
      case MovementType.transferIn:
      case MovementType.customerReturn:
      case MovementType.stockAdjustmentIn:
        color = Colors.green;
        break;
      case MovementType.saleOut:
      case MovementType.transferOut:
      case MovementType.supplierReturn:
      case MovementType.stockAdjustmentOut:
        color = Colors.orange;
        break;
      case MovementType.damagedOut:
      case MovementType.expiredOut:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        type.displayName,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Movement History'),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Movement Type Filter
                DropdownButtonFormField<MovementType>(
                  initialValue: _selectedMovementType,
                  decoration: const InputDecoration(
                    labelText: 'Movement Type',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Types'),
                    ),
                    ...MovementType.values.map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.displayName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedMovementType = value);
                  },
                ),
                const SizedBox(height: 16),

                // Date Range
                ListTile(
                  title: const Text('Start Date'),
                  subtitle: Text(
                    _startDate != null
                        ? DateFormat.yMd().format(_startDate!)
                        : 'Not set',
                  ),
                  trailing: _startDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() => _startDate = null);
                          },
                        )
                      : null,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _startDate = date);
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Date'),
                  subtitle: Text(
                    _endDate != null
                        ? DateFormat.yMd().format(_endDate!)
                        : 'Not set',
                  ),
                  trailing: _endDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() => _endDate = null);
                          },
                        )
                      : null,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: _startDate ?? DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _endDate = date);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {}); // Update parent state
              _applyFilters();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
