import 'package:cinemate/constants/app_colours.dart';
import 'package:flutter/material.dart';

final ThemeData cinemateTheme = lightTheme();

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    // brightness: Brightness.dark,
    primaryColor: AppColours.primary,
    // primaryContrastingColor: AppColours.onBg,
    scaffoldBackgroundColor: AppColours.bg,
    // barBackgroundColor: AppColours.bg,
    // fontFamily: "Gilroy",
    // applyThemeToAll: true,
    useMaterial3: true,
    textTheme: base.textTheme.copyWith(
      headlineLarge: const TextStyle(
          color: AppColours.onBg,
          fontWeight: FontWeight.w600,
          fontFamily: "Gilroy"),
      titleLarge: const TextStyle(
          color: AppColours.onBg,
          fontWeight: FontWeight.w600,
          fontFamily: "Gilroy"),
      titleMedium: const TextStyle(
          color: AppColours.onBg,
          fontWeight: FontWeight.w600,
          fontFamily: "Gilroy"),
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontFamily: "Gilroy",
      ),
      bodySmall: const TextStyle(
        color: Colors.white,
        fontFamily: "Gilroy",
      ),
    ),
  );
}
