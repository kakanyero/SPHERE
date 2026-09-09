import 'dart:async';
import 'package:flutter/material.dart';
import '../../../models/onboarding_data.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/dot_indicator.dart';
import '../../../widgets/onboarding_page_widget.dart';
import '../auth/sign_up_screen.dart';
import '../auth/sign_in_screen.dart';

/// Pages 2-5 — Onboarding flow.
/// A single PageView cycles through the 4 illustrated slides
/// ("Endless Choices...", "Hassle-Free Shopping...", "Find All You
/// Online...", "World Of Convenience"), each rendered by
/// OnboardingPageWidget. A bottom row holds Skip (left), the dot
/// indicator (center), and a circular arrow button (right) that
/// advances one slide at a time. On the last slide that row is
/// replaced with Sign In / Sign Up buttons. Slides also auto-advance
/// on a timer if the user doesn't tap or swipe.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const Duration _autoAdvanceDelay = Duration(seconds: 4);

  final PageController _pageController = PageController();
  Timer? _autoAdvanceTimer;
  int _currentIndex = 0;

  bool get _isLastPage => _currentIndex == onboardingItems.length - 1;

  @override
  void initState() {
    super.initState();
    _scheduleAutoAdvance();
  }

  /// (Re)starts the auto-advance countdown for the current slide.
  /// Called on init and every time the page changes — whether from a
  /// manual swipe, the arrow button, or a previous auto-advance —
  /// so the timer always counts from the slide currently on screen.
  void _scheduleAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    if (_isLastPage) return; // Stop cycling once we reach the last slide.
    _autoAdvanceTimer = Timer(_autoAdvanceDelay, () {
      if (!mounted) return;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (_) => const SignInScreen()),
     );
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                  _scheduleAutoAdvance();
                },
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(item: onboardingItems[index]);
                },
              ),
            ),
            // Bottom controls — Skip/dots/arrow while cycling through
            // slides 1-3; swaps to Sign In / Sign Up buttons on the
            // last slide.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _isLastPage
                    ? _buildAuthButtons()
                    : _buildNavigationRow(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationRow() {
    return Row(
      key: const ValueKey('navigation'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 56,
          child: TextButton(
            onPressed: _finishOnboarding,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DotIndicator(
          count: onboardingItems.length,
          activeIndex: _currentIndex,
        ),
        GestureDetector(
          onTap: _goToNext,
          child: Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      key: const ValueKey('auth'),
      mainAxisSize: MainAxisSize.min,
      children: [
        DotIndicator(
          count: onboardingItems.length,
          activeIndex: _currentIndex,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
