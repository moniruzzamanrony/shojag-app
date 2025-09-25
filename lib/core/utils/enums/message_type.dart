import 'dart:ui';

import '../../config/theme/app_colors.dart';

/// [MessageType] enum contains all the message types used in the app
/// It contains normal, error, info, warning, success
/// It shows the message type in the app for snackbar and toast
enum MessageType {
  normal,
  error,
  info,
  warning,
  success;
}

Color getMessageColor(MessageType type) {
  switch (type) {
    case MessageType.normal:
      return AppColors.colorAppBlueDark;

    case MessageType.error:
      return AppColors.colorAppRed;

    case MessageType.info:
      return AppColors.colorAppGrey;

    case MessageType.success:
      return AppColors.colorAppGreen;

    case MessageType.warning:
      return AppColors.colorAppYellow;
  }
}
