import 'package:flutter/material.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static lightTheme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
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
            onBackground: lightIconColor),
        scaffoldBackgroundColor: lightBackground,
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(8.w),
            iconColor: const MaterialStatePropertyAll(lightIconColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style:
                ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontFamily: 'Comfortaa', fontSize: 12.sp)))),
        textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
            titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
            bodyLarge: TextStyle(fontSize: 14.sp)),
      );
  static ThemeData darkTheme() => ThemeData(scaffoldBackgroundColor: Colors.grey);
}
