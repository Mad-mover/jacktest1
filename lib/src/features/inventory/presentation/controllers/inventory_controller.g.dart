// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inventoryRepositoryHash() =>
    r'2416ff1ce5e4dd10a94e8cb94ad3a34765b99fe0';

/// See also [inventoryRepository].
@ProviderFor(inventoryRepository)
final inventoryRepositoryProvider =
    AutoDisposeProvider<InventoryRepository>.internal(
      inventoryRepository,
      name: r'inventoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryRepositoryRef = AutoDisposeProviderRef<InventoryRepository>;
String _$inventoryMovementRepositoryHash() =>
    r'a47387c6ae052734e46740b55882d7d69633e5a7';

/// See also [inventoryMovementRepository].
@ProviderFor(inventoryMovementRepository)
final inventoryMovementRepositoryProvider =
    AutoDisposeProvider<InventoryMovementRepository>.internal(
      inventoryMovementRepository,
      name: r'inventoryMovementRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryMovementRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryMovementRepositoryRef =
    AutoDisposeProviderRef<InventoryMovementRepository>;
String _$inventoryServiceHash() => r'f35d7b3f85b17e7abd8f3e4d134622ebae60727a';

/// See also [inventoryService].
@ProviderFor(inventoryService)
final inventoryServiceProvider = AutoDisposeProvider<InventoryService>.internal(
  inventoryService,
  name: r'inventoryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inventoryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryServiceRef = AutoDisposeProviderRef<InventoryService>;
String _$inventoryControllerHash() =>
    r'eacaae116b7dd77f26378c2ecec2d148b6a0d0c5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$InventoryController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductStock>> {
  late final String productId;

  FutureOr<List<ProductStock>> build(String productId);
}

/// Controller for managing current stock levels (READ-ONLY)
/// Stock is computed from inventory movements
/// Use InventoryService methods to create movements that change stock
///
/// Copied from [InventoryController].
@ProviderFor(InventoryController)
const inventoryControllerProvider = InventoryControllerFamily();

/// Controller for managing current stock levels (READ-ONLY)
/// Stock is computed from inventory movements
/// Use InventoryService methods to create movements that change stock
///
/// Copied from [InventoryController].
class InventoryControllerFamily extends Family<AsyncValue<List<ProductStock>>> {
  /// Controller for managing current stock levels (READ-ONLY)
  /// Stock is computed from inventory movements
  /// Use InventoryService methods to create movements that change stock
  ///
  /// Copied from [InventoryController].
  const InventoryControllerFamily();

  /// Controller for managing current stock levels (READ-ONLY)
  /// Stock is computed from inventory movements
  /// Use InventoryService methods to create movements that change stock
  ///
  /// Copied from [InventoryController].
  InventoryControllerProvider call(String productId) {
    return InventoryControllerProvider(productId);
  }

  @override
  InventoryControllerProvider getProviderOverride(
    covariant InventoryControllerProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'inventoryControllerProvider';
}

/// Controller for managing current stock levels (READ-ONLY)
/// Stock is computed from inventory movements
/// Use InventoryService methods to create movements that change stock
///
/// Copied from [InventoryController].
class InventoryControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          InventoryController,
          List<ProductStock>
        > {
  /// Controller for managing current stock levels (READ-ONLY)
  /// Stock is computed from inventory movements
  /// Use InventoryService methods to create movements that change stock
  ///
  /// Copied from [InventoryController].
  InventoryControllerProvider(String productId)
    : this._internal(
        () => InventoryController()..productId = productId,
        from: inventoryControllerProvider,
        name: r'inventoryControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$inventoryControllerHash,
        dependencies: InventoryControllerFamily._dependencies,
        allTransitiveDependencies:
            InventoryControllerFamily._allTransitiveDependencies,
        productId: productId,
      );

  InventoryControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  FutureOr<List<ProductStock>> runNotifierBuild(
    covariant InventoryController notifier,
  ) {
    return notifier.build(productId);
  }

  @override
  Override overrideWith(InventoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: InventoryControllerProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    InventoryController,
    List<ProductStock>
  >
  createElement() {
    return _InventoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InventoryControllerProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InventoryControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductStock>> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _InventoryControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          InventoryController,
          List<ProductStock>
        >
    with InventoryControllerRef {
  _InventoryControllerProviderElement(super.provider);

  @override
  String get productId => (origin as InventoryControllerProvider).productId;
}

String _$movementHistoryControllerHash() =>
    r'983df51df4ecd461e59be69cff08135bf30251ca';

/// Controller for inventory movement history
///
/// Copied from [MovementHistoryController].
@ProviderFor(MovementHistoryController)
final movementHistoryControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      MovementHistoryController,
      List<InventoryMovement>
    >.internal(
      MovementHistoryController.new,
      name: r'movementHistoryControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$movementHistoryControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MovementHistoryController =
    AutoDisposeAsyncNotifier<List<InventoryMovement>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
