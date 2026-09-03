import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/circle_back_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/social_auth_row.dart';
import 'sign_in_screen.dart';

/// Page 6 — Sign Up.
/// Collects name, email, password, agreement checkbox, then would
/// hand off to email verification / home. Wire _handleSignUp to your
/// auth backend when it's ready.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ElegantNotification.error(
	title:  Text("Terms & Conditions"),
	description:  Text("Please agree to the terms & conditions"),
 
  
).show(context);
      return;
    }

    setState(() => _isLoading = true);
    // TODO: call your sign-up API here.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
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
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    ' Sign up today for early access to sales,'
                    'personalized recommendations, and faster checkout',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Full Name',
                  controller: _nameController,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                          ? 'Please enter your name'
                          : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email Address',
                  hint: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  hint: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) =>
                      (value == null || value.length < 6)
                          ? 'Password must be at least 6 characters'
                          : null,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _agreedToTerms,
                        activeColor: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) =>
                            setState(() => _agreedToTerms = value ?? false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'I agree to the terms & conditions',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Sign Up',
                  isLoading: _isLoading,
                  onPressed: _handleSignUp,
                ),
                const SizedBox(height: 28),
                SocialAuthRow(
                  onGoogleTap: () {},
                  onFacebookTap: () {},
                ),
                const SizedBox(height: 28),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already Have An Account? ',
                        style: AppTextStyles.body,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
