import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'add_card_screen.dart';

/// Page 18 — Payment Method.
/// Radio-selectable list of payment options; "Add New Card" pushes to
/// AddCardScreen. Returns the chosen method string via Navigator.pop.
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<Map<String, dynamic>> _methods = const [
    {'label': 'Cash On Delivery', 'icon': Icons.payments_outlined},
    {'label': 'Credit / Debit Card', 'icon': Icons.credit_card_outlined},
    {'label': 'PayPal', 'icon': Icons.account_balance_wallet_outlined},
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
          'Payment Option',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _methods.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final method = _methods[index];
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
                          Icon(method['icon'] as IconData, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              method['label'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? AppColors.primary : AppColors.textGrey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddCardScreen()),
              ),
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: const Text('Add New Card', style: TextStyle(color: AppColors.primary)),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Confirm',
              onPressed: () => Navigator.of(context)
                  .pop(_methods[_selectedIndex]['label'] as String),
            ),
          ],
        ),
      ),
    );
  }
}
