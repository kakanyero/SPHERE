import 'package:flutter/material.dart';
import '../models/onboarding_data.dart';
import '../utils/app_theme.dart';

/// Renders a single onboarding slide: illustration, title, description.
/// Used inside a PageView by OnboardingScreen. The illustration sits in
/// a light-grey card inset from the screen edges with all four corners
/// curved; the title/description sit on the plain white screen
/// background below it, matching the reference design.
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPageWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.onboardingImageBg,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Image.asset(
                  item.image,
                  fit: BoxFit.contain,
                  // Falls back gracefully if the asset isn't bundled yet.
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_outlined,
                    size: 120,
                    color: AppColors.dotInactive,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 12),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}