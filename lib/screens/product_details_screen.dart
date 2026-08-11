import 'package:flutter/material.dart';
import '../../models/cart_model.dart';
import '../../models/product_data.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'cart_screen.dart';

/// Page 13 — Product Details.
/// Image, name/price, color & size selectors, rating summary and an
/// "Add To Cart" bar pinned to the bottom.
class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedColor;
  String? _selectedSize;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.product.colors.isNotEmpty) _selectedColor = widget.product.colors.first;
    if (widget.product.sizes.isNotEmpty) _selectedSize = widget.product.sizes.first;
  }

  void _addToCart() {
    CartModel.instance.addItem(
      widget.product,
      color: _selectedColor,
      size: _selectedSize,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconButton(Icons.arrow_back, () => Navigator.of(context).pop()),
                  const Text(
                    'Product Details',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  _iconButton(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    () => setState(() => _isFavorite = !_isFavorite),
                    color: _isFavorite ? Colors.redAccent : AppColors.textDark,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 240,
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_outlined,
                          size: 72,
                          color: AppColors.dotInactive,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(product.name, style: AppTextStyles.heading),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating} (${product.reviewCount} reviews)',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'About Product',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description, style: AppTextStyles.body),
                    if (product.colors.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Choose Color',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: product.colors.map((color) {
                          final isSelected = color == _selectedColor;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = color),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _colorFromName(color),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    if (product.sizes.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Select Size',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: product.sizes.map((size) {
                          final isSelected = size == _selectedSize;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedSize = size),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : const Color(0xFFF5F5FA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Add To Cart',
                      onPressed: () {
                        _addToCart();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap, {Color color = AppColors.textDark}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Color _colorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      default:
        return AppColors.dotInactive;
    }
  }
}
