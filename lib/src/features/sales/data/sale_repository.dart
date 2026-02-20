import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/sales/domain/sale.dart';
import 'package:jacktest1/src/features/sales/domain/sale_item.dart';
import 'package:jacktest1/src/features/sales/domain/cylinder_return.dart';
import 'package:jacktest1/src/features/inventory/domain/inventory_service.dart';

class SaleRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  // ==========================================
  // SALES
  // ==========================================

  Future<List<Sale>> getSales({String? branchId}) async {
    var query = _client.from('sales').select();
    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }
    final response = await query.order('sale_date', ascending: false);
    return (response as List).map((json) => Sale.fromJson(json)).toList();
  }

  Future<Sale> createSale(Sale sale) async {
    final json = sale.toJson()
      ..remove('id')
      ..remove('created_at');
    final response = await _client.from('sales').insert(json).select().single();
    return Sale.fromJson(response);
  }

  // ==========================================
  // SALE ITEMS
  // ==========================================

  Future<SaleItem> createSaleItem(SaleItem item) async {
    final json = item.toJson()
      ..remove('id')
      ..remove('created_at');
    final response = await _client
        .from('sale_items')
        .insert(json)
        .select()
        .single();
    return SaleItem.fromJson(response);
  }

  Future<List<SaleItem>> getSaleItems(String saleId) async {
    final response = await _client
        .from('sale_items')
        .select()
        .eq('sale_id', saleId);
    return (response as List).map((json) => SaleItem.fromJson(json)).toList();
  }

  // ==========================================
  // CYLINDER RETURNS
  // ==========================================

  Future<CylinderReturn> createCylinderReturn(CylinderReturn ret) async {
    final json = ret.toJson()
      ..remove('id')
      ..remove('created_at');
    final response = await _client
        .from('cylinder_returns')
        .insert(json)
        .select()
        .single();
    return CylinderReturn.fromJson(response);
  }

  // ==========================================
  // COMPLETE SALE (atomic-ish)
  // ==========================================

  /// Creates a sale with all items, cylinder returns, and inventory movements.
  Future<Sale> createCompleteSale({
    required Sale sale,
    required List<SaleItem> items,
    required List<CylinderReturn> cylinderReturns,
    required InventoryService inventoryService,
  }) async {
    // 1. Insert sale record
    final createdSale = await createSale(sale);
    final saleId = createdSale.id!;

    try {
      // 2. Insert sale items + record stock-out movements
      for (final item in items) {
        final itemWithSaleId = item.copyWith(saleId: saleId);
        await createSaleItem(itemWithSaleId);

        await inventoryService.recordSale(
          productId: item.productId,
          branchId: sale.branchId,
          quantity: item.quantity,
          saleOrderId: saleId,
          notes: 'Sale: ${item.quantity} units @ ${item.unitPrice}',
          allowNegativeStock: true, // allow if stock not strictly tracked
        );
      }

      // 3. Insert cylinder returns + record stock-in movements (empty cylinders)
      for (final ret in cylinderReturns) {
        final retWithSaleId = ret.copyWith(saleId: saleId);
        await createCylinderReturn(retWithSaleId);

        await inventoryService.recordCustomerReturn(
          productId: ret.returnedProductId,
          branchId: sale.branchId,
          quantity: ret.quantity,
          originalSaleId: saleId,
          notes: 'Cylinder return for sale $saleId',
        );
      }

      return createdSale;
    } catch (e) {
      rethrow;
    }
  }
}
