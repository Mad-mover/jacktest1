// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supplierRepositoryHash() =>
    r'dc6a61d06e8f81529a7e792d859f6e34bdca921a';

/// See also [supplierRepository].
@ProviderFor(supplierRepository)
final supplierRepositoryProvider =
    AutoDisposeProvider<SupplierRepository>.internal(
      supplierRepository,
      name: r'supplierRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$supplierRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupplierRepositoryRef = AutoDisposeProviderRef<SupplierRepository>;
String _$supplierSearchQueryHash() =>
    r'a6a86e91bbaeef8d355c34be87716d0c7c855e36';

/// See also [SupplierSearchQuery].
@ProviderFor(SupplierSearchQuery)
final supplierSearchQueryProvider =
    AutoDisposeNotifierProvider<SupplierSearchQuery, String>.internal(
      SupplierSearchQuery.new,
      name: r'supplierSearchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$supplierSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SupplierSearchQuery = AutoDisposeNotifier<String>;
String _$supplierControllerHash() =>
    r'7268b44e7448651e7312432d40f430816c6419ca';

/// See also [SupplierController].
@ProviderFor(SupplierController)
final supplierControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      SupplierController,
      List<Supplier>
    >.internal(
      SupplierController.new,
      name: r'supplierControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$supplierControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SupplierController = AutoDisposeAsyncNotifier<List<Supplier>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
