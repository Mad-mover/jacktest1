// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saleRepositoryHash() => r'8068dbbbddce9a67324b0a48112a8ee747b61dd5';

/// See also [saleRepository].
@ProviderFor(saleRepository)
final saleRepositoryProvider = AutoDisposeProvider<SaleRepository>.internal(
  saleRepository,
  name: r'saleRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SaleRepositoryRef = AutoDisposeProviderRef<SaleRepository>;
String _$customerRepositoryHash() =>
    r'3560db8bda8dff691d3f93da83ebd15ee79285da';

/// See also [customerRepository].
@ProviderFor(customerRepository)
final customerRepositoryProvider =
    AutoDisposeProvider<CustomerRepository>.internal(
      customerRepository,
      name: r'customerRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$customerRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerRepositoryRef = AutoDisposeProviderRef<CustomerRepository>;
String _$riderRepositoryHash() => r'7d063e73abf0678768a1a80bee4fc4cecb4a6f75';

/// See also [riderRepository].
@ProviderFor(riderRepository)
final riderRepositoryProvider = AutoDisposeProvider<RiderRepository>.internal(
  riderRepository,
  name: r'riderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$riderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RiderRepositoryRef = AutoDisposeProviderRef<RiderRepository>;
String _$customersHash() => r'f30a6c9782df7d3c66bfa7fb809f324ab8fa1a52';

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

/// See also [customers].
@ProviderFor(customers)
const customersProvider = CustomersFamily();

/// See also [customers].
class CustomersFamily extends Family<AsyncValue<List<Customer>>> {
  /// See also [customers].
  const CustomersFamily();

  /// See also [customers].
  CustomersProvider call({String query = ''}) {
    return CustomersProvider(query: query);
  }

  @override
  CustomersProvider getProviderOverride(covariant CustomersProvider provider) {
    return call(query: provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customersProvider';
}

/// See also [customers].
class CustomersProvider extends AutoDisposeFutureProvider<List<Customer>> {
  /// See also [customers].
  CustomersProvider({String query = ''})
    : this._internal(
        (ref) => customers(ref as CustomersRef, query: query),
        from: customersProvider,
        name: r'customersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$customersHash,
        dependencies: CustomersFamily._dependencies,
        allTransitiveDependencies: CustomersFamily._allTransitiveDependencies,
        query: query,
      );

  CustomersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Customer>> Function(CustomersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomersProvider._internal(
        (ref) => create(ref as CustomersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Customer>> createElement() {
    return _CustomersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomersProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomersRef on AutoDisposeFutureProviderRef<List<Customer>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _CustomersProviderElement
    extends AutoDisposeFutureProviderElement<List<Customer>>
    with CustomersRef {
  _CustomersProviderElement(super.provider);

  @override
  String get query => (origin as CustomersProvider).query;
}

String _$activeRidersHash() => r'ab6874b3a8e94f184f76af15e8bc708bc9f9871a';

/// See also [activeRiders].
@ProviderFor(activeRiders)
final activeRidersProvider = AutoDisposeFutureProvider<List<Rider>>.internal(
  activeRiders,
  name: r'activeRidersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeRidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveRidersRef = AutoDisposeFutureProviderRef<List<Rider>>;
String _$salesHash() => r'32fb118f9c0c675b58c92f1381e487f16b979ac8';

/// See also [sales].
@ProviderFor(sales)
const salesProvider = SalesFamily();

/// See also [sales].
class SalesFamily extends Family<AsyncValue<List<Sale>>> {
  /// See also [sales].
  const SalesFamily();

  /// See also [sales].
  SalesProvider call({String? branchId}) {
    return SalesProvider(branchId: branchId);
  }

  @override
  SalesProvider getProviderOverride(covariant SalesProvider provider) {
    return call(branchId: provider.branchId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'salesProvider';
}

/// See also [sales].
class SalesProvider extends AutoDisposeFutureProvider<List<Sale>> {
  /// See also [sales].
  SalesProvider({String? branchId})
    : this._internal(
        (ref) => sales(ref as SalesRef, branchId: branchId),
        from: salesProvider,
        name: r'salesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salesHash,
        dependencies: SalesFamily._dependencies,
        allTransitiveDependencies: SalesFamily._allTransitiveDependencies,
        branchId: branchId,
      );

  SalesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.branchId,
  }) : super.internal();

  final String? branchId;

  @override
  Override overrideWith(
    FutureOr<List<Sale>> Function(SalesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SalesProvider._internal(
        (ref) => create(ref as SalesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        branchId: branchId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Sale>> createElement() {
    return _SalesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalesProvider && other.branchId == branchId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, branchId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SalesRef on AutoDisposeFutureProviderRef<List<Sale>> {
  /// The parameter `branchId` of this provider.
  String? get branchId;
}

class _SalesProviderElement extends AutoDisposeFutureProviderElement<List<Sale>>
    with SalesRef {
  _SalesProviderElement(super.provider);

  @override
  String? get branchId => (origin as SalesProvider).branchId;
}

String _$saleControllerHash() => r'66f2c05f8be56fc5327d939862c241513dc6eae8';

/// See also [SaleController].
@ProviderFor(SaleController)
final saleControllerProvider =
    AutoDisposeNotifierProvider<SaleController, AsyncValue<Sale?>>.internal(
      SaleController.new,
      name: r'saleControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$saleControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SaleController = AutoDisposeNotifier<AsyncValue<Sale?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
