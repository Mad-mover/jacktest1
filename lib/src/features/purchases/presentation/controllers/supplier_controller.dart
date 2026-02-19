import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/supplier.dart';
import '../../data/supplier_repository.dart';

part 'supplier_controller.g.dart';

@riverpod
SupplierRepository supplierRepository(SupplierRepositoryRef ref) =>
    SupplierRepository();

@riverpod
class SupplierSearchQuery extends _$SupplierSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
class SupplierController extends _$SupplierController {
  @override
  FutureOr<List<Supplier>> build() {
    final query = ref.watch(supplierSearchQueryProvider);
    return ref.watch(supplierRepositoryProvider).getSuppliers(query: query);
  }

  Future<bool> addSupplier(Supplier supplier) async {
    try {
      final repo = ref.read(supplierRepositoryProvider);
      await repo.createSupplier(supplier);
      ref.invalidateSelf();
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> updateSupplier(Supplier supplier) async {
    try {
      final repo = ref.read(supplierRepositoryProvider);
      await repo.updateSupplier(supplier);
      ref.invalidateSelf();
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> deleteSupplier(String id) async {
    try {
      final repo = ref.read(supplierRepositoryProvider);
      await repo.deleteSupplier(id);
      ref.invalidateSelf();
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
}
