import 'package:flutter/material.dart';
import 'package:sphere/screens/start_page.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/circle_back_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/social_auth_row.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';
//import '../home_screen.dart';

/// Page 7 — Sign In.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // TODO: call your sign-in API here.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const StartPage()),
      (route) => false,
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
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Welcome back to the Sphere family! '
                    'Let\'s find your next favorite thing.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 32),
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
                      (value == null || value.isEmpty)
                          ? 'Please enter your password'
                          : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Sign In',
                  isLoading: _isLoading,
                  onPressed: _handleSignIn,
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
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't Have An Account? ",
                        style: AppTextStyles.body,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
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
