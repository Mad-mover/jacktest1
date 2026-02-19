import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';

/// ⚠️ DEPRECATED - This dialog is deprecated in the new ledger-based system
///
/// Stock can no longer be edited directly. Instead, use the InventoryService to:
/// - recordPurchase() for stock coming in
/// - recordSale() for stock going out
/// - recordAdjustment() for manual corrections
/// - recordTransfer() for branch-to-branch movements
///
/// See usage_guide.md for examples of how to use the new system.
///
/// This widget is kept temporarily for reference but should not be used.
class StockManagementDialog extends ConsumerWidget {
  const StockManagementDialog({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('Manage Stock: ${product.name}'),
      content: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Direct Stock Editing Disabled',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('This system now uses an audit-trail based inventory ledger.'),
            SizedBox(height: 16),
            Text(
              'To change stock, you must record the source of the change:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Purchase orders (stock coming in)'),
            Text('• Sales (stock going out)'),
            Text('• Transfers (between branches)'),
            Text('• Adjustments (manual corrections)'),
            Text('• Returns (customer/supplier)'),
            SizedBox(height: 16),
            Text(
              'See the usage guide in the artifacts folder for examples.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Understood'),
        ),
      ],
    );
  }
}
