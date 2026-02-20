import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jacktest1/src/features/sales/domain/customer.dart';
import 'package:jacktest1/src/features/sales/domain/rider.dart';
import 'package:jacktest1/src/features/sales/domain/sale.dart';
import 'package:jacktest1/src/features/sales/domain/sale_item.dart';
import 'package:jacktest1/src/features/sales/domain/cylinder_return.dart';
import 'package:jacktest1/src/features/sales/data/sale_repository.dart';
import 'package:jacktest1/src/features/sales/data/customer_repository.dart';
import 'package:jacktest1/src/features/sales/data/rider_repository.dart';
import 'package:jacktest1/src/features/inventory/presentation/controllers/inventory_controller.dart';

part 'sale_controller.g.dart';

// ==========================================
// REPOSITORY PROVIDERS
// ==========================================

@riverpod
SaleRepository saleRepository(SaleRepositoryRef ref) => SaleRepository();

@riverpod
CustomerRepository customerRepository(CustomerRepositoryRef ref) =>
    CustomerRepository();

@riverpod
RiderRepository riderRepository(RiderRepositoryRef ref) => RiderRepository();

// ==========================================
// DATA PROVIDERS
// ==========================================

@riverpod
Future<List<Customer>> customers(CustomersRef ref, {String query = ''}) {
  return ref.watch(customerRepositoryProvider).getCustomers(query: query);
}

@riverpod
Future<List<Rider>> activeRiders(ActiveRidersRef ref) {
  return ref.watch(riderRepositoryProvider).getActiveRiders();
}

@riverpod
Future<List<Sale>> sales(SalesRef ref, {String? branchId}) {
  return ref.watch(saleRepositoryProvider).getSales(branchId: branchId);
}

// ==========================================
// SALE CONTROLLER
// ==========================================

@riverpod
class SaleController extends _$SaleController {
  @override
  AsyncValue<Sale?> build() => const AsyncData(null);

  Future<Sale?> createSale({
    required Sale sale,
    required List<SaleItem> items,
    required List<CylinderReturn> cylinderReturns,
  }) async {
    state = const AsyncLoading();
    final inventoryService = ref.read(inventoryServiceProvider);
    state = await AsyncValue.guard(() async {
      final repo = ref.read(saleRepositoryProvider);
      final createdSale = await repo.createCompleteSale(
        sale: sale,
        items: items,
        cylinderReturns: cylinderReturns,
        inventoryService: inventoryService,
      );
      // Invalidate stock for all products involved
      for (final item in items) {
        ref.invalidate(inventoryControllerProvider(item.productId));
      }
      for (final ret in cylinderReturns) {
        ref.invalidate(inventoryControllerProvider(ret.returnedProductId));
      }
      return createdSale;
    });
    return state.value;
  }
}
