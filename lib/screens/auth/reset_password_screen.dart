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
      // Soft gradient backdrop instead of a flat fill — gives the screen
      // some depth without touching any widget structure below.
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.06),
              AppColors.background,
              AppColors.background,
            ],
            stops: const [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleBackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(height: 28),
                  // Small decorative accent above the title for a bit of
                  // visual anchor — purely cosmetic, no layout change.
                  Center(
                    child: Container(
                      width: 56,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Your new password must be different from previously '
                      'used passwords.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        height: 1.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Card-like container wrapping the two password fields,
                  // giving the form a gentle sense of grouping and lift.
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Subtle shadow beneath the primary button so it lifts
                  // off the page a little.
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.28),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: PrimaryButton(
                      label: 'Reset Password',
                      isLoading: _isLoading,
                      onPressed: _resetPassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}