import 'package:flutter/material.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static lightTheme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        colorScheme: const ColorScheme.light(
            background: lightBackground,
            onSurfaceVariant: lightIconColor,
            primary: lightPrimary,
            primaryContainer: lightPrimaryContainer,
            secondary: lightSecondary,
            secondaryContainer: lightSecondaryContainer,
            tertiary: lightTertiary,
            tertiaryContainer: lightTertiaryContainer,
            surface: lightSurface,
            surfaceVariant: lightSurfaceVariant,
            onBackground: lightIconColor,
            shadow: lightShadowColor),
        scaffoldBackgroundColor: lightBackground,
        iconTheme: IconThemeData(color: lightIconColor, size: 9.w),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(8.w),
            iconColor: const MaterialStatePropertyAll(lightIconColor),
          ),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: lightBackground),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              elevation: 10,
              disabledBackgroundColor: lightSurfaceVariant,
              backgroundColor: lightPrimary,
              shadowColor: lightShadowColor,
              textStyle: TextStyle(fontSize: 13.sp),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
              side: const BorderSide(color: lightPrimary),
              foregroundColor: Colors.white),
        ),
        datePickerTheme: const DatePickerThemeData(backgroundColor: lightPrimaryContainer),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontFamily: 'Comfortaa', fontSize: 12.sp),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightSurfaceVariant,
          prefixIconColor: lightTextColor2,
          labelStyle: TextStyle(fontSize: 12.sp, color: lightTextColor2),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lightShadowColor),
            borderRadius: BorderRadius.circular(5.w),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: lightShadowColor),
            borderRadius: BorderRadius.circular(5.w),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          bodyLarge: TextStyle(fontSize: 14.sp),
          bodyMedium: TextStyle(fontSize: 12.sp),
        ),
      );

  static ThemeData darkTheme() => ThemeData(scaffoldBackgroundColor: Colors.grey);
}
