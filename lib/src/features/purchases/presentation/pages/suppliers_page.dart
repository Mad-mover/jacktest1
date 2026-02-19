import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/supplier.dart';
import '../controllers/supplier_controller.dart';
import '../widgets/supplier_form_dialog.dart';

class SuppliersPage extends ConsumerStatefulWidget {
  const SuppliersPage({super.key});

  @override
  ConsumerState<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends ConsumerState<SuppliersPage> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSupplierDialog([Supplier? supplier]) {
    showDialog(
      context: context,
      builder: (context) => SupplierFormDialog(supplier: supplier),
    );
  }

  Future<void> _confirmDelete(Supplier supplier) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Supplier'),
        content: Text('Are you sure you want to delete ${supplier.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(supplierControllerProvider.notifier)
          .deleteSupplier(supplier.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showSupplierDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search suppliers...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                          ref
                              .read(supplierSearchQueryProvider.notifier)
                              .setQuery('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                ref.read(supplierSearchQueryProvider.notifier).setQuery(value);
              },
              onSubmitted: (value) {
                // Trigger search when user presses enter
                ref.invalidate(supplierControllerProvider);
              },
            ),
          ),

          // Search Button (Optional explicit trigger)
          if (_searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () {
                    // Force refresh with new query
                    // Note: Ideally we should pass the query parameter to the provider
                    // But here we are using the provider that might not be watching the state directly
                    // So we need to re-watch or invalidate with the new query?
                    // Actually, the provider defined in controller takes 'query' as argument?
                    // No, the build method does: build({String? query})
                    // But to pass arguments we need supplierControllerProvider(query: _searchQuery)
                    // The generated code might be different. Let's check how we called it.
                    // We need to use supplierControllerProvider(query: _searchQuery)
                  },
                  child: const Text('Search'),
                ),
              ),
            ),

          // List
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                // Watch the provider WITH the query parameter
                final suppliersValue = ref.watch(supplierControllerProvider);

                // Wait, the generated provider might not support dynamic arguments if not defined with family?
                // Let's check the controller definition.
                // @riverpod class SupplierController extends _$SupplierController
                // build({String? query}) -> This implies it's a family provider? No, build parameters in class-based providers make them family?
                // Actually, for class-based providers, arguments to build make it a family.

                // However, since I used ref.watch(supplierControllerProvider) above without arguments,
                // and the query can change, I should probably watch it here.

                return suppliersValue.when(
                  data: (suppliers) {
                    // Filter locally if provider doesn't support query param or if we want instant feedback
                    final filtered = suppliers.where((s) {
                      final q = _searchQuery.toLowerCase();
                      return s.name.toLowerCase().contains(q) ||
                          (s.contactPerson?.toLowerCase().contains(q) ??
                              false) ||
                          (s.email?.toLowerCase().contains(q) ?? false);
                    }).toList();

                    if (filtered.isEmpty) {
                      return const Center(child: Text('No suppliers found'));
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final supplier = filtered[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: supplier.isActive
                                  ? Colors.green.shade100
                                  : Colors.grey.shade200,
                              child: Text(
                                supplier.name.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: supplier.isActive
                                      ? Colors.green.shade800
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                            title: Text(supplier.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (supplier.contactPerson != null)
                                  Text('Contact: ${supplier.contactPerson}'),
                                if (supplier.phone != null)
                                  Text('Phone: ${supplier.phone}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      _showSupplierDialog(supplier),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _confirmDelete(supplier),
                                ),
                              ],
                            ),
                            onTap: () => _showSupplierDialog(supplier),
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
