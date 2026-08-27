import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Centered "Or" divider with two compact icon-only square buttons
/// (Google, Facebook) beneath it — matches the Sign Up / Sign In
/// mockups, which use small icon buttons rather than full-width
/// labeled ones.
class SocialAuthRow extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;

  const SocialAuthRow({super.key, this.onGoogleTap, this.onFacebookTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.dotInactive)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Or',
                style: TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.dotInactive)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialIconButton(
              imagePath: 'assets/images/google.png',
              onTap: onGoogleTap,
            ),
            const SizedBox(width: 16),
            _SocialIconButton(
              imagePath: 'assets/images/facebook.png',
              onTap: onFacebookTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const _SocialIconButton({
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5FA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error_outline,
              size: 20,
              color: AppColors.dotInactive,
            ),
          ),
        ),
      ),
    );
  }
}