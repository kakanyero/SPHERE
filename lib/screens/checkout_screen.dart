import 'package:flutter/material.dart';
import '../../models/address_model.dart';
import '../../models/cart_model.dart';
import '../../services/order_service.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'shipping_address_screen.dart';
import 'payments/payment_method_screen.dart';
import 'payments/payment_successful_screen.dart';

/// Page 16 — Checkout. "Continue To Payment" now creates the order in
/// Supabase (place_order) before showing the success screen.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartModel _cart = CartModel.instance;
  String? _selectedAddress;
  String _selectedPayment = 'Cash On Delivery';
  bool _placing = false;

  @override
  void initState() {
    super.initState();
    _selectedAddress = _defaultAddressText();
  }

  String? _defaultAddressText() {
    final a = AddressRepository.instance.defaultAddress;
    return a == null ? null : '${a.labelText} — ${a.fullAddress}';
  }

  Future<void> _placeOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a shipping address first')),
      );
      return;
    }
    if (_cart.items.isEmpty) return;

    setState(() => _placing = true);
    try {
      await OrderService.instance.placeOrder(
        shippingAddress: _selectedAddress!,
        paymentMethod: _selectedPayment,
        shippingFee: CartModel.shippingFee,
      );
      if (!mounted) return;
      setState(() => _placing = false);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PaymentSuccessfulScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _placing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order failed: $e')),
      );
    }
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
          'Checkout',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order List',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 12),
            ..._cart.items.map((item) {
              const broken = Icon(Icons.image_outlined, size: 20, color: AppColors.dotInactive);
              final isNetwork = item.product.image.startsWith('http');
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isNetwork
                          ? Image.network(item.product.image,
                              fit: BoxFit.contain, errorBuilder: (_, _, _) => broken)
                          : Image.asset(item.product.image,
                              fit: BoxFit.contain, errorBuilder: (_, _, _) => broken),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${item.product.name}  x${item.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                    Text(
                      '\$${item.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            _sectionCard(
              title: 'Shipping Address',
              value: _selectedAddress ?? 'Tap to add a shipping address',
              icon: Icons.location_on_outlined,
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ShippingAddressScreen()),
                );
                if (mounted) setState(() => _selectedAddress = _defaultAddressText());
              },
            ),
            const SizedBox(height: 16),
            _sectionCard(
              title: 'Payment Method',
              value: _selectedPayment,
              icon: Icons.payment_outlined,
              onTap: () async {
                final result = await Navigator.of(context).push<String>(
                  MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
                );
                if (result != null) setState(() => _selectedPayment = result);
              },
            ),
            const SizedBox(height: 16),
            _sectionCard(
              title: 'Shipping Type',
              value: 'Economy (3-5 days)',
              icon: Icons.local_shipping_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _summaryRow('Subtotal', _cart.subtotal),
            const SizedBox(height: 8),
            _summaryRow('Shipping Fee', CartModel.shippingFee),
            const Divider(height: 28),
            _summaryRow('Total', _cart.total, isBold: true),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Continue To Payment',
              isLoading: _placing,
              onPressed: _placeOrder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.body),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
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