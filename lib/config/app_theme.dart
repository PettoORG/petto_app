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
          shadow: lightShadowColor,
        ),
        scaffoldBackgroundColor: lightBackground,
        iconTheme: IconThemeData(color: lightIconColor, size: 8.w),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(7.5.w),
            iconColor: const MaterialStatePropertyAll(lightIconColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackground,
          surfaceTintColor: lightBackground,
          titleTextStyle:
              TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa', color: Colors.black),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 10,
            disabledBackgroundColor: lightSurfaceVariant,
            backgroundColor: lightPrimary,
            shadowColor: lightShadowColor,
            textStyle: TextStyle(fontSize: 13.sp),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
            side: const BorderSide(color: lightPrimary),
            foregroundColor: Colors.white,
          ),
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
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: lightPrimaryContainer),
              borderRadius: BorderRadius.circular(5.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: lightPrimary),
              borderRadius: BorderRadius.circular(5.w),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: lightPrimary),
              borderRadius: BorderRadius.circular(5.w),
            ),
            errorStyle: const TextStyle(color: lightPrimary)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleSmall: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
        ),
      );

  static ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        colorScheme: const ColorScheme.dark(
          background: darkBackground,
          onSurfaceVariant: darkIconColor,
          primary: darkPrimary,
          primaryContainer: darkPrimaryContainer,
          secondary: darkSecondary,
          secondaryContainer: darkSecondaryContainer,
          tertiary: darkTertiary,
          tertiaryContainer: darkTertiaryContainer,
          surface: darkSurface,
          surfaceVariant: darkSurfaceVariant,
          onBackground: darkIconColor,
          shadow: darkShadowColor,
        ),
        scaffoldBackgroundColor: darkBackground,
        iconTheme: IconThemeData(color: darkIconColor, size: 8.w),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(7.5.w),
            iconColor: const MaterialStatePropertyAll(darkIconColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkBackground,
          surfaceTintColor: darkBackground,
          titleTextStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 10,
            disabledBackgroundColor: darkSurfaceVariant,
            backgroundColor: darkPrimary,
            shadowColor: darkShadowColor,
            textStyle: TextStyle(fontSize: 13.sp),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
            side: const BorderSide(color: darkPrimary),
            foregroundColor: Colors.white,
          ),
        ),
        datePickerTheme: const DatePickerThemeData(backgroundColor: darkPrimaryContainer),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontFamily: 'Comfortaa', fontSize: 12.sp),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: darkSurfaceVariant,
            prefixIconColor: darkTextColor2,
            labelStyle: TextStyle(fontSize: 12.sp, color: darkTextColor2),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkShadowColor),
              borderRadius: BorderRadius.circular(5.w),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: darkShadowColor),
              borderRadius: BorderRadius.circular(5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkPrimaryContainer),
              borderRadius: BorderRadius.circular(5.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkPrimary),
              borderRadius: BorderRadius.circular(5.w),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkPrimary),
              borderRadius: BorderRadius.circular(5.w),
            ),
            errorStyle: const TextStyle(color: darkPrimary)),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          titleSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          bodyLarge: TextStyle(fontSize: 14.sp),
          bodyMedium: TextStyle(fontSize: 12.sp),
          bodySmall: TextStyle(fontSize: 11.sp),
        ),
      );
}
