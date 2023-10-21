import 'package:flutter/material.dart';
import 'package:petto_app/config/constants/colors.dart';

class AppTheme {
  static lightTheme() => ThemeData(
      colorScheme: const ColorScheme.light(
        background: lightBackground,
        primary: lightPrimary,
        primaryContainer: lightPrimaryContainer,
        secondary: lightSecondary,
        secondaryContainer: lightSecondaryContainer,
        tertiary: lightTertiary,
        tertiaryContainer: lightTertiaryContainer,
        surface: lightSurface,
        surfaceVariant: lightSurfaceVariant,
      ),
      scaffoldBackgroundColor: Colors.white);

  static ThemeData darkTheme() => ThemeData(scaffoldBackgroundColor: Colors.grey);
}
