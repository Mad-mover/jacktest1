import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_movement.dart';
import 'package:jacktest1/src/features/inventory/domain/movement_type.dart';

/// Repository for managing inventory movements (ledger entries)
/// All movements are append-only - no updates or deletes allowed
class InventoryMovementRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  /// Create a new inventory movement
  /// Throws exception if quantity sign doesn't match movement type (enforced by DB constraints)
  Future<InventoryMovement> createMovement(InventoryMovement movement) async {
    final response = await _client
        .from('inventory_movements')
        .insert(
          movement.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return InventoryMovement.fromJson(response);
  }

  /// Get all movements for a specific product
  Future<List<InventoryMovement>> getMovementsByProduct(
    String productId,
  ) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('product_id', productId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();
  }

  /// Get all movements for a specific branch
  Future<List<InventoryMovement>> getMovementsByBranch(String branchId) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('branch_id', branchId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();
  }

  /// Get movement history with optional filters
  /// All filters are optional - provide only the ones you want to filter by
  Future<List<InventoryMovement>> getMovementHistory({
    String? productId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    String? movementType,
    String? referenceId,
    int limit = 100,
  }) async {
    var query = _client.from('inventory_movements').select();

    // Apply filters
    if (productId != null) {
      query = query.eq('product_id', productId);
    }
    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }
    if (startDate != null) {
      query = query.gte('created_at', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('created_at', endDate.toIso8601String());
    }
    if (movementType != null) {
      query = query.eq('movement_type', movementType);
    }
    if (referenceId != null) {
      query = query.eq('reference_id', referenceId);
    }

    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();
  }

  /// Create a reversal movement (compensating entry)
  /// Creates a new movement with opposite quantity_change
  Future<InventoryMovement> reverseMovement(
    String movementId,
    String reason,
  ) async {
    // First, fetch the original movement
    final originalResponse = await _client
        .from('inventory_movements')
        .select()
        .eq('id', movementId)
        .single();

    final original = InventoryMovement.fromJson(originalResponse);

    // Create the reversal movement
    final reversal = InventoryMovement(
      productId: original.productId,
      branchId: original.branchId,
      movementType: _getReverseMovementType(original.movementType),
      quantityChange: -original.quantityChange,
      referenceId: original.referenceId,
      referenceType: 'reversal',
      notes: 'Reversal of movement $movementId. Reason: $reason',
      reversedMovementId: movementId,
    );

    return createMovement(reversal);
  }

  /// Get movements by reference (e.g., all movements for a specific transfer)
  Future<List<InventoryMovement>> getMovementsByReference(
    String referenceId,
  ) async {
    final response = await _client
        .from('inventory_movements')
        .select()
        .eq('reference_id', referenceId)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => InventoryMovement.fromJson(json))
        .toList();
  }

  /// Call the database transfer function to create both movements atomically
  /// Returns a map with transfer_out_id, transfer_in_id, and reference_id
  Future<Map<String, dynamic>> createTransfer({
    required String productId,
    required String fromBranchId,
    required String toBranchId,
    required int quantity,
    String? notes,
    String? createdBy,
  }) async {
    final response = await _client.rpc(
      'create_transfer',
      params: {
        'p_product_id': productId,
        'p_from_branch_id': fromBranchId,
        'p_to_branch_id': toBranchId,
        'p_quantity': quantity,
        'p_notes': notes,
        'p_created_by': createdBy,
      },
    );

    return response[0] as Map<String, dynamic>;
  }

  /// Helper to get the reverse movement type
  /// For example, purchase_in reverses to stock_adjustment_out
  MovementType _getReverseMovementType(MovementType original) {
    switch (original) {
      case MovementType.purchaseIn:
        return MovementType.stockAdjustmentOut;
      case MovementType.saleOut:
        return MovementType.stockAdjustmentIn;
      case MovementType.transferOut:
        return MovementType.transferIn;
      case MovementType.transferIn:
        return MovementType.transferOut;
      case MovementType.customerReturn:
        return MovementType.saleOut;
      case MovementType.supplierReturn:
        return MovementType.purchaseIn;
      case MovementType.stockAdjustmentIn:
        return MovementType.stockAdjustmentOut;
      case MovementType.stockAdjustmentOut:
        return MovementType.stockAdjustmentIn;
      case MovementType.damagedOut:
        return MovementType.stockAdjustmentIn;
      case MovementType.expiredOut:
        return MovementType.stockAdjustmentIn;
    }
  }
}
