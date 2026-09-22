import 'package:flutter/material.dart';

/// Central place for colors, spacing and text styles used across
/// the e-commerce app so every screen stays visually consistent.
class AppColors {
  static const Color primary = Color(0xFF5B54F5); // indigo/purple accent
  static const Color primaryDark = Color(0xFF4A43D9);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5FA);
  static const Color textDark = Color(0xFF1D1E2C);
  static const Color textPrimary = Color(0xFF1D1E2C);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textGrey = Color(0xFF9A9AA8);
  static const Color dotInactive = Color(0xFFE3E1FB);
  static const Color onboardingImageBg = Color(0xFFF5F5F7);
  static const Color error = Color(0xFFDC2626);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.3,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.3,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}