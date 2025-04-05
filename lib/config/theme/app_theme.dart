import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: AppTextStyles.headlineSmall,
      bodyMedium: AppTextStyles.bodyMedium,
      titleLarge: AppTextStyles.titleLarge,
      labelLarge: AppTextStyles.labelLarge,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: AppTextStyles.headlineSmall,
      bodyMedium: AppTextStyles.bodyMedium,
      titleLarge: AppTextStyles.titleLarge,
      labelLarge: AppTextStyles.labelLarge,
    ),
  );
}
