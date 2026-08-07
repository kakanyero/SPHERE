import 'package:flutter/material.dart';
import '../models/onboarding_data.dart';
import '../utils/app_theme.dart';


/// Renders a single onboarding slide: illustration, title, description.
/// Used inside a PageView by OnboardingScreen.
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPageWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(      
      children: [
        
        // Image panel — plain lavender background, no curve here.
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            color: AppColors.onboardingImageBg,
            padding: const EdgeInsets.all(32),
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
        // Text panel — white background, curved up at the top so it
        // overlaps the image panel and reads as the curved element.
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
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