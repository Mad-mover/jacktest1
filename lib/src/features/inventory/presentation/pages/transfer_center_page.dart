import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:jacktest1/src/features/products/presentation/controllers/product_controller.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_service.dart';

/// Transfer Center - Move inventory between branches
class TransferCenterPage extends ConsumerStatefulWidget {
  const TransferCenterPage({super.key});

  @override
  ConsumerState<TransferCenterPage> createState() => _TransferCenterPageState();
}

class _TransferCenterPageState extends ConsumerState<TransferCenterPage> {
  String? _selectedProductId;
  String? _sourceBranchId;
  String? _destinationBranchId;
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isTransferring = false;
  int _currentStock = 0;

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentStock() async {
    if (_selectedProductId != null && _sourceBranchId != null) {
      final stock = await ref
          .read(inventoryControllerProvider(_selectedProductId!).notifier)
          .getCurrentStock(_selectedProductId!, _sourceBranchId!);
      setState(() {
        _currentStock = stock;
      });
    } else {
      setState(() {
        _currentStock = 0;
      });
    }
  }

  Future<void> _performTransfer() async {
    if (_selectedProductId == null ||
        _sourceBranchId == null ||
        _destinationBranchId == null ||
        _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final quantity = int.tryParse(_quantityController.text);
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid quantity')),
      );
      return;
    }

    setState(() {
      _isTransferring = true;
    });

    try {
      final inventoryService = ref.read(inventoryServiceProvider);
      final result = await inventoryService.recordTransfer(
        productId: _selectedProductId!,
        fromBranchId: _sourceBranchId!,
        toBranchId: _destinationBranchId!,
        quantity: quantity,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Transfer successful! Reference: ${result.referenceId.substring(0, 8)}',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form
        setState(() {
          _quantityController.clear();
          _notesController.clear();
          _selectedProductId = null;
          _sourceBranchId = null;
          _destinationBranchId = null;
          _currentStock = 0;
        });
      }
    } on InsufficientStockException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transfer failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTransferring = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final branchesAsync = ref.watch(branchControllerProvider);
    final productsAsync = ref.watch(productControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to inventory history filtered by transfers
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('View transfer history in Inventory History'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Transfer',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),

                    // Product Selector
                    productsAsync.when(
                      data: (products) {
                        final availableProducts = products
                            .where((p) => p.isAvailable)
                            .toList();
                        if (availableProducts.isEmpty) {
                          return const Text(
                            'No available products found. Please add products first.',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return DropdownButtonFormField<String>(
                          initialValue: _selectedProductId,
                          decoration: const InputDecoration(
                            labelText: 'Product',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.inventory_2),
                          ),
                          items: availableProducts
                              .map(
                                (product) => DropdownMenuItem(
                                  value: product.id,
                                  child: Text(product.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedProductId = value;
                            });
                            _loadCurrentStock();
                          },
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (err, _) => Text('Error loading products: $err'),
                    ),
                    const SizedBox(height: 16),

                    // Source Branch
                    branchesAsync.when(
                      data: (branches) {
                        final availableBranches = branches
                            .where(
                              (b) => b.isActive && b.id != _destinationBranchId,
                            )
                            .toList();
                        if (availableBranches.isEmpty) {
                          return const Text(
                            'No source branches available.',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return DropdownButtonFormField<String>(
                          initialValue: _sourceBranchId,
                          decoration: const InputDecoration(
                            labelText: 'From Branch (Source)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.store),
                          ),
                          items: availableBranches
                              .map(
                                (branch) => DropdownMenuItem(
                                  value: branch.id,
                                  child: Text(branch.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _sourceBranchId = value;
                            });
                            _loadCurrentStock();
                          },
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (err, _) => Text('Error loading branches: $err'),
                    ),
                    const SizedBox(height: 16),

                    // Destination Branch
                    branchesAsync.when(
                      data: (branches) {
                        final availableBranches = branches
                            .where((b) => b.isActive && b.id != _sourceBranchId)
                            .toList();
                        if (availableBranches.isEmpty) {
                          return const Text(
                            'No destination branches available.',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return DropdownButtonFormField<String>(
                          initialValue: _destinationBranchId,
                          decoration: const InputDecoration(
                            labelText: 'To Branch (Destination)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                          items: availableBranches
                              .map(
                                (branch) => DropdownMenuItem(
                                  value: branch.id,
                                  child: Text(branch.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _destinationBranchId = value;
                            });
                          },
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (err, _) => Text('Error loading branches: $err'),
                    ),
                    const SizedBox(height: 16),

                    // Current Stock Display
                    if (_selectedProductId != null && _sourceBranchId != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _currentStock > 0
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _currentStock > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _currentStock > 0
                                  ? Icons.check_circle
                                  : Icons.warning,
                              color: _currentStock > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Current Stock at Source: $_currentStock units',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _currentStock > 0
                                    ? Colors.green.shade900
                                    : Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Quantity Input
                    TextField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                        suffixText: 'units',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),

                    // Notes
                    TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    // Transfer Button
                    FilledButton.icon(
                      onPressed: _isTransferring ? null : _performTransfer,
                      icon: _isTransferring
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.arrow_forward),
                      label: Text(
                        _isTransferring ? 'Transferring...' : 'Transfer',
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'How Transfers Work',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Two inventory movements are created atomically\n'
                      '• Stock is deducted from source branch\n'
                      '• Stock is added to destination branch\n'
                      '• Both movements share the same reference ID for tracking\n'
                      '• Transfer validation prevents negative stock',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
