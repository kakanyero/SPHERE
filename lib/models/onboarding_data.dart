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
    image: 'assets/images/onboarding/onboarding_1.jpg',
    title: 'Endless Choices, Easy\n& Quick Purchases',
    description:
        'From fashion to electronics, discover thousands of products '
        'and check out in just a few taps.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding/onboarding_2.jpg',
    title: 'Dive Into A Hassle-Free\nShopping Experience',
    description:
        'Browse by category, save favorites to your wishlist, and '
        'track every order from cart to doorstep.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding/onboarding_3.jpg',
    title: 'Find All You Online,\nExplore & Easy',
    description:
        'Everything you need is right here — search, compare, and '
        'shop smarter without ever leaving the app.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding/onboarding_4.jpg',
    title: 'Dive Into A World\nOf Convenience',
    description:
        'Secure payments, fast delivery, and real-time order '
        'tracking — shopping made simple, wherever you are.',
  ),];
