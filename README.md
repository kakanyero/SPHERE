# Sphere Flutter Mobile App

A Flutter/Dart implementation of the e-commerce mobile UI kit — onboarding,
authentication, home/shopping, and checkout flows, built screen-by-screen
to match the provided design.

## Folder Structure

```
lib/
├── main.dart                          # App entry point — launches SplashScreen
│
├── models/
│   ├── onboarding_data.dart           # OnboardingItem model + the 4 slides' content
│   ├── product_data.dart              # Product model + sample catalog + categories
│   └── cart_model.dart                # CartItem + CartModel (app-wide cart state)
│
├── screens/
│   ├── splash_screen.dart                 # 1. Splash
│   │
│   ├── onboarding_screen.dart             # 2-5. Onboarding (4 slides, PageView,
│   │                                       #      auto-advance, Skip/dots/arrow,
│   │                                       #      Sign In/Sign Up on the last slide)
│   │
│   ├── sign_up_screen.dart                # 6. Sign Up
│   ├── sign_in_screen.dart                # 7. Sign In
│   ├── forgot_password_screen.dart        # 8. Forgot Password
│   ├── otp_screen.dart                    # 9. Enter Your OTP
│   ├── reset_password_screen.dart         # 10. Reset Password
│   ├── reset_password_success_screen.dart # 11. Password Reset Success
│   │
│   ├── home_screen.dart                   # 12. Home (search, categories, product grid)
│   ├── product_details_screen.dart        # 13. Product Details
│   ├── wishlist_screen.dart               # 14. Wishlist
│   ├── cart_screen.dart                   # 15. My Cart
│   ├── checkout_screen.dart               # 16. Checkout
│   ├── shipping_address_screen.dart       # 17. Shipping Address
│   ├── payment_method_screen.dart         # 18. Payment Method
│   ├── add_card_screen.dart               # 19. Add Card
│   ├── payment_successful_screen.dart     # 20. Payment Successful
│   └── e_receipt_screen.dart              # 21. E-Receipt
│
├── utils/
│   └── app_theme.dart                 # AppColors and AppTextStyles constants
│
└── widgets/
    ├── onboarding_page_widget.dart    # Single onboarding slide (image + title + desc)
    ├── dot_indicator.dart             # Animated page-progress dots
    ├── circle_back_button.dart        # Circular back-arrow button (auth screens)
    ├── custom_text_field.dart         # Styled input field w/ optional password toggle
    ├── social_auth_row.dart           # "Or" divider + Google/Facebook icon buttons
    ├── primary_button.dart            # Full-width CTA button w/ loading state
    ├── product_card.dart              # Grid product card (image, favorite, price)
    └── cart_item_tile.dart            # Cart line item w/ quantity stepper
```

## Screen Flow

```
Splash
  └─▶ Onboarding (4 slides)
        ├─▶ Sign In ──▶ Home
        └─▶ Sign Up ──▶ Sign In ──▶ Home

Sign In
  └─▶ Forgot Password ──▶ Enter OTP ──▶ Reset Password ──▶ Reset Success ──▶ Sign In

Home
  ├─▶ Product Details ──▶ Cart
  ├─▶ Wishlist ──▶ Product Details
  └─▶ Cart ──▶ Checkout
                 ├─▶ Shipping Address (returns selection)
                 ├─▶ Payment Method ──▶ Add Card (returns selection)
                 └─▶ Continue To Payment ──▶ Payment Successful ──▶ E-Receipt
```

## Not Yet Built

These screens appear in the design but aren't implemented yet:

- Search, filters, and search results
- Side menu / drawer
- My Orders (ongoing / completed / cancelled) + order tracking
- Ratings & reviews (view + submit with photo/video)
- Delivery address map view
- Profile + Edit Profile
- Notifications
- Invite Friend

## Notes

- State is kept minimal and local (`setState` + a single `CartModel`
  singleton) — swap in `provider`, `riverpod`, or `bloc` as the app grows.
- All network/auth calls are stubbed with `TODO` comments and a fake
  `Future.delayed` — wire these up to your backend.
- Image assets use `errorBuilder` fallbacks so the app runs before you've
  added real illustrations/product photos.
## Packages 

- elegant_notifications for notifications
- loading_animation