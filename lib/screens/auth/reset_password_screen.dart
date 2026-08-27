import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/circle_back_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import 'reset_password_success_screen.dart';

/// Page 10 — Reset Password.
/// New password + confirm password, with a match check before submit.
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // TODO: call your "reset password" API here.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ResetPasswordSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleBackButton(onTap: () => Navigator.of(context).pop()),
                const SizedBox(height: 24),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Your new password must be different from previously '
                    'used passwords.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'New Password',
                  hint: 'Enter new password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) =>
                      (value == null || value.length < 6)
                          ? 'Password must be at least 6 characters'
                          : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter new password',
                  controller: _confirmController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'Reset Password',
                  isLoading: _isLoading,
                  onPressed: _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
