import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jacktest1/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:jacktest1/src/features/products/presentation/controllers/product_controller.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';
import 'package:jacktest1/src/features/sales/domain/sale.dart';
import 'package:jacktest1/src/features/sales/domain/sale_item.dart';
import 'package:jacktest1/src/features/sales/domain/cylinder_return.dart';
import 'package:jacktest1/src/features/sales/domain/customer.dart';
import 'package:jacktest1/src/features/sales/domain/rider.dart';
import 'package:jacktest1/src/features/sales/domain/payment_method.dart';
import 'package:jacktest1/src/features/sales/presentation/controllers/sale_controller.dart';

// ─────────────────────────────────────────────────────────────
// Local form state helpers
// ─────────────────────────────────────────────────────────────

class _CartEntry {
  String? productId;
  String productName = '';
  String productCategory = '';
  int quantity = 1;
  double unitPrice = 0.0;

  double get totalPrice => quantity * unitPrice;
  bool get isCylinder => productCategory == 'LPG Cylinder';
}

class _ReturnEntry {
  String? returnedProductId;
  String returnedProductName = '';
  int quantity;
  bool notReturned = false;

  _ReturnEntry({
    required this.returnedProductId,
    required this.returnedProductName,
    required this.quantity,
  });
}

// ─────────────────────────────────────────────────────────────
// NewSaleScreen
// ─────────────────────────────────────────────────────────────

class NewSaleScreen extends ConsumerStatefulWidget {
  const NewSaleScreen({super.key});

  @override
  ConsumerState<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends ConsumerState<NewSaleScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  // Form state
  String? _selectedBranchId;
  String? _selectedBranchName;
  Customer? _selectedCustomer; // null = Cash Sale
  Rider? _selectedRider; // null = No Rider
  final List<_CartEntry> _cart = [];
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  String _paymentReference = '';
  final List<_ReturnEntry> _returns = [];

  // Result
  bool _showSuccess = false;
  Sale? _createdSale;

  static const int _totalSteps = 7;

  final _currencyFmt = NumberFormat.currency(
    locale: 'en_KE',
    symbol: 'KES ',
    decimalDigits: 2,
  );

  bool get _hasCylinderItems =>
      _cart.any((e) => e.isCylinder && e.quantity > 0);

  double get _cartTotal => _cart.fold(0.0, (sum, e) => sum + e.totalPrice);

  List<_CartEntry> get _cylinderItems =>
      _cart.where((e) => e.isCylinder).toList();

  // ─────────────────────
  // Navigation
  // ─────────────────────

  void _goTo(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    int next = _currentStep + 1;
    // Skip cylinder returns step (index 5) if no cylinder items
    if (next == 5 && !_hasCylinderItems) next = 6;
    if (next < _totalSteps) {
      if (next == 5) _buildReturnEntries();
      _goTo(next);
    }
  }

  void _back() {
    int prev = _currentStep - 1;
    if (prev == 5 && !_hasCylinderItems) prev = 4;
    if (prev >= 0) _goTo(prev);
  }

  void _buildReturnEntries() {
    _returns.clear();
    for (final entry in _cylinderItems) {
      _returns.add(
        _ReturnEntry(
          returnedProductId: entry.productId,
          returnedProductName: entry.productName,
          quantity: entry.quantity,
        ),
      );
    }
  }

  // ─────────────────────
  // Save
  // ─────────────────────

