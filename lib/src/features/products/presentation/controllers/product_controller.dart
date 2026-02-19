import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/products/domain/product.dart';
import 'package:jacktest1/src/features/products/data/product_repository.dart';
import 'package:jacktest1/src/features/purchases/data/purchase_repository.dart';

part 'product_controller.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository();
}

final productLastCostProvider = FutureProvider.family<double?, String>((
  ref,
  productId,
) {
  return ref.watch(purchaseRepositoryProvider).getLastPurchasePrice(productId);
});

@riverpod
class ProductController extends _$ProductController {
  @override
  FutureOr<List<Product>> build() async {
    return ref.watch(productRepositoryProvider).getProducts();
  }

  Future<void> addProduct(Product product) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).createProduct(product);
      return ref.read(productRepositoryProvider).getProducts();
    });
  }

  Future<void> updateProduct(Product product) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).updateProduct(product);
      return ref.read(productRepositoryProvider).getProducts();
    });
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).deleteProduct(id);
      return ref.read(productRepositoryProvider).getProducts();
    });
  }
}
