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
      // Subtle radial-feeling gradient instead of a flat dark fill — a
      // touch of depth behind the icon without altering the layout.
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(const Color(0xFF1D1E2C), AppColors.primary, 0.08)!,
              const Color(0xFF1D1E2C),
              const Color(0xFF15161F),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
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
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.45),
                          blurRadius: 32,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'New Password Set\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your password has been changed. You can now sign in '
                  'with your new password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 44),
                // Subtle shadow beneath the primary button so it lifts
                // off the dark panel a little.
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: PrimaryButton(
                    label: 'Go To Sign In',
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false,
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