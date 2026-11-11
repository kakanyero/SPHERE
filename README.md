# SPHERE

**SPHERE** is a Flutter e-commerce mobile application that takes users from product discovery to checkout. It combines a polished shopping interface with Supabase-powered email authentication.

> Built as a hands-on Flutter portfolio project to explore production-style app flows, reusable UI components, local state, and backend authentication.

## Highlights

- Guided splash and four-step onboarding experience
- Email sign-up, sign-in, password reset, and OTP flows
- Product catalogue with categories, search UI, product details, and wishlist
- Shopping cart with quantity controls and checkout journey
- Shipping-address and payment-method selection flows
- Payment confirmation and e-receipt screens
- Supabase authentication integration
- Reusable widgets, models, theme constants, and service layer

## User journey

```text
Splash
  → Onboarding
  → Sign in / Sign up
  → Home
  → Product details
  → Cart
  → Checkout
  → Shipping & payment
  → Confirmation & e-receipt
```

## Tech stack

| Area | Tools |
|---|---|
| Framework | Flutter, Dart |
| Authentication | Supabase Auth |
| State & local data | setState, CartModel, sqflite |
| Networking | Dio |
| Design | Material 3, Google Fonts |
| Maps & media | Google Maps, Image Picker |

## Project structure

```text
lib/
├── models/       # Product, cart, and onboarding data models
├── screens/      # Authentication, shopping, checkout, and profile screens
├── services/     # Supabase authentication service
├── utils/        # Theme, colours, and shared styling
├── widgets/      # Reusable fields, buttons, cards, and UI components
└── main.dart     # Application entry point
```

## Getting started

### Prerequisites

- Flutter SDK (Dart 3)
- A Supabase project if you want authentication enabled
- Android Studio, VS Code, or another Flutter-ready editor

### Run locally

```bash
git clone https://github.com/kakanyero/SPHERE.git
cd SPHERE
flutter pub get
flutter run
```

### Configure Supabase

1. Create a project in [Supabase](https://supabase.com/).
2. Enable Email authentication.
3. Provide your project URL and publishable key through a local configuration method.
4. Keep any sensitive credentials out of Git and use environment-specific configuration for production.

## Current status

The main shopping and authentication flows are implemented as a portfolio app. Some features are still UI-first or use sample/local data rather than a complete production backend.

### Planned improvements

- Product search, filtering, and search results
- Order history, tracking, and notifications
- Ratings and reviews with image uploads
- Profile editing and address map selection
- Backend product, cart, order, and payment integration
- Automated tests and CI

## What I learned

- Building multi-screen Flutter navigation flows
- Designing reusable, consistent UI components
- Managing cart state and app data models
- Integrating Supabase email authentication
- Structuring a Flutter application for continued growth

## Author

**Kakanyero Innocent**  
Flutter Developer | Mobile & Web Applications  
[GitHub](https://github.com/kakanyero) · [Portfolio](https://portfolio-project-delta-seven.vercel.app/) · [LinkedIn](https://www.linkedin.com/in/kakanyero-innocent-11432b25b/)

---

If you find this project useful, feel free to star the repository.