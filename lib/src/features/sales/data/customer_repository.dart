import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/sales/domain/customer.dart';

class CustomerRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Customer>> getCustomers({String? query}) async {
    var req = _client.from('customers').select();
    if (query != null && query.isNotEmpty) {
      req = req.or('name.ilike.%$query%,phone.ilike.%$query%');
    }
    final response = await req.order('name');
    return (response as List).map((json) => Customer.fromJson(json)).toList();
  }

  Future<Customer> createCustomer(Customer customer) async {
    final json = customer.toJson()
      ..remove('id')
      ..remove('created_at');
    final response = await _client
        .from('customers')
        .insert(json)
        .select()
        .single();
    return Customer.fromJson(response);
  }
}
