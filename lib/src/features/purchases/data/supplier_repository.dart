import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/purchases/domain/supplier.dart';

class SupplierRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Supplier>> getSuppliers({
    bool activeOnly = true,
    String? query,
  }) async {
    var dbQuery = _client.from('suppliers').select();

    if (activeOnly) {
      dbQuery = dbQuery.eq('is_active', true);
    }

    if (query != null && query.isNotEmpty) {
      dbQuery = dbQuery.ilike('name', '%$query%');
    }

    final response = await dbQuery.order('name', ascending: true);

    return (response as List).map((json) => Supplier.fromJson(json)).toList();
  }

  Future<Supplier> getSupplier(String id) async {
    final response = await _client
        .from('suppliers')
        .select()
        .eq('id', id)
        .single();

    return Supplier.fromJson(response);
  }

  Future<Supplier> createSupplier(Supplier supplier) async {
    final response = await _client
        .from('suppliers')
        .insert(
          supplier.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return Supplier.fromJson(response);
  }

  Future<Supplier> updateSupplier(Supplier supplier) async {
    final response = await _client
        .from('suppliers')
        .update(
          supplier.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .eq('id', supplier.id!)
        .select()
        .single();

    return Supplier.fromJson(response);
  }

  Future<void> deleteSupplier(String id) async {
    await _client.from('suppliers').delete().eq('id', id);
  }

  /// Get outstanding balance for a supplier
  Future<double> getSupplierBalance(String supplierId) async {
    final response = await _client.rpc(
      'get_supplier_balance',
      params: {'p_supplier_id': supplierId},
    );
    return (response as num).toDouble();
  }
}
