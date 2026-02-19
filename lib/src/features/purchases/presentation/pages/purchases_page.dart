import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase_item.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase_payment.dart';
import 'package:jacktest1/src/features/purchases/domain/payment_status.dart';
import 'package:jacktest1/src/features/purchases/presentation/controllers/supplier_controller.dart';
import 'package:jacktest1/src/features/purchases/data/purchase_repository.dart';
import 'package:jacktest1/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:jacktest1/src/features/products/presentation/controllers/product_controller.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:intl/intl.dart';

// Providers
final purchaseRepositoryProvider = Provider((ref) => PurchaseRepository());

final purchasesProvider = FutureProvider<List<Purchase>>((ref) {
  return ref.read(purchaseRepositoryProvider).getPurchases();
});

/// Purchases List Page
class PurchasesPage extends ConsumerStatefulWidget {
  const PurchasesPage({super.key});

  @override
  ConsumerState<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends ConsumerState<PurchasesPage> {
  String? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final purchasesAsync = ref.watch(purchasesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _statusFilter = value == 'all' ? null : value;
              });
              ref.invalidate(purchasesProvider);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('All')),
              const PopupMenuItem(value: 'unpaid', child: Text('Unpaid')),
              const PopupMenuItem(value: 'partial', child: Text('Partial')),
              const PopupMenuItem(value: 'paid', child: Text('Paid')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPurchaseDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Purchase'),
      ),
      body: purchasesAsync.when(
        data: (purchases) {
          final filtered = _statusFilter == null
              ? purchases
              : purchases
                    .where((p) => p.paymentStatus.value == _statusFilter)
                    .toList();

          if (filtered.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No purchases found'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final purchase = filtered[index];
              return _PurchaseCard(purchase: purchase);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showAddPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddPurchaseDialog(),
    );
  }
}

class _PurchaseCard extends ConsumerWidget {
  const _PurchaseCard({required this.purchase});
  final Purchase purchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(supplierControllerProvider);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(purchase.paymentStatus),
          child: const Icon(Icons.receipt_long, color: Colors.white),
        ),
        title: Text(
          purchase.invoiceNumber ?? 'No Invoice #',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            suppliersAsync.when(
              data: (suppliers) {
                final supplier = suppliers
                    .where((s) => s.id == purchase.supplierId)
                    .firstOrNull;
                return Text(supplier?.name ?? 'Unknown Supplier');
              },
              loading: () => const Text('Loading...'),
              error: (_, __) => const Text('Error loading supplier'),
            ),
            Text(DateFormat.yMd().format(purchase.purchaseDate)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              NumberFormat.currency(
                locale: 'en_KE',
                symbol: 'KES ',
                decimalDigits: 2,
              ).format(purchase.totalAmount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _PaymentStatusBadge(status: purchase.paymentStatus),
          ],
        ),
        onTap: () => _showPurchaseDetails(context, ref, purchase),
      ),
    );
  }

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return Colors.green;
      case PaymentStatus.partial:
        return Colors.orange;
      case PaymentStatus.unpaid:
        return Colors.red;
    }
  }

  void _showPurchaseDetails(
    BuildContext context,
    WidgetRef ref,
    Purchase purchase,
  ) {
    showDialog(
      context: context,
      builder: (context) => PurchaseDetailsDialog(purchase: purchase),
    );
  }
}

class _PaymentStatusBadge extends StatelessWidget {
  const _PaymentStatusBadge({required this.status});
  final PaymentStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case PaymentStatus.paid:
        color = Colors.green;
        break;
      case PaymentStatus.partial:
        color = Colors.orange;
        break;
      case PaymentStatus.unpaid:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ================================================
// ADD PURCHASE DIALOG
// ================================================

class AddPurchaseDialog extends ConsumerStatefulWidget {
  const AddPurchaseDialog({super.key});

