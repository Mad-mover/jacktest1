import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase_item.dart';
import 'package:jacktest1/src/features/purchases/domain/purchase_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_service.dart';

final purchaseRepositoryProvider = Provider((ref) => PurchaseRepository());

class PurchaseRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  // ========================================
  // PURCHASE CRUD
  // ========================================

  Future<List<Purchase>> getPurchases({
    String? supplierId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    String? paymentStatus,
  }) async {
    var query = _client.from('purchases').select();

    if (supplierId != null) {
      query = query.eq('supplier_id', supplierId);
    }
    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }
    if (startDate != null) {
      query = query.gte('purchase_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('purchase_date', endDate.toIso8601String());
    }
    if (paymentStatus != null) {
      query = query.eq('payment_status', paymentStatus);
    }

    final response = await query.order('purchase_date', ascending: false);

    return (response as List).map((json) => Purchase.fromJson(json)).toList();
  }

  Future<Purchase> getPurchase(String id) async {
    final response = await _client
        .from('purchases')
        .select()
        .eq('id', id)
        .single();

    return Purchase.fromJson(response);
  }

  Future<Purchase> createPurchase(Purchase purchase) async {
    final response = await _client
        .from('purchases')
        .insert(
          purchase.toJson()
            ..remove('id')
            ..remove('created_at')
            ..remove('updated_at'),
        )
        .select()
        .single();

    return Purchase.fromJson(response);
  }

  Future<Purchase> updatePurchase(Purchase purchase) async {
    final response = await _client
        .from('purchases')
        .update(
          purchase.toJson()
            ..remove('id')
            ..remove('created_at')
            ..remove('updated_at'),
        )
        .eq('id', purchase.id!)
        .select()
        .single();

    return Purchase.fromJson(response);
  }

  Future<void> deletePurchase(String id) async {
    await _client.from('purchases').delete().eq('id', id);
  }

  // ========================================
  // PURCHASE ITEMS
  // ========================================

  Future<List<PurchaseItem>> getPurchaseItems(String purchaseId) async {
    final response = await _client
        .from('purchase_items')
        .select()
        .eq('purchase_id', purchaseId);

    return (response as List)
        .map((json) => PurchaseItem.fromJson(json))
        .toList();
  }

  Future<PurchaseItem> createPurchaseItem(PurchaseItem item) async {
    final response = await _client
        .from('purchase_items')
        .insert(
          item.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return PurchaseItem.fromJson(response);
  }

  Future<void> deletePurchaseItem(String id) async {
    await _client.from('purchase_items').delete().eq('id', id);
  }

  // ========================================
  // PURCHASE PAYMENTS
  // ========================================

  Future<List<PurchasePayment>> getPurchasePayments(String purchaseId) async {
    final response = await _client
        .from('purchase_payments')
        .select()
        .eq('purchase_id', purchaseId)
        .order('payment_date', ascending: false);

    return (response as List)
        .map((json) => PurchasePayment.fromJson(json))
        .toList();
  }

  Future<PurchasePayment> createPurchasePayment(PurchasePayment payment) async {
    final response = await _client
        .from('purchase_payments')
        .insert(
          payment.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return PurchasePayment.fromJson(response);
  }

  // ========================================
  // COMPLETE PURCHASE WITH ITEMS
  // ========================================

  /// Create a complete purchase with items and inventory movements
  /// This is a transaction-like operation that:
  /// 1. Creates the purchase record
  /// 2. Creates all purchase items
  /// 3. Creates inventory movements for each item via InventoryService
  Future<Purchase> createCompletePurchase({
    required Purchase purchase,
    required List<PurchaseItem> items,
    required InventoryService inventoryService,
  }) async {
    // 1. Create the purchase
    final createdPurchase = await createPurchase(purchase);

    try {
      // 2. Create purchase items
      for (var item in items) {
        final itemWithPurchaseId = item.copyWith(
          purchaseId: createdPurchase.id!,
        );
        await createPurchaseItem(itemWithPurchaseId);

        // 3. Create inventory movement for this item
        await inventoryService.recordPurchase(
          productId: item.productId,
          branchId: purchase.branchId,
          quantity: item.quantity,
          purchaseOrderId: createdPurchase.id!,
          notes:
              'Purchase from ${purchase.invoiceNumber ?? "N/A"} - ${item.quantity} units @ ${item.unitPrice}',
        );
      }

      return createdPurchase;
    } catch (e) {
      // If something fails, we should ideally rollback
      // For now, just rethrow
      rethrow;
    }
  }

  Future<double?> getLastPurchasePrice(String productId) async {
    try {
      final response = await _client
          .from('purchase_items')
          .select('unit_price')
          .eq('product_id', productId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return (response['unit_price'] as num).toDouble();
    } catch (e) {
      return null;
    }
  }
}
