import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controllers/sale_controller.dart';
import '../../domain/sale.dart';
import '../../../branches/presentation/controllers/branch_controller.dart';
import '../../../sales/presentation/controllers/sale_controller.dart' as sc;

class SalesListPage extends ConsumerWidget {
  const SalesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesAsync = ref.watch(sc.salesProvider());
    final currencyFmt = NumberFormat.currency(
      locale: 'en_KE',
      symbol: 'KES ',
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sc.salesProvider),
          ),
        ],
      ),
      body: salesAsync.when(
        data: (sales) {
          if (sales.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.point_of_sale, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No sales found'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final sale = sales[index];
              return _SaleCard(sale: sale, currencyFmt: currencyFmt);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/new-sale'),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('New Sale'),
      ),
    );
  }
}

class _SaleCard extends ConsumerWidget {
  const _SaleCard({required this.sale, required this.currencyFmt});
  final Sale sale;
  final NumberFormat currencyFmt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchControllerProvider);
    final customersAsync = ref.watch(sc.customersProvider());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.receipt)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: customersAsync.when(
                data: (customers) {
                  final customer = customers
                      .where((c) => c.id == sale.customerId)
                      .firstOrNull;
                  return Text(
                    customer?.name ?? 'Cash Sale',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  );
                },
                loading: () => const Text('...'),
                error: (_, __) => const Text('Error'),
              ),
            ),
            Text(
              currencyFmt.format(sale.totalAmount),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.store, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: branchesAsync.when(
                    data: (branches) {
                      final branch = branches
                          .where((b) => b.id == sale.branchId)
                          .firstOrNull;
                      return Text(
                        branch?.name ?? 'Unknown Branch',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                    loading: () => const Text('...'),
                    error: (_, __) => const Text('Error'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat.yMMMd().add_jm().format(sale.saleDate),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Future: Show sale details
        },
      ),
    );
  }
}
