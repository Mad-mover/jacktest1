import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';
import 'package:jacktest1/src/features/sales/domain/rider.dart';

class RiderRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Rider>> getActiveRiders() async {
    final response = await _client
        .from('riders')
        .select()
        .eq('is_active', true)
        .order('name');
    return (response as List).map((json) => Rider.fromJson(json)).toList();
  }

  Future<List<Rider>> getAllRiders() async {
    final response = await _client.from('riders').select().order('name');
    return (response as List).map((json) => Rider.fromJson(json)).toList();
  }
}
