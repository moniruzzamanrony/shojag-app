
import 'dart:ui';

import 'package:app/core/config/theme/app_colors.dart';

/// Extension on Color
extension ColorExtension on Color {
  /// Method to get the luminance of the color
  Color get determineTextColor =>
      computeLuminance() > 0.5 ? AppColors.colorBlack : AppColors.colorWhite;

  /// Method to get the shade of the color
  Color shade(int value, {bool darker = false}) => Color.alphaBlend(
      darker
          ? AppColors.colorBlack.withAlpha(value)
          : AppColors.colorWhite.withAlpha(value),
      this);
}
