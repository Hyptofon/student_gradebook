import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

class AppTheme {
  AppTheme._();

  static const Color _seedColor = Colors.deepPurple;

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    cardTheme: const CardThemeData(
      elevation: 1,
      margin: AppDimensions.cardMargin,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.cardBorderRadius,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing12,
        vertical: AppDimensions.spacing10,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing24,
          vertical: AppDimensions.spacing12,
        ),
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    cardTheme: const CardThemeData(
      elevation: 1,
      margin: AppDimensions.cardMargin,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.cardBorderRadius,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing12,
        vertical: AppDimensions.spacing10,
      ),
    ),
  );
}
