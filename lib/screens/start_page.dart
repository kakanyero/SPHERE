import 'package:flutter/material.dart';
import 'package:sphere/screens/user_profile/profile_screen.dart';
import './home_screen.dart';
import './wishlist_screen.dart';
import './cart_screen.dart';
import 'package:sphere/utils/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0;//

  final List<Widget> _pages = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.background,
          labelTextStyle: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return GoogleFonts.pacifico(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primaryDark,
              );
            }
            return TextStyle(color: AppColors.textGrey);
          }),
          iconTheme: WidgetStateProperty.all(
            IconThemeData(color: AppColors.textGrey),
          ),
          indicatorColor: AppColors.primary,
        ),
        child: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          selectedIndex: _currentIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: "Wishlist",
              selectedIcon: Icon(Icons.favorite),
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Cart",
              selectedIcon: Icon(Icons.shopping_cart),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_outlined),
              label: "Profile",
              selectedIcon: Icon(Icons.person_2),
            ),
          ],
        ),
      ),
    );
  }
}