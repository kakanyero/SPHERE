import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/primary_button.dart';
import 'sign_in_screen.dart';

/// Page 11 — "New Password Set Successfully!" confirmation.
/// Dark-panel success card with a scale-in check icon, matching the
/// bottom-sheet-style confirmation in the design.
class ResetPasswordSuccessScreen extends StatefulWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  State<ResetPasswordSuccessScreen> createState() =>
      _ResetPasswordSuccessScreenState();
}

class _ResetPasswordSuccessScreenState
    extends State<ResetPasswordSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1E2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 48),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'New Password Set\nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your password has been changed. You can now sign in '
                'with your new password.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: 'Go To Sign In',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
