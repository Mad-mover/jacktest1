// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'cafbf9b8224d7b674e13c35ce792ecdfbe43badd';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider =
    AutoDisposeProvider<ProductRepository>.internal(
      productRepository,
      name: r'productRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = AutoDisposeProviderRef<ProductRepository>;
String _$productControllerHash() => r'737b6a12369d1b5806ed621fe746eba89c7ec7f6';

/// See also [ProductController].
@ProviderFor(ProductController)
final productControllerProvider =
    AutoDisposeAsyncNotifierProvider<ProductController, List<Product>>.internal(
      ProductController.new,
      name: r'productControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductController = AutoDisposeAsyncNotifier<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
