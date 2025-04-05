import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryBlue,
      background: AppColors.lightBackground,
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
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryBlue,
      background: AppColors.darkBackground,
    ),
    textTheme: const TextTheme(
      headlineSmall: AppTextStyles.headlineSmall,
      bodyMedium: AppTextStyles.bodyMedium,
      titleLarge: AppTextStyles.titleLarge,
      labelLarge: AppTextStyles.labelLarge,
    ),
  );
}