  Future<void> _confirmSale() async {
    final items = _cart
        .map(
          (e) => SaleItem(
            saleId: '',
            productId: e.productId!,
            quantity: e.quantity,
            unitPrice: e.unitPrice,
            totalPrice: e.totalPrice,
          ),
        )
        .toList();

    final returns = _returns
        .where((r) => !r.notReturned && r.returnedProductId != null)
        .map(
          (r) => CylinderReturn(
            saleId: '',
            returnedProductId: r.returnedProductId!,
            quantity: r.quantity,
          ),
        )
        .toList();

    final sale = Sale(
      branchId: _selectedBranchId!,
      customerId: _selectedCustomer?.id,
      riderId: _selectedRider?.id,
      saleDate: DateTime.now(),
      totalAmount: _cartTotal,
      paymentMethod: _paymentMethod,
      paymentReference:
          _paymentMethod.requiresReference && _paymentReference.isNotEmpty
          ? _paymentReference
          : null,
    );

    final created = await ref
        .read(saleControllerProvider.notifier)
        .createSale(sale: sale, items: items, cylinderReturns: returns);

    if (created != null && mounted) {
      setState(() {
        _createdSale = created;
        _showSuccess = true;
      });
    } else {
      final err = ref.read(saleControllerProvider).error;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $err'), backgroundColor: Colors.red),
        );
      }
    }
  }

  // ─────────────────────
  // Build
  // ─────────────────────

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) {
      return _SaleSuccessView(
        sale: _createdSale!,
        cart: _cart,
        returns: _returns,
        branchName: _selectedBranchName ?? '',
        customerName: _selectedCustomer?.name ?? 'Cash Sale',
        riderName: _selectedRider?.name ?? 'No Rider',
        currencyFmt: _currencyFmt,
        onDone: () => context.go('/'),
      );
    }

    final saleState = ref.watch(saleControllerProvider);
    final isSaving = saleState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (_currentStep > 0) {
              _back();
            } else {
              context.pop();
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            backgroundColor: Colors.grey.shade200,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Step label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  _stepLabel(_currentStep),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Step ${_currentStep + 1} of $_totalSteps',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Steps
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _Step1Branch(),
                _Step2Customer(),
                _Step3Rider(),
                _Step4Cart(),
                _Step5Payment(),
                _Step6Returns(),
                _Step7Review(isSaving: isSaving),
              ],
            ),
          ),

          // Bottom nav
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    OutlinedButton.icon(
                      onPressed: _back,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                  const Spacer(),
                  if (_currentStep < _totalSteps - 1)
                    FilledButton.icon(
                      onPressed: _canProceed() ? _next : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next'),
                    )
                  else
                    FilledButton.icon(
                      onPressed: isSaving || !_canProceed()
                          ? null
                          : _confirmSale,
                      icon: isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_circle),
                      label: const Text('Confirm Sale'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _stepLabel(int step) {
    switch (step) {
      case 0:
        return 'Select Branch';
      case 1:
        return 'Select Customer';
      case 2:
        return 'Select Rider';
      case 3:
        return 'Add Items';
      case 4:
        return 'Payment';
      case 5:
        return 'Cylinder Returns';
      case 6:
        return 'Review & Confirm';
      default:
        return '';
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedBranchId != null;
      case 1:
        return true; // Customer optional (cash sale)
      case 2:
        return true; // Rider optional
      case 3:
        return _cart.isNotEmpty && _cart.every((e) => e.productId != null);
      case 4:
        if (_paymentMethod.requiresReference) {
          return _paymentReference.isNotEmpty;
        }
        return true;
      case 5:
        return true;
      case 6:
        return true;
      default:
        return true;
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Step Widgets (inner)  — using closures over state
  // ─────────────────────────────────────────────────────────────

  Widget _Step1Branch() {
    final branchesAsync = ref.watch(branchControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: branchesAsync.when(
        data: (branches) {
          final active = branches.where((b) => b.isActive).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Which branch is making this sale?'),
              const SizedBox(height: 16),
              ...active.map(
                (b) => RadioListTile<String>(
                  value: b.id!,
                  groupValue: _selectedBranchId,
                  title: Text(b.name),
                  subtitle: b.location != null ? Text(b.location!) : null,
                  onChanged: (v) => setState(() {
                    _selectedBranchId = v;
                    _selectedBranchName = b.name;
                  }),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading branches: $e')),
      ),
    );
  }

  Widget _Step2Customer() {
    return _CustomerStep(
      selected: _selectedCustomer,
      onSelected: (c) => setState(() => _selectedCustomer = c),
    );
  }

  Widget _Step3Rider() {
    final ridersAsync = ref.watch(activeRidersProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ridersAsync.when(
        data: (riders) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a rider (optional):'),
            const SizedBox(height: 8),
            RadioListTile<Rider?>(
              value: null,
              groupValue: _selectedRider,
              title: const Text('No Rider'),
              onChanged: (v) => setState(() => _selectedRider = null),
            ),
            ...riders.map(
              (r) => RadioListTile<Rider?>(
                value: r,
                groupValue: _selectedRider,
                title: Text(r.name),
                subtitle: r.phone != null ? Text(r.phone!) : null,
                onChanged: (v) => setState(() => _selectedRider = v),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('No riders found')),
      ),
    );
  }

  Widget _Step4Cart() {
    final productsAsync = ref.watch(productControllerProvider);
    return Column(
      children: [
        Expanded(
          child: productsAsync.when(
            data: (products) => _CartView(
              cart: _cart,
              products: products,
              branchId: _selectedBranchId,
              currencyFmt: _currencyFmt,
              onCartChanged: () => setState(() {}),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                _currencyFmt.format(_cartTotal),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _Step5Payment() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total: ${_currencyFmt.format(_cartTotal)}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Payment Method:'),
          const SizedBox(height: 8),
          ...PaymentMethod.values.map(
            (m) => RadioListTile<PaymentMethod>(
              value: m,
              groupValue: _paymentMethod,
              title: Text(m.displayName),
              onChanged: (v) => setState(() {
                _paymentMethod = v!;
                _paymentReference = '';
              }),
            ),
          ),
          if (_paymentMethod.requiresReference) ...[
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _paymentReference,
              decoration: InputDecoration(
                labelText: _paymentMethod == PaymentMethod.cheque
                    ? 'Cheque Number'
                    : 'Transaction Reference',
                border: const OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _paymentReference = v),
            ),
          ],
        ],
      ),
    );
  }

  Widget _Step6Returns() {
    final productsAsync = ref.watch(productControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: productsAsync.when(
        data: (products) => _cylinderItems.isEmpty
            ? const Center(child: Text('No cylinder items in cart'))
            : ListView.builder(
                itemCount: _returns.length,
                itemBuilder: (context, i) {
                  final ret = _returns[i];
                  return _ReturnEntryCard(
                    entry: ret,
                    products: products,
                    onChanged: () => setState(() {}),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _Step7Review({required bool isSaving}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReviewSection(
            title: 'Sale Details',
            children: [
              _ReviewRow('Branch', _selectedBranchName ?? '-'),
              _ReviewRow('Customer', _selectedCustomer?.name ?? 'Cash Sale'),
              _ReviewRow('Rider', _selectedRider?.name ?? 'None'),
              _ReviewRow('Payment', _paymentMethod.displayName),
              if (_paymentReference.isNotEmpty)
                _ReviewRow('Reference', _paymentReference),
            ],
          ),
          const SizedBox(height: 12),
          _ReviewSection(
            title: 'Items',
            children: _cart
                .map(
                  (e) => _ReviewRow(
                    '${e.productName} × ${e.quantity}',
                    _currencyFmt.format(e.totalPrice),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: ${_currencyFmt.format(_cartTotal)}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (_returns.isNotEmpty) ...[
            const SizedBox(height: 12),
            _ReviewSection(
              title: 'Cylinder Returns',
              children: _returns
                  .map(
                    (r) => _ReviewRow(
                      r.notReturned
                          ? '${r.returnedProductName} (Not Returned)'
                          : r.returnedProductName,
                      r.notReturned ? '-' : '${r.quantity} unit(s)',
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Customer Step Widget
// ─────────────────────────────────────────────────────────────

class _CustomerStep extends ConsumerStatefulWidget {
  final Customer? selected;
  final ValueChanged<Customer?> onSelected;

  const _CustomerStep({required this.selected, required this.onSelected});

  @override
  ConsumerState<_CustomerStep> createState() => _CustomerStepState();
}

class _CustomerStepState extends ConsumerState<_CustomerStep> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider(query: _query));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cash Sale shortcut
          if (widget.selected != null)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(widget.selected!.name),
              subtitle: widget.selected?.phone != null
                  ? Text(widget.selected!.phone!)
                  : null,
              trailing: TextButton(
                onPressed: () => widget.onSelected(null),
                child: const Text('Clear'),
              ),
            )
          else
            OutlinedButton.icon(
              onPressed: () => widget.onSelected(null),
              icon: const Icon(Icons.money),
              label: const Text('Cash Sale (no customer)'),
            ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search by name or phone…',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: customersAsync.when(
              data: (customers) => customers.isEmpty
                  ? const Center(
                      child: Text('No customers found. Use "Cash Sale".'),
                    )
                  : ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (_, i) {
                        final c = customers[i];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(c.name),
                          subtitle: c.phone != null ? Text(c.phone!) : null,
                          selected: widget.selected?.id == c.id,
                          onTap: () => widget.onSelected(c),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) =>
                  const Center(child: Text('Could not load customers')),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Cart View
// ─────────────────────────────────────────────────────────────

class _CartView extends ConsumerWidget {
  final List<_CartEntry> cart;
  final List<Product> products;
  final String? branchId;
  final NumberFormat currencyFmt;
  final VoidCallback onCartChanged;

  const _CartView({
    required this.cart,
    required this.products,
    required this.branchId,
    required this.currencyFmt,
    required this.onCartChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Add product button
        Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton.icon(
            onPressed: () => _showProductPicker(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
          ),
        ),
        Expanded(
          child: cart.isEmpty
              ? const Center(child: Text('No items yet. Add a product.'))
              : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (_, i) {
                    return _CartEntryRow(
                      entry: cart[i],
                      currencyFmt: currencyFmt,
                      onRemove: () {
                        cart.removeAt(i);
                        onCartChanged();
                      },
                      onChanged: onCartChanged,
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showProductPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ProductPickerSheet(
        products: products,
        onProductSelected: (product) {
          // Build a new cart entry with the product's default price
          final entry = _CartEntry()
            ..productId = product.id
            ..productName = product.name
            ..productCategory = product.category
            ..unitPrice = product.price;
          cart.add(entry);
          onCartChanged();
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Product Picker Sheet
// ─────────────────────────────────────────────────────────────

class _ProductPickerSheet extends StatefulWidget {
  final List<Product> products;
  final void Function(Product) onProductSelected;

  const _ProductPickerSheet({
    required this.products,
    required this.onProductSelected,
  });

  @override
  State<_ProductPickerSheet> createState() => _ProductPickerSheetState();
}

class _ProductPickerSheetState extends State<_ProductPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.products
        : widget.products
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_query.toLowerCase()) ||
                    p.category.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scroll) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search product…',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scroll,
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final p = filtered[i];
                  return ListTile(
                    title: Text(p.name),
                    subtitle: Text(p.category),
                    trailing: Text(
                      NumberFormat.currency(
                        locale: 'en_KE',
                        symbol: 'KES ',
                        decimalDigits: 2,
                      ).format(p.price),
                    ),
                    onTap: () {
                      widget.onProductSelected(p);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Cart Entry Row
// ─────────────────────────────────────────────────────────────

class _CartEntryRow extends StatefulWidget {
  final _CartEntry entry;
  final NumberFormat currencyFmt;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _CartEntryRow({
    required this.entry,
    required this.currencyFmt,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<_CartEntryRow> createState() => _CartEntryRowState();
}

class _CartEntryRowState extends State<_CartEntryRow> {
  late final TextEditingController _qtyCtrl;
  late final TextEditingController _priceCtrl;

  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: widget.entry.quantity.toString());
    _priceCtrl = TextEditingController(
      text: widget.entry.unitPrice.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.entry.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.entry.isCylinder)
                  const Chip(
                    label: Text('Cylinder', style: TextStyle(fontSize: 10)),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            Row(
              children: [
                // Qty
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _qtyCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (v) {
                      widget.entry.quantity = int.tryParse(v) ?? 1;
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Unit price
                Expanded(
                  child: TextFormField(
                    controller: _priceCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Unit Price',
                      prefixText: 'KES ',
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (v) {
                      widget.entry.unitPrice = double.tryParse(v) ?? 0;
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.currencyFmt.format(widget.entry.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Return Entry Card
// ─────────────────────────────────────────────────────────────

class _ReturnEntryCard extends StatefulWidget {
  final _ReturnEntry entry;
  final List<Product> products;
  final VoidCallback onChanged;

  const _ReturnEntryCard({
    required this.entry,
    required this.products,
    required this.onChanged,
  });

  @override
  State<_ReturnEntryCard> createState() => _ReturnEntryCardState();
}

class _ReturnEntryCardState extends State<_ReturnEntryCard> {
  late final TextEditingController _qtyCtrl;

  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: widget.entry.quantity.toString());
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cylinders = widget.products
        .where((p) => p.category == 'LPG Cylinder')
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Return for: ${widget.entry.returnedProductName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: widget.entry.notReturned,
                  onChanged: (v) => setState(() {
                    widget.entry.notReturned = v;
                    widget.onChanged();
                  }),
                ),
                const Text('Not Returned'),
              ],
            ),
            if (!widget.entry.notReturned) ...[
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: widget.entry.returnedProductId,
                decoration: const InputDecoration(
                  labelText: 'Returned Product',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: cylinders
                    .map(
                      (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
                    )
                    .toList(),
                onChanged: (v) => setState(() {
                  widget.entry.returnedProductId = v;
                  widget.entry.returnedProductName = cylinders
                      .firstWhere((p) => p.id == v)
                      .name;
                  widget.onChanged();
                }),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _qtyCtrl,
                decoration: const InputDecoration(
                  labelText: 'Returned Quantity',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (v) {
                  widget.entry.quantity = int.tryParse(v) ?? 1;
                  widget.onChanged();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Review Helpers
// ─────────────────────────────────────────────────────────────

class _ReviewSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ReviewSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Card(child: Column(children: children)),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReviewRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Success View
// ─────────────────────────────────────────────────────────────

class _SaleSuccessView extends StatelessWidget {
  final Sale sale;
  final List<_CartEntry> cart;
  final List<_ReturnEntry> returns;
  final String branchName;
  final String customerName;
  final String riderName;
  final NumberFormat currencyFmt;
  final VoidCallback onDone;

  const _SaleSuccessView({
    required this.sale,
    required this.cart,
    required this.returns,
    required this.branchName,
    required this.customerName,
    required this.riderName,
    required this.currencyFmt,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 72),
              const SizedBox(height: 8),
              Text(
                'Sale Recorded!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat.yMMMd().add_jm().format(sale.saleDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              // Receipt card
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _receiptRow(context, 'Branch', branchName),
                          _receiptRow(context, 'Customer', customerName),
                          _receiptRow(context, 'Rider', riderName),
                          _receiptRow(
                            context,
                            'Payment',
                            sale.paymentMethod.displayName,
                          ),
                          if (sale.paymentReference != null)
                            _receiptRow(
                              context,
                              'Reference',
                              sale.paymentReference!,
                            ),
                          const Divider(),
                          Text(
                            'Items',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          ...cart.map(
                            (e) => _receiptRow(
                              context,
                              '${e.productName} × ${e.quantity}',
                              currencyFmt.format(e.totalPrice),
                            ),
                          ),
                          const Divider(),
                          _receiptRow(
                            context,
                            'TOTAL',
                            currencyFmt.format(sale.totalAmount),
                            bold: true,
                          ),
                          if (returns.any((r) => !r.notReturned)) ...[
                            const Divider(),
                            Text(
                              'Cylinder Returns',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            ...returns
                                .where((r) => !r.notReturned)
                                .map(
                                  (r) => _receiptRow(
                                    context,
                                    r.returnedProductName,
                                    '${r.quantity} returned',
                                  ),
                                ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.home),
                label: const Text('Back to Dashboard'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(
    BuildContext context,
    String label,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: bold ? FontWeight.bold : null,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
