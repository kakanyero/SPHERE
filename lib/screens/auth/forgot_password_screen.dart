import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/circle_back_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import 'otp_screen.dart';

/// Page 8 — Forgot Password.
/// Collects the account email and sends a reset code, then hands off
/// to the OTP screen.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // TODO: call your "send reset code" API here.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpScreen(email: _emailController.text.trim()),
      ),
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
                  //CircleBackButton(onTap: () => Navigator.of(context).pop()),
                  //const SizedBox(height: 28),
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
                      'Forgot Password',
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
                      'Enter your email address to receive a verification '
                      'code to reset your password.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        height: 1.4,
                        color:Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Card-like container wrapping the email field, giving
                  // the form a gentle sense of grouping and lift.
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
                    child: CustomTextField(
                      label: 'Email Address',
                      hint: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
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
                      label: 'Send Code',
                      isLoading: _isLoading,
                      onPressed: _sendCode,
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