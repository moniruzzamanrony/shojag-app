import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/config/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [AppTheme] class for app theme
/// It contains dark and light theme
class AppTheme {
  static ThemeData appThemeLight = _buildThemeLight();
  static ThemeData appThemeDark = _buildThemeDark();

  static ThemeData _buildThemeDark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return ThemeData(
        textTheme: AppTextTheme.buildTextTheme(Brightness.dark),
        colorScheme: const ColorScheme(
            primary: AppColors.colorAppGreen,
            onPrimary: AppColors.colorWhite,
            secondary: AppColors.colorAppRed,
            onSecondary: AppColors.colorWhite,
            surface: AppColors.colorWhite,
            onSurface: AppColors.colorAppGreenDark,
            error: Colors.red,
            onError: Colors.white,
            brightness: Brightness.dark));
  }

  static ThemeData _buildThemeLight() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: AppTextTheme.buildTextTheme(Brightness.light),
        colorScheme: const ColorScheme(
            primary: AppColors.colorAppGreen,
            onPrimary: AppColors.colorWhite,
            secondary: AppColors.colorAppRed,
            onSecondary: AppColors.colorWhite,
            surface: AppColors.colorWhite,
            onSurface: AppColors.colorAppGreenDark,
            error: Colors.red,
            onError: Colors.white,
            brightness: Brightness.light));
  }
}
