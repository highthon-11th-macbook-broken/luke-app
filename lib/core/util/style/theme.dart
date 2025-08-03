import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.white,
        background: AppColors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTypography.heading1,
        headlineMedium: AppTypography.heading2,
        bodyLarge: AppTypography.body1,
        bodyMedium: AppTypography.body2,
      ),
      fontFamily: 'Freesentation',
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.black,
        background: AppColors.black,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTypography.heading1,
        headlineMedium: AppTypography.heading2,
        bodyLarge: AppTypography.body1,
        bodyMedium: AppTypography.body2,
      ),
      fontFamily: 'Freesentation',
    );
  }
}