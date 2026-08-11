import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

/// Page 19 — Add Card.
/// A stylized card preview up top that updates live as the user types,
/// plus the underlying form fields.
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
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
          'Add Card',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardPreview(),
              const SizedBox(height: 28),
              CustomTextField(
                label: 'Cardholder Name',
                hint: 'Name on card',
                controller: _nameController,
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Card Number',
                hint: '1234 5678 9012 3456',
                controller: _numberController,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.replaceAll(' ', '').length < 16) ? 'Enter a valid card number' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Expiry Date',
                      hint: 'MM/YY',
                      controller: _expiryController,
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || v.length < 4) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'CVV',
                      hint: '123',
                      controller: _cvvController,
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || v.length < 3) ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Add Card',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return AnimatedBuilder(
      animation: Listenable.merge([_numberController, _nameController, _expiryController]),
      builder: (context, _) {
        return Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.wifi, color: Colors.white70),
              const Spacer(),
              Text(
                _numberController.text.isEmpty ? '•••• •••• •••• ••••' : _numberController.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _nameController.text.isEmpty ? 'CARDHOLDER NAME' : _nameController.text.toUpperCase(),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    _expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
