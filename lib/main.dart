import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import '../utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://renyxvwnwsdxglwducpf.supabase.co',
    publishableKey: 'sb_publishable_PyNgVz-bC0krhFYnP-d01A_Ozwz-j7x',
  );
  runApp(const SphereApp());
}

class SphereApp extends StatelessWidget {
  const SphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sphere',
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
