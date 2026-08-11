import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

/// Page 21 — E-Receipt.
/// Order number, date, payment method and a barcode-style footer,
/// styled like a torn paper receipt.
class EReceiptScreen extends StatelessWidget {
  const EReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final orderId = 'ORD${now.millisecondsSinceEpoch.toString().substring(5)}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: AppColors.textDark),
        title: const Text(
          'E-Receipt',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Payment Successful',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _row('Order ID', orderId),
                  _row('Date', '${now.day}/${now.month}/${now.year}'),
                  _row('Payment Method', 'Cash On Delivery'),
                  const Divider(height: 32),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.textDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(Icons.qr_code_2, color: Colors.white, size: 48),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Download PDF',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
