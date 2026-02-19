import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jacktest1/src/features/branches/domain/branch.dart';
import 'package:jacktest1/src/core/supabase/supabase_client.dart';

class BranchRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Branch>> getBranches() async {
    final response = await _client
        .from('branches')
        .select()
        .order('name', ascending: true);

    return (response as List).map((json) => Branch.fromJson(json)).toList();
  }

  Future<Branch> createBranch(Branch branch) async {
    final response = await _client
        .from('branches')
        .insert(
          branch.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return Branch.fromJson(response);
  }

  Future<Branch> updateBranch(Branch branch) async {
    final response = await _client
        .from('branches')
        .update(
          branch.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .eq('id', branch.id!)
        .select()
        .single();

    return Branch.fromJson(response);
  }

  Future<void> deleteBranch(String id) async {
    await _client.from('branches').delete().eq('id', id);
  }
}
