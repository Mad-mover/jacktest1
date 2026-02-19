import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/features/inventory/domain/product_stock.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_movement.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';

/// Repository for reading current stock levels (computed from inventory movements)
/// Stock is READ-ONLY - use InventoryService to create movements that change stock
class InventoryRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  /// Get current stock for a product across all branches
  /// Computes from inventory_movements table
  Future<List<ProductStock>> getStockByProduct(String productId) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('product_id', productId);

    final movements = (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();

    return _aggregateStock(movements);
  }

  /// Get current stock for all products at a specific branch
  /// Computes from inventory_movements table
  Future<List<ProductStock>> getStockByBranch(String branchId) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('branch_id', branchId);

    final movements = (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();

    return _aggregateStock(movements);
  }

  /// Get current stock for a specific product at a specific branch
  /// Returns null if no stock record exists (or 0 if computed)
  Future<ProductStock?> getStockByProductAndBranch(
    String productId,
    String branchId,
  ) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('product_id', productId)
        .eq('branch_id', branchId);

    final movements = (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();

    final stocks = _aggregateStock(movements);
    if (stocks.isEmpty) return null;

    // There should be only one entry for this specific product+branch combo
    return stocks.first;
  }

  /// Get total stock quantity for a product across all branches
  Future<int> getTotalStock(String productId) async {
    final stocks = await getStockByProduct(productId);
    return stocks.fold<int>(0, (sum, stock) => sum + stock.quantity);
  }

  /// Get stock quantities by branch for a product as a map
  /// Useful for quick lookups: {branchId: quantity}
  Future<Map<String, int>> getStockByBranchMap(String productId) async {
    final stocks = await getStockByProduct(productId);
    final Map<String, int> stockMap = {};

    for (var stock in stocks) {
      stockMap[stock.branchId] = stock.quantity;
    }

    return stockMap;
  }

  /// Get all current stock across all products and branches
  Future<List<ProductStock>> getAllStock() async {
    final response = await _client.from('inventory_movements').select();

    final movements = (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();

    return _aggregateStock(movements);
  }

  /// Helper to aggregate movements into ProdutStock
  List<ProductStock> _aggregateStock(List<InventoryMovement> movements) {
    final Map<String, ProductStock> stockMap = {};

    for (var movement in movements) {
      final key = '${movement.productId}_${movement.branchId}';

      if (!stockMap.containsKey(key)) {
        stockMap[key] = ProductStock(
          id: key, // Synthetic ID
          productId: movement.productId,
          branchId: movement.branchId,
          quantity: 0,
          lastUpdated: DateTime.fromMillisecondsSinceEpoch(0),
        );
      }

      final current = stockMap[key]!;
      stockMap[key] = current.copyWith(
        quantity: current.quantity + movement.quantityChange,
        lastUpdated:
            (movement.createdAt != null &&
                (current.lastUpdated == null ||
                    movement.createdAt!.isAfter(current.lastUpdated!)))
            ? movement.createdAt
            : current.lastUpdated,
      );
    }

    return stockMap.values.toList();
  }
}
