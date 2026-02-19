import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/branches/domain/branch.dart';
import 'package:jacktest1/src/features/branches/data/branch_repository.dart';

part 'branch_controller.g.dart';

@riverpod
BranchRepository branchRepository(Ref ref) {
  return BranchRepository();
}

@riverpod
class BranchController extends _$BranchController {
  @override
  FutureOr<List<Branch>> build() async {
    return ref.watch(branchRepositoryProvider).getBranches();
  }

  Future<void> addBranch(Branch branch) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(branchRepositoryProvider).createBranch(branch);
      return ref.read(branchRepositoryProvider).getBranches();
    });
  }

  Future<void> updateBranch(Branch branch) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(branchRepositoryProvider).updateBranch(branch);
      return ref.read(branchRepositoryProvider).getBranches();
    });
  }

  Future<void> deleteBranch(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(branchRepositoryProvider).deleteBranch(id);
      return ref.read(branchRepositoryProvider).getBranches();
    });
  }
}
