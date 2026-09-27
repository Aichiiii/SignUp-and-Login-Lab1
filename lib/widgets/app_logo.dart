import 'package:flutter/material.dart';

// Displays the app's logo (assets/images/app_logo.png) inside a
// softly-shadowed rounded square. Used on Login, Sign Up, and Home.
class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.28),
        child: Image.asset(
          'assets/app_logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}