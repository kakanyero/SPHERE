import 'package:flutter/material.dart';
import '../../models/product_data.dart';
import '../../utils/app_theme.dart';
import '../../widgets/product_card.dart';
import 'product_details_screen.dart';

/// Page 14 — Wishlist.
/// Grid of favorited products, mirroring the layout of Home's product
/// grid. In a real app, back this with persisted favorite IDs instead
/// of the local demo list below.
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Demo: first two sample products start "favorited".
  final List<Product> _wishlist = sampleProducts.take(2).toList();

  void _removeFromWishlist(Product product) {
    setState(() => _wishlist.remove(product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: AppColors.textDark),
        title: const Text(
          'Wishlist',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: _wishlist.isEmpty
          ? Center(
              child: Text('Your wishlist is empty', style: AppTextStyles.body),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemCount: _wishlist.length,
              itemBuilder: (context, index) {
                final product = _wishlist[index];
                return ProductCard(
                  product: product,
                  isFavorite: true,
                  onFavoriteToggle: () => _removeFromWishlist(product),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
