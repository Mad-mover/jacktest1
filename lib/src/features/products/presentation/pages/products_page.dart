import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/products/presentation/widgets/product_form_dialog.dart';
import 'package:jacktest1/src/features/inventory/presentation/widgets/stock_management_dialog.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:jacktest1/src/features/products/presentation/controllers/product_controller.dart';
import 'package:jacktest1/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';
import 'package:jacktest1/src/features/inventory/domain/product_stock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedBranchId;
  String? _selectedProductId; // For tracking selected row

  final List<String> _categories = [
    'All',
    'LPG Cylinder',
    'Refill',
    'Accessory',
    'Water',
  ];

  // ignore: unused_field
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_KE',
    symbol: 'KES ',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productControllerProvider);
    final branchesAsync = ref.watch(branchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const ProductFormDialog(),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Deselect when clicking outside rows
          if (_selectedProductId != null) {
            setState(() {
              _selectedProductId = null;
            });
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            // Unified Filter Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Search Bar - Flexible width
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Branch Filter - Flexible width
                  Expanded(
                    flex: 1,
                    child: branchesAsync.when(
                      data: (branches) {
                        final activeBranches = branches
                            .where((b) => b.isActive)
                            .toList();
                        return DropdownButtonFormField<String?>(
                          value: _selectedBranchId,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            hintText: 'Branch',
                          ),
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text(
                                'All Branches',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ...activeBranches.map(
                              (branch) => DropdownMenuItem(
                                value: branch.id,
                                child: Text(
                                  branch.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedBranchId = value;
                            });
                          },
                        );
                      },
                      loading: () => const SizedBox(
                        height: 48,
                        child: Center(child: LinearProgressIndicator()),
                      ),
                      error: (_, __) => const SizedBox(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Category Filter - Fixed width or Scrollable
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((category) {
                          final isSelected =
                              _selectedCategory == category ||
                              (category == 'All' && _selectedCategory == null);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategory = category == 'All'
                                      ? null
                                      : category;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Icon',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Product Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Cost',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Selling Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total Qty',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 48), // Space for actions placeholder
                ],
              ),
            ),

            // Products List (Table Body)
            Expanded(
              child: productsAsync.when(
                data: (products) {
                  // Apply filters
                  var filteredProducts = products.where((product) {
                    final matchesSearch =
                        product.name.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ||
                        product.category.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        );
                    final matchesCategory =
                        _selectedCategory == null ||
                        product.category == _selectedCategory;

                    // Note: Branch filter currently only filters the *stock display*,
                    // not the product list itself, as products exist globally.
                    // If products were branch-specific, we'd filter here.

                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No products found',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: filteredProducts.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final isSelected = _selectedProductId == product.id;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedProductId = isSelected ? null : product.id;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            _selectedProductId = product.id;
                          });
                        },
                        child: Container(
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primaryContainer.withOpacity(0.3)
                              : Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              // Icon
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  _getIconForCategory(product.category),
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                              ),
                              // Name
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      product.category,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              // Cost (Last Purchase Price)
                              Expanded(
                                flex: 2,
                                child: _ProductCostDisplay(
                                  productId: product.id!,
                                ),
                              ),
                              // Selling Price
                              Expanded(
                                flex: 2,
                                child: Text(
                                  _currencyFormat.format(product.price),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Total Quantity (Live Stock)
                              Expanded(
                                flex: 2,
                                child: _ProductStockDisplay(
                                  productId: product.id!,
                                  branchId: _selectedBranchId,
                                  showIcon: false,
                                ),
                              ),
                              // Actions (Visible on selection)
                              SizedBox(
                                width: 48,
                                child: isSelected
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PopupMenuButton<String>(
                                            icon: const Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ProductFormDialog(
                                                        product: product,
                                                      ),
                                                );
                                              } else if (value == 'delete') {
                                                _confirmDelete(
                                                  context,
                                                  product.id!,
                                                );
                                              } else if (value == 'stock') {
                                                _showStockDialog(
                                                  context,
                                                  product,
                                                );
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit, size: 18),
                                                    SizedBox(width: 8),
                                                    Text('Edit'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 'stock',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.inventory,
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('Manage Stock'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const ProductFormDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'LPG Cylinder':
        return FontAwesomeIcons.gasPump;
      case 'Refill':
        return Icons.refresh;
      case 'Accessory':
        return Icons.build;
      case 'Water':
        return Icons.water_drop;
      default:
        return Icons.category;
    }
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ref.read(productControllerProvider.notifier).deleteProduct(id);
      setState(() {
        _selectedProductId = null;
      });
    }
  }

  void _showStockDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => StockManagementDialog(product: product),
    );
  }
}

class _ProductStockDisplay extends ConsumerWidget {
  const _ProductStockDisplay({
    required this.productId,
    this.branchId,
    this.showIcon = true,
  });

  final String productId;
  final String? branchId;
  final bool showIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch inventory controller to get live updates
    final stockAsync = ref.watch(inventoryControllerProvider(productId));

    return stockAsync.when(
      data: (stocks) {
        int quantity = 0;
        if (branchId != null) {
          final stock = stocks.firstWhere(
            (s) => s.branchId == branchId,
            orElse: () => ProductStock(
              id: '',
              productId: productId,
              branchId: branchId!,
              quantity: 0,
              lastUpdated: DateTime.now(),
            ),
          );
          quantity = stock.quantity;
        } else {
          quantity = stocks.fold(0, (sum, item) => sum + item.quantity);
        }

        Color color;
        if (quantity == 0) {
          color = Colors.red;
        } else if (quantity < 10) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }

        if (!showIcon) {
          return Text(
            '$quantity',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inventory_2_outlined, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                '$quantity in stock${branchId == null ? ' (Total)' : ''}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        width: 80,
        height: 20,
        child: LinearProgressIndicator(),
      ),
      error: (_, __) => const Text(
        'Error',
        style: TextStyle(color: Colors.red, fontSize: 10),
      ),
    );
  }
}

class _ProductCostDisplay extends ConsumerWidget {
  const _ProductCostDisplay({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final costAsync = ref.watch(productLastCostProvider(productId));

    return costAsync.when(
      data: (cost) {
        if (cost == null) {
          return const Text('-', style: TextStyle(color: Colors.grey));
        }
        return Text(
          NumberFormat.currency(
            locale: 'en_KE',
            symbol: 'KES ',
            decimalDigits: 2,
          ).format(cost),
          style: const TextStyle(color: Colors.grey),
        );
      },
      loading: () => const SizedBox(
        width: 60,
        height: 16,
        child: LinearProgressIndicator(),
      ),
      error: (_, __) => const Text('-', style: TextStyle(color: Colors.red)),
    );
  }
}
