import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import '../utils/app_theme.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins', // add to pubspec if you want this exact font
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
