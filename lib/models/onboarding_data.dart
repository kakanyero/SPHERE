/// Simple data holder for one onboarding slide.
class OnboardingItem {
  final String image;
  final String title;
  final String description;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

/// Content for onboarding pages 1-4 (matches the 4 illustrated
/// screens in the UI kit, shown after the splash screen).
const List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    image: 'assets/images/onboarding_1.jpg',
    title: 'Endless Choices, Easy\n& Quick Purchases',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_2.jpg',
    title: 'Dive Into A Hassle-Free\nShopping Experience',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_3.jpg',
    title: 'Find All You Online,\nExplore & Easy',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_4.jpg',
    title: 'Dive Into A World\nOf Convenience',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt.',
  ),
];
