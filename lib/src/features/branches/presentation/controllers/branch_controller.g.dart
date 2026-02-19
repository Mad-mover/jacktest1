// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$branchRepositoryHash() => r'110ff8b0fc4262d9d0fff2d57c823d884fa2a510';

/// See also [branchRepository].
@ProviderFor(branchRepository)
final branchRepositoryProvider = AutoDisposeProvider<BranchRepository>.internal(
  branchRepository,
  name: r'branchRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$branchRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BranchRepositoryRef = AutoDisposeProviderRef<BranchRepository>;
String _$branchControllerHash() => r'59d29500b54298214dc81047d4d1885fcf860a6b';

/// See also [BranchController].
@ProviderFor(BranchController)
final branchControllerProvider =
    AutoDisposeAsyncNotifierProvider<BranchController, List<Branch>>.internal(
      BranchController.new,
      name: r'branchControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$branchControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BranchController = AutoDisposeAsyncNotifier<List<Branch>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
