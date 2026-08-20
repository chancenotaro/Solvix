import 'package:flutter/material.dart';

class SolvixTheme {
  // Core Solvix colors
  static const Color background = Color(0xff0d0d0d);
  static const Color surface = Color(0xFF151515);
  static const Color surfaceLight = Color(0xFF1e1e1e);

  static const Color primary = Color(0xFF00C853);
  static const Color primaryBright = Color(0xFF00E676);

  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primaryBright,
      surface: surface,
      surfaceContainer: surfaceLight,
      error: error,
    ),

    scaffoldBackgroundColor: background,

    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      foregroundColor: textPrimary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        color: textPrimary,
      ),
      bodySmall: TextStyle(
        color: textSecondary,
      ),
    ),

    cardTheme: const CardThemeData(
      color: surface,
      elevation: 0,
    ),

    dividerTheme: const DividerThemeData(
      color: surfaceLight,
    ),
  );
}