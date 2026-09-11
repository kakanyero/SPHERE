import 'package:flutter/material.dart';
import 'package:sphere/screens/start_page.dart';
import '../../../utils/app_theme.dart';
//import '../../../widgets/circle_back_button.dart';
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
                      'Sign In',
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
                      'Welcome back to the Sphere family! '
                      'Let\'s find your next favorite thing.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        height: 1.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Card-like container wrapping the fields, giving the
                  // form a gentle sense of grouping and elevation.
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
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
                      label: 'Sign In',
                      isLoading: _isLoading,
                      onPressed: _handleSignIn,
                    ),
                  ),
                 
                  
                  const SizedBox(height: 20),
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
                        text: TextSpan(
                          text: "Don't Have An Account? ",
                          style: AppTextStyles.body.copyWith(
                            color: AppTextStyles.body.color?.withOpacity(0.7),
                          ),
                          children: const [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}