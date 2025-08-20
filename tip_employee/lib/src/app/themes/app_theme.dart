import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors - Fresh green palette
  static const Color primaryColor = Color(0xFF2ECC71);      // Vibrant green
  static const Color primaryLight = Color(0xFFE8F5E9);      // Very light green
  static const Color primaryDark = Color(0xFF27AE60);       // Darker green
  
  // Secondary colors - Complementary palette
  static const Color secondaryColor = Color(0xFF3498DB);    // Calm blue
  static const Color accentColor = Color(0xFF9B59B6);       // Sophisticated purple
  
  // Neutral colors without gray
  static const Color cardColor = Color(0xFFFDFFFC);         // Off-white
  static const Color scaffoldBackground = Color(0xFFFFFFFF); // Pure white
  static const Color textPrimary = Color(0xFF2D3436);       // Charcoal
  static const Color textSecondary = Color(0xFF636E72);     // Muted blue-gray
  static const Color borderColor = Color(0xFFDDE4E8);       // Very light blue-gray
  
  // Semantic colors
  static const Color successColor = Color(0xFF00B894);      // Teal green
  static const Color errorColor = Color(0xFFD63031);        // Coral red
  static const Color warningColor = Color(0xFFFDCB6E);      // Soft yellow
  static const Color infoColor = Color(0xFF0984E3);         // Bright blue

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryDark,
      secondary: secondaryColor,
      surface: scaffoldBackground,
      background: scaffoldBackground,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: scaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: const CardThemeData(
      color: cardColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32, 
        fontWeight: FontWeight.bold, 
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28, 
        fontWeight: FontWeight.bold, 
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22, 
        fontWeight: FontWeight.w700, 
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 18, 
        fontWeight: FontWeight.w600, 
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16, 
        color: textPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14, 
        color: textSecondary,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        side: const BorderSide(color: primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: const TextStyle(color: textSecondary),
      hintStyle: const TextStyle(color: textSecondary),
    ),
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 1,
      space: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryLight,
      labelStyle: const TextStyle(color: textPrimary),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}