import 'package:jacktest1/src/features/inventory/data/inventory_movement_repository.dart';
import 'package:jacktest1/src/features/inventory/data/inventory_repository.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_movement.dart';
import 'package:jacktest1/src/features/inventory/domain/movement_type.dart';

/// Service layer for inventory operations
/// Enforces business rules and validates all stock movements
class InventoryService {
  final InventoryMovementRepository _movementRepo;
  final InventoryRepository _stockRepo;

  InventoryService(this._movementRepo, this._stockRepo);

  // ========================================
  // PURCHASE OPERATIONS
  // ========================================

  /// Record a purchase (stock coming in from supplier)
  /// Creates a positive movement entry
  Future<InventoryMovement> recordPurchase({
    required String productId,
    required String branchId,
    required int quantity,
    required String purchaseOrderId,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Purchase quantity must be positive');
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.purchaseIn,
      quantityChange: quantity,
      referenceId: purchaseOrderId,
      referenceType: 'purchase',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  // ========================================
  // SALE OPERATIONS
  // ========================================

  /// Record a sale (stock going out to customer)
  /// Validates stock availability before creating negative movement
  Future<InventoryMovement> recordSale({
    required String productId,
    required String branchId,
    required int quantity,
    required String saleOrderId,
    String? notes,
    String? createdBy,
    bool allowNegativeStock = false,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Sale quantity must be positive');
    }

    // Validate stock availability
    if (!allowNegativeStock) {
      final available = await _getAvailableStock(productId, branchId);
      if (available < quantity) {
        throw InsufficientStockException(
          'Insufficient stock. Available: $available, Required: $quantity',
          available,
          quantity,
        );
      }
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.saleOut,
      quantityChange: -quantity, // Negative for outgoing
      referenceId: saleOrderId,
      referenceType: 'sale',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  // ========================================
  // TRANSFER OPERATIONS
  // ========================================

  /// Record a transfer between branches
  /// Creates TWO movements atomically with shared reference_id
  /// Uses database function for atomicity
  Future<TransferResult> recordTransfer({
    required String productId,
    required String fromBranchId,
    required String toBranchId,
    required int quantity,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Transfer quantity must be positive');
    }

    if (fromBranchId == toBranchId) {
      throw ArgumentError('Cannot transfer to the same branch');
    }

    // Validate stock availability at source branch
    final available = await _getAvailableStock(productId, fromBranchId);
    if (available < quantity) {
      throw InsufficientStockException(
        'Insufficient stock at source branch. Available: $available, Required: $quantity',
        available,
        quantity,
      );
    }

    // Call database function for atomic transfer
    final result = await _movementRepo.createTransfer(
      productId: productId,
      fromBranchId: fromBranchId,
      toBranchId: toBranchId,
      quantity: quantity,
      notes: notes,
      createdBy: createdBy,
    );

    return TransferResult(
      transferOutId: result['transfer_out_id'] as String,
      transferInId: result['transfer_in_id'] as String,
      referenceId: result['reference_id'] as String,
    );
  }

  // ========================================
  // RETURN OPERATIONS
  // ========================================

  /// Record a customer return (item returned to inventory)
  /// Creates positive movement
  Future<InventoryMovement> recordCustomerReturn({
    required String productId,
    required String branchId,
    required int quantity,
    required String originalSaleId,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Return quantity must be positive');
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.customerReturn,
      quantityChange: quantity,
      referenceId: originalSaleId,
      referenceType: 'customer_return',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  /// Record a supplier return (item returned to supplier from inventory)
  /// Creates negative movement
  Future<InventoryMovement> recordSupplierReturn({
    required String productId,
    required String branchId,
    required int quantity,
    required String originalPurchaseId,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Return quantity must be positive');
    }

    // Validate stock availability
    final available = await _getAvailableStock(productId, branchId);
    if (available < quantity) {
      throw InsufficientStockException(
        'Insufficient stock for supplier return. Available: $available, Required: $quantity',
        available,
        quantity,
      );
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.supplierReturn,
      quantityChange: -quantity,
      referenceId: originalPurchaseId,
      referenceType: 'supplier_return',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  // ========================================
  // ADJUSTMENT OPERATIONS
  // ========================================

  /// Record a stock adjustment (manual correction)
  /// Requires admin role (TODO: implement role check)
  /// Records before/after counts in notes
  Future<InventoryMovement> recordAdjustment({
    required String productId,
    required String branchId,
    required int adjustmentQuantity,
    required String reason,
    int? beforeCount,
    int? afterCount,
    String? createdBy,
  }) async {
    if (adjustmentQuantity == 0) {
      throw ArgumentError('Adjustment quantity cannot be zero');
    }

    // TODO: Add role check here when authentication is implemented
    // if (!await _hasAdjustmentPermission(createdBy)) {
    //   throw UnauthorizedException('User not authorized to make stock adjustments');
    // }

    // Build detailed notes
    final notesBuffer = StringBuffer('Adjustment Reason: $reason');
    if (beforeCount != null && afterCount != null) {
      notesBuffer.write(
        ' | Before Count: $beforeCount | After Count: $afterCount',
      );
    }

    final movementType = adjustmentQuantity > 0
        ? MovementType.stockAdjustmentIn
        : MovementType.stockAdjustmentOut;

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: movementType,
      quantityChange: adjustmentQuantity,
      referenceType: 'adjustment',
      notes: notesBuffer.toString(),
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  // ========================================
  // DAMAGED/EXPIRED OPERATIONS
  // ========================================

  /// Record damaged stock (removed from inventory)
  Future<InventoryMovement> recordDamaged({
    required String productId,
    required String branchId,
    required int quantity,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Damaged quantity must be positive');
    }

    // Validate stock availability
    final available = await _getAvailableStock(productId, branchId);
    if (available < quantity) {
      throw InsufficientStockException(
        'Insufficient stock to record as damaged. Available: $available, Required: $quantity',
        available,
        quantity,
      );
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.damagedOut,
      quantityChange: -quantity,
      referenceType: 'damaged',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  /// Record expired stock (removed from inventory)
  Future<InventoryMovement> recordExpired({
    required String productId,
    required String branchId,
    required int quantity,
    String? notes,
    String? createdBy,
  }) async {
    if (quantity <= 0) {
      throw ArgumentError('Expired quantity must be positive');
    }

    // Validate stock availability
    final available = await _getAvailableStock(productId, branchId);
    if (available < quantity) {
      throw InsufficientStockException(
        'Insufficient stock to record as expired. Available: $available, Required: $quantity',
        available,
        quantity,
      );
    }

    final movement = InventoryMovement(
      productId: productId,
      branchId: branchId,
      movementType: MovementType.expiredOut,
      quantityChange: -quantity,
      referenceType: 'expired',
      notes: notes,
      createdBy: createdBy,
    );

    return _movementRepo.createMovement(movement);
  }

  // ========================================
  // REVERSAL OPERATIONS
  // ========================================

  /// Reverse a movement (create compensating entry)
  /// Does not delete the original - creates opposite movement
  Future<InventoryMovement> reverseMovement(
    String movementId,
    String reason, {
    String? createdBy,
  }) async {
    return _movementRepo.reverseMovement(movementId, reason);
  }

  // ========================================
  // QUERY OPERATIONS
  // ========================================

  /// Get current available stock for a product at a branch
  Future<int> getAvailableStock(String productId, String branchId) async {
    return _getAvailableStock(productId, branchId);
  }

  /// Get movement history with filters
  Future<List<InventoryMovement>> getMovementHistory({
    String? productId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    String? movementType,
    int limit = 100,
  }) async {
    return _movementRepo.getMovementHistory(
      productId: productId,
      branchId: branchId,
      startDate: startDate,
      endDate: endDate,
      movementType: movementType,
      limit: limit,
    );
  }

  // ========================================
  // PRIVATE HELPER METHODS
  // ========================================

  /// Get available stock (internal helper)
  Future<int> _getAvailableStock(String productId, String branchId) async {
    final stock = await _stockRepo.getStockByProductAndBranch(
      productId,
      branchId,
    );
    return stock?.quantity ?? 0;
  }
}

// ========================================
// EXCEPTIONS
// ========================================

class InsufficientStockException implements Exception {
  final String message;
  final int available;
  final int required;

  InsufficientStockException(this.message, this.available, this.required);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => message;
}

// ========================================
// TRANSFER RESULT
// ========================================

class TransferResult {
  final String transferOutId;
  final String transferInId;
  final String referenceId;

  TransferResult({
    required this.transferOutId,
    required this.transferInId,
    required this.referenceId,
  });
}
