import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/inventory/domain/product_stock.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_movement.dart';
import 'package:jacktest1/src/features/inventory/data/inventory_repository.dart';
import 'package:jacktest1/src/features/inventory/data/inventory_movement_repository.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_service.dart';

part 'inventory_controller.g.dart';

@riverpod
InventoryRepository inventoryRepository(Ref ref) {
  return InventoryRepository();
}

@riverpod
InventoryMovementRepository inventoryMovementRepository(Ref ref) {
  return InventoryMovementRepository();
}

@riverpod
InventoryService inventoryService(Ref ref) {
  return InventoryService(
    ref.watch(inventoryMovementRepositoryProvider),
    ref.watch(inventoryRepositoryProvider),
  );
}

/// Controller for managing current stock levels (READ-ONLY)
/// Stock is computed from inventory movements
/// Use InventoryService methods to create movements that change stock
@riverpod
class InventoryController extends _$InventoryController {
  @override
  FutureOr<List<ProductStock>> build(String productId) async {
    return ref.watch(inventoryRepositoryProvider).getStockByProduct(productId);
  }

  /// Refresh stock data
  Future<void> refresh(String productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(inventoryRepositoryProvider).getStockByProduct(productId);
    });
  }

  /// Get current stock quantity for a product at a branch
  Future<int> getCurrentStock(String productId, String branchId) async {
    final stock = await ref
        .read(inventoryRepositoryProvider)
        .getStockByProductAndBranch(productId, branchId);
    return stock?.quantity ?? 0;
  }
}

/// Controller for inventory movement history
@riverpod
class MovementHistoryController extends _$MovementHistoryController {
  @override
  FutureOr<List<InventoryMovement>> build() async {
    return [];
  }

  /// Load movement history with filters
  Future<void> loadHistory({
    String? productId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    String? movementType,
    int limit = 100,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(inventoryMovementRepositoryProvider)
          .getMovementHistory(
            productId: productId,
            branchId: branchId,
            startDate: startDate,
            endDate: endDate,
            movementType: movementType,
            limit: limit,
          );
    });
  }

  /// Calculate running balance for display
  /// Takes a list of movements and returns them with calculated running totals
  List<MovementWithBalance> calculateRunningBalance(
    List<InventoryMovement> movements,
  ) {
    final result = <MovementWithBalance>[];
    var runningTotal = 0;

    // Movements should be ordered chronologically (oldest first) for running balance
    final sortedMovements = List<InventoryMovement>.from(movements)
      ..sort(
        (a, b) => (a.createdAt ?? DateTime.now()).compareTo(
          b.createdAt ?? DateTime.now(),
        ),
      );

    for (final movement in sortedMovements) {
      runningTotal += movement.quantityChange;
      result.add(MovementWithBalance(movement, runningTotal));
    }

    return result;
  }
}

/// Helper class to hold movement with its running balance
class MovementWithBalance {
  final InventoryMovement movement;
  final int runningBalance;

  MovementWithBalance(this.movement, this.runningBalance);
}
