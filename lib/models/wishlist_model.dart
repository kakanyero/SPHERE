import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/product_service.dart';
import 'product_data.dart';

/// Supabase-backed wishlist. Put at lib/models/wishlist_model.dart
class WishlistModel extends ChangeNotifier {
  WishlistModel._();
  static final WishlistModel instance = WishlistModel._();

  final List<Product> _products = [];

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  List<Product> get products => List.unmodifiable(_products);
  bool contains(String productId) => _products.any((p) => p.id == productId);

  Future<void> load() async {
    final uid = _uid;
    if (uid == null) return;
    try {
      final rows = await _db
          .from('wishlist_items')
          .select('products(*)')
          .eq('user_id', uid)
          .order('created_at');
      _products
        ..clear()
        ..addAll(rows.map<Product>(
            (r) => ProductService.fromRow(r['products'] as Map<String, dynamic>)));
      notifyListeners();
    } catch (e) {
      debugPrint('Wishlist load failed: $e');
    }
  }

  void resetLocal() {
    _products.clear();
    notifyListeners();
  }

  /// Optimistic add/remove, then sync.
  Future<void> toggle(Product product) async {
    final uid = _uid;
    final wasIn = contains(product.id);
    if (wasIn) {
      _products.removeWhere((p) => p.id == product.id);
    } else {
      _products.add(product);
    }
    notifyListeners();
    if (uid == null) return;

    try {
      if (wasIn) {
        await _db
            .from('wishlist_items')
            .delete()
            .eq('user_id', uid)
            .eq('product_id', product.id);
      } else {
        await _db
            .from('wishlist_items')
            .insert({'user_id': uid, 'product_id': product.id});
      }
    } catch (e) {
      debugPrint('Wishlist sync failed: $e');
      // roll back
      if (wasIn) {
        _products.add(product);
      } else {
        _products.removeWhere((p) => p.id == product.id);
      }
      notifyListeners();
    }
  }

  Future<void> remove(Product product) async {
    if (contains(product.id)) await toggle(product);
  }
}