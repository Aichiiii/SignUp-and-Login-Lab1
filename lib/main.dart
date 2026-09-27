import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color brown = Color(0xFF7B4B2A);      // main / button color
  static const Color brownLight = Color(0xFF9C6B44);  // gradient accent
  static const Color brownDark = Color(0xFF4E3120);   // headings
  static const Color cream = Color(0xFFEFE9E5);       // background (brand-derived, light)
  static const Color fieldFill = Color(0xFFF1E4D6);   // pill input fill
  static const Color hint = Color(0xFF9C8577);
  static const Color success = Color(0xFF6E8B5A);     // subtle accent (checks, etc.)

  // Derived from `brown` (lightened) rather than a separate hue, so the
  // background stays in the same warm brown/cream family as the logo,
  // but light enough that body text stays easy to read.
  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEFE9E5), Color(0xFFDED2CA)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [brown, brownLight],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew — Login Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.brown,
          primary: AppColors.brown,
        ),
        fontFamily: 'Roboto',
      ),

      // Named routes (Navigation & Routing Lead's part)
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}