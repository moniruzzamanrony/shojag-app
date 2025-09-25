import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// [AppTextTheme] class contains all the text styles used in the app
///
abstract class AppTextTheme {
  const AppTextTheme._();

  static final TextTheme _appFont = GoogleFonts.interTextTheme();

  static TextTheme buildTextTheme(Brightness brightness) {
    final brightnessStyle = TextStyle(
        color: brightness == Brightness.dark
            ? AppColors.defaultTextColorDark
            : AppColors.defaultTextColorLight);

    return _appFont.copyWith(
      //display
      displayLarge: _appFont.displayLarge
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 57.sp),
      displayMedium: _appFont.displayMedium
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 45.sp),
      displaySmall: _appFont.displaySmall
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 44.sp),

      // headline
      headlineLarge: _appFont.headlineLarge
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 32.sp),
      headlineMedium: _appFont.headlineMedium
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 28.sp),
      headlineSmall: _appFont.headlineSmall
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 24.sp),

      // title
      titleLarge:
          _appFont.titleLarge?.merge(brightnessStyle).copyWith(fontSize: 22.sp),
      titleMedium: _appFont.titleMedium
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 16.sp),
      titleSmall:
          _appFont.titleSmall?.merge(brightnessStyle).copyWith(fontSize: 14.sp),

      // body
      bodyLarge:
          _appFont.bodyLarge?.merge(brightnessStyle).copyWith(fontSize: 16.sp),
      bodyMedium:
          _appFont.bodyMedium?.merge(brightnessStyle).copyWith(fontSize: 14.sp),
      bodySmall:
          _appFont.bodySmall?.merge(brightnessStyle).copyWith(fontSize: 12.sp),

      // label
      labelLarge:
          _appFont.labelLarge?.merge(brightnessStyle).copyWith(fontSize: 14.sp),
      labelMedium: _appFont.labelMedium
          ?.merge(brightnessStyle)
          .copyWith(fontSize: 12.sp),
      labelSmall:
          _appFont.labelSmall?.merge(brightnessStyle).copyWith(fontSize: 11.sp),
    );
  }
}