  @override
  ConsumerState<AddPurchaseDialog> createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends ConsumerState<AddPurchaseDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSupplierId;
  String? _selectedBranchId;
  DateTime _purchaseDate = DateTime.now();
  final _invoiceController = TextEditingController();
  final _notesController = TextEditingController();
  final List<_PurchaseItemInput> _items = [];
  bool _isSaving = false;

  @override
  void dispose() {
    _invoiceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add(_PurchaseItemInput());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  double get _totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one item')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final purchase = Purchase(
        supplierId: _selectedSupplierId!,
        branchId: _selectedBranchId!,
        purchaseDate: _purchaseDate,
        invoiceNumber: _invoiceController.text.isNotEmpty
            ? _invoiceController.text
            : null,
        totalAmount: _totalAmount,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      final items = _items
          .map(
            (item) => PurchaseItem(
              purchaseId: '', // Will be set by repository
              productId: item.productId!,
              quantity: item.quantity,
              unitPrice: item.unitPrice,
              totalPrice: item.totalPrice,
            ),
          )
          .toList();

      final purchaseRepo = ref.read(purchaseRepositoryProvider);
      final inventoryService = ref.read(inventoryServiceProvider);

      await purchaseRepo.createCompletePurchase(
        purchase: purchase,
        items: items,
        inventoryService: inventoryService,
      );

      if (mounted) {
        ref.invalidate(purchasesProvider);
        // Invalidate inventory and cost for all purchased products to refresh stock & cost display
        for (var item in items) {
          ref.invalidate(inventoryControllerProvider(item.productId));
          ref.invalidate(productLastCostProvider(item.productId));
        }
        ref.invalidate(
          productControllerProvider,
        ); // Optional: refresh products list if needed

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchase created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(supplierControllerProvider);
    final branchesAsync = ref.watch(branchControllerProvider);
    final productsAsync = ref.watch(productControllerProvider);

    return Dialog(
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('New Purchase'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Supplier
                suppliersAsync.when(
                  data: (suppliers) {
                    if (suppliers.isEmpty) {
                      return const Text(
                        'No suppliers available. Please add a supplier first.',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return DropdownButtonFormField<String>(
                      initialValue: _selectedSupplierId,
                      decoration: const InputDecoration(
                        labelText: 'Supplier',
                        border: OutlineInputBorder(),
                      ),
                      items: suppliers
                          .map(
                            (s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(s.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _selectedSupplierId = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Please select a supplier' : null,
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('Error loading suppliers'),
                ),
                const SizedBox(height: 16),

                // Branch
                branchesAsync.when(
                  data: (branches) {
                    final activeBranches = branches
                        .where((b) => b.isActive)
                        .toList();
                    if (activeBranches.isEmpty) {
                      return const Text(
                        'No active branches available. Please add a branch first.',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return DropdownButtonFormField<String>(
                      initialValue: _selectedBranchId,
                      decoration: const InputDecoration(
                        labelText: 'Branch',
                        border: OutlineInputBorder(),
                      ),
                      items: activeBranches
                          .map(
                            (b) => DropdownMenuItem(
                              value: b.id,
                              child: Text(b.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _selectedBranchId = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Please select a branch' : null,
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('Error loading branches'),
                ),
                const SizedBox(height: 16),

                // Invoice Number
                TextFormField(
                  controller: _invoiceController,
                  decoration: const InputDecoration(
                    labelText: 'Invoice Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Purchase Date
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Purchase Date'),
                  subtitle: Text(DateFormat.yMd().format(_purchaseDate)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _purchaseDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _purchaseDate = date;
                      });
                    }
                  },
                ),
                const Divider(),

                // Items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _addItem,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item'),
                    ),
                  ],
                ),
                ...List.generate(_items.length, (index) {
                  return _PurchaseItemRow(
                    key: ValueKey(index),
                    item: _items[index],
                    productsAsync: productsAsync,
                    onRemove: () => _removeItem(index),
                    onChanged: () => setState(() {}),
                  );
                }),
                const SizedBox(height: 16),

                // Total
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'en_KE',
                          symbol: 'KES ',
                          decimalDigits: 2,
                        ).format(_totalAmount),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // Save Button
                FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const CircularProgressIndicator()
                      : const Text('Create Purchase'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchaseItemInput {
  String? productId;
  int quantity = 1;
  double unitPrice = 0.0;

  double get totalPrice => quantity * unitPrice;
}

class _PurchaseItemRow extends StatefulWidget {
  const _PurchaseItemRow({
    super.key,
    required this.item,
    required this.productsAsync,
    required this.onRemove,
    required this.onChanged,
  });

  final _PurchaseItemInput item;
  final AsyncValue<List<Product>> productsAsync;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  @override
  State<_PurchaseItemRow> createState() => _PurchaseItemRowState();
}

class _PurchaseItemRowState extends State<_PurchaseItemRow> {
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    _priceController = TextEditingController(
      text: widget.item.unitPrice.toString(),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: widget.productsAsync.when(
                    data: (products) {
                      if (products.isEmpty) {
                        return const Text(
                          'No products available. Please add products first.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        );
                      }
                      return DropdownButtonFormField<String>(
                        initialValue: widget.item.productId,
                        decoration: const InputDecoration(
                          labelText: 'Product',
                          isDense: true,
                        ),
                        items: products
                            .map(
                              (p) => DropdownMenuItem(
                                value: p.id,
                                child: Text(p.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          widget.item.productId = value;
                          widget.onChanged();
                        },
                      );
                    },
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) => const Text('Error'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      widget.item.quantity = int.tryParse(value) ?? 1;
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Unit Price',
                      isDense: true,
                      prefixText: 'KES ',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.item.unitPrice = double.tryParse(value) ?? 0.0;
                      widget.onChanged();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            Text(
              'Total: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(widget.item.totalPrice)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================
// PURCHASE DETAILS DIALOG
// ================================================

class PurchaseDetailsDialog extends ConsumerStatefulWidget {
  const PurchaseDetailsDialog({super.key, required this.purchase});
  final Purchase purchase;

  @override
  ConsumerState<PurchaseDetailsDialog> createState() =>
      _PurchaseDetailsDialogState();
}

class _PurchaseDetailsDialogState extends ConsumerState<PurchaseDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(
      FutureProvider(
        (ref) => ref
            .read(purchaseRepositoryProvider)
            .getPurchaseItems(widget.purchase.id!),
      ),
    );
    final paymentsAsync = ref.watch(
      FutureProvider(
        (ref) => ref
            .read(purchaseRepositoryProvider)
            .getPurchasePayments(widget.purchase.id!),
      ),
    );

    return Dialog(
      child: Container(
        width: 700,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Purchase ${widget.purchase.invoiceNumber ?? "Details"}',
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Payment Status & Amounts
              Row(
                children: [
                  _PaymentStatusBadge(status: widget.purchase.paymentStatus),
                  const Spacer(),
                  if (widget.purchase.paymentStatus != PaymentStatus.paid)
                    FilledButton.icon(
                      onPressed: () => _showPaymentDialog(context),
                      icon: const Icon(Icons.payment),
                      label: const Text('Record Payment'),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Amount Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(widget.purchase.totalAmount)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Paid: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(widget.purchase.paidAmount)}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Text(
                        'Balance: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(widget.purchase.totalAmount - widget.purchase.paidAmount)}',
                        style: TextStyle(
                          color:
                              widget.purchase.paymentStatus ==
                                  PaymentStatus.paid
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 24),
                      Text(
                        'Date: ${DateFormat.yMd().format(widget.purchase.purchaseDate)}',
                      ),
                      if (widget.purchase.notes != null)
                        Text('Notes: ${widget.purchase.notes}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Purchase Items
              const Text(
                'Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              itemsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No items'),
                      ),
                    );
                  }
                  return Column(
                    children: items.map((item) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            'Product: ${item.productId.substring(0, 8)}...',
                          ),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(item.unitPrice)} each',
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'en_KE',
                                  symbol: 'KES ',
                                  decimalDigits: 2,
                                ).format(item.totalPrice),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Error loading items: $err'),
              ),
              const SizedBox(height: 16),

              // Payment History
              const Text(
                'Payment History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              paymentsAsync.when(
                data: (payments) {
                  if (payments.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No payments recorded yet'),
                      ),
                    );
                  }
                  return Column(
                    children: payments.map((payment) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.payment,
                            color: Colors.green,
                          ),
                          title: Text(
                            NumberFormat.currency(
                              locale: 'en_KE',
                              symbol: 'KES ',
                              decimalDigits: 2,
                            ).format(payment.amount),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMd().format(payment.paymentDate),
                              ),
                              if (payment.paymentMethod != null)
                                Text('Method: ${payment.paymentMethod}'),
                              if (payment.referenceNumber != null)
                                Text('Ref: ${payment.referenceNumber}'),
                            ],
                          ),
                          trailing: payment.notes != null
                              ? Tooltip(
                                  message: payment.notes!,
                                  child: const Icon(Icons.info_outline),
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Error loading payments: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RecordPaymentDialog(purchase: widget.purchase),
    ).then((recorded) {
      if (recorded == true) {
        // Refresh the purchase data
        setState(() {});
        ref.invalidate(purchasesProvider);
      }
    });
  }
}

// ================================================
// RECORD PAYMENT DIALOG
// ================================================

class RecordPaymentDialog extends ConsumerStatefulWidget {
  const RecordPaymentDialog({super.key, required this.purchase});
  final Purchase purchase;

  @override
  ConsumerState<RecordPaymentDialog> createState() =>
      _RecordPaymentDialogState();
}

class _RecordPaymentDialogState extends ConsumerState<RecordPaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _paymentDate = DateTime.now();
  String _paymentMethod = 'cash';
  bool _isSaving = false;

  double get _balance =>
      widget.purchase.totalAmount - widget.purchase.paidAmount;

  @override
  void initState() {
    super.initState();
    // Default to full balance
    _amountController.text = _balance.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final payment = PurchasePayment(
        purchaseId: widget.purchase.id!,
        amount: double.parse(_amountController.text),
        paymentDate: _paymentDate,
        paymentMethod: _paymentMethod,
        referenceNumber: _referenceController.text.isNotEmpty
            ? _referenceController.text
            : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      await ref.read(purchaseRepositoryProvider).createPurchasePayment(payment);

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment recorded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Record Payment'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Due
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Text(
                  'Balance Due: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ', decimalDigits: 2).format(_balance)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Amount
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Payment Amount',
                  border: const OutlineInputBorder(),
                  prefixText: 'KES ',
                  suffixIcon: TextButton(
                    onPressed: () {
                      _amountController.text = _balance.toStringAsFixed(2);
                    },
                    child: const Text('Full'),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter valid amount';
                  }
                  if (amount > _balance) {
                    return 'Amount exceeds balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Payment Date
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Payment Date'),
                subtitle: Text(DateFormat.yMd().format(_paymentDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _paymentDate,
                    firstDate: widget.purchase.purchaseDate,
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _paymentDate = date;
                    });
                  }
                },
              ),
              const SizedBox(height: 8),

              // Payment Method
              DropdownButtonFormField<String>(
                initialValue: _paymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'cash', child: Text('Cash')),
                  DropdownMenuItem(
                    value: 'bank_transfer',
                    child: Text('Bank Transfer'),
                  ),
                  DropdownMenuItem(value: 'check', child: Text('Check')),
                  DropdownMenuItem(
                    value: 'credit_card',
                    child: Text('Credit Card'),
                  ),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Reference Number
              TextFormField(
                controller: _referenceController,
                decoration: const InputDecoration(
                  labelText: 'Reference Number (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'Transaction ID, Check #, etc.',
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Record Payment'),
        ),
      ],
    );
  }
}
