import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF0B5D3B);
  static const Color darkGreen = Color(0xFF063A26);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFF081C15);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryGreen,

      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: gold,
        surface: Color(0xFF102A22),
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFF123126),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: gold,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
