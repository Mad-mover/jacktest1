import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/product.dart';
import '../../../core/supabase/supabase_client.dart';

class ProductRepository {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Product>> getProducts() async {
    final response = await _client
        .from('products')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> createProduct(Product product) async {
    final response = await _client
        .from('products')
        .insert(
          product.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .select()
        .single();

    return Product.fromJson(response);
  }

  Future<Product> updateProduct(Product product) async {
    final response = await _client
        .from('products')
        .update(
          product.toJson()
            ..remove('id')
            ..remove('created_at'),
        )
        .eq('id', product.id!)
        .select()
        .single();

    return Product.fromJson(response);
  }

  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}
