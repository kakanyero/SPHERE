import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

/// Circular light-grey back button, matching the small round back
/// arrow shown at the top-left of Sign In, Sign Up, Forgot Password,
/// and OTP in the mockups (used instead of a default AppBar).
class CircleBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CircleBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5FA),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textDark),
      ),
    );
  }
}