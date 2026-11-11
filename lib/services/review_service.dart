import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Put at lib/services/review_service.dart
class ReviewService {
  ReviewService._();
  static final ReviewService instance = ReviewService._();

  final SupabaseClient _db = Supabase.instance.client;

  /// Uploads photos to the `review-media` bucket, then inserts the review.
  /// (A DB trigger updates the product's rating and review_count.)
  Future<void> submit({
    required String productId,
    required double rating,
    required String comment,
    List<File> mediaFiles = const [],
  }) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) throw Exception('Not signed in');

    final urls = <String>[];
    for (var i = 0; i < mediaFiles.length; i++) {
      final path = '$uid/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      await _db.storage.from('review-media').upload(path, mediaFiles[i]);
      urls.add(_db.storage.from('review-media').getPublicUrl(path));
    }

    await _db.from('reviews').insert({
      'product_id': productId,
      'user_id': uid,
      'rating': rating.round(),
      'comment': comment,
      'media_urls': urls,
    });
  }

  Future<List<Map<String, dynamic>>> fetchForProduct(String productId) async {
    final rows = await _db
        .from('reviews')
        .select('rating, comment, media_urls, created_at, profiles(full_name, avatar_url)')
        .eq('product_id', productId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows);
  }
}