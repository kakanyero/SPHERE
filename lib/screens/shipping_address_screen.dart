import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

/// Simple address model for the demo list below.
class _Address {
  final String label;
  final String detail;
  const _Address(this.label, this.detail);
}

/// Page 17 — Shipping Address.
/// Radio-selectable list of saved addresses; returns the chosen
/// address string to Checkout via Navigator.pop.
class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final List<_Address> _addresses = const [
    _Address('Home', '123 Main Street, New York'),
    _Address('Office', '45 Business Ave, New York'),
  ];

  int _selectedIndex = 0;

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
          'Shipping Address',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _addresses.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final address = _addresses[index];
                  final isSelected = index == _selectedIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          width: 1.4,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? AppColors.primary : AppColors.textGrey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address.label,
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 2),
                                Text(address.detail, style: AppTextStyles.body),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: const Text('Add New Address', style: TextStyle(color: AppColors.primary)),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Confirm',
              onPressed: () {
                final address = _addresses[_selectedIndex];
                Navigator.of(context).pop('${address.label} — ${address.detail}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
