import 'package:flutter/material.dart';
import '../../models/cart_model.dart';
import '../../utils/app_theme.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/primary_button.dart';
import 'checkout_screen.dart';

/// Page 15 — My Cart.  
/// Cart line items plus an order summary (subtotal, shipping, total)
/// and a "Checkout" button.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartModel _cart = CartModel.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cart,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            leading: const BackButton(color: AppColors.textDark),
            title: const Text(
              'My Cart',
              style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
            ),
          ),
          body: _cart.items.isEmpty
              ? Center(child: Text('Your cart is empty', style: AppTextStyles.body))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: _cart.items.length,
                        itemBuilder: (context, index) {
                          final item = _cart.items[index];
                          return CartItemTile(
                            item: item,
                            onIncrement: () =>
                                _cart.updateQuantity(item, item.quantity + 1),
                            onDecrement: () =>
                                _cart.updateQuantity(item, item.quantity - 1),
                            onRemove: () => _cart.removeItem(item),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5FA),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Column(
                        children: [
                          _summaryRow('Subtotal', _cart.subtotal),
                          const SizedBox(height: 8),
                          _summaryRow('Shipping Fee', CartModel.shippingFee),
                          const Divider(height: 24),
                          _summaryRow('Total', _cart.total, isBold: true),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            label: 'Continue To Checkout',
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _summaryRow(String label, double value, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: isBold ? 16 : 14,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      color: isBold ? AppColors.textDark : AppColors.textGrey,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${value.toStringAsFixed(2)}', style: style.copyWith(color: AppColors.textDark)),
      ],
    );
  }
}
