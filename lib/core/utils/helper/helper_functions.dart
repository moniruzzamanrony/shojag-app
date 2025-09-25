// this file [helper_functions.dart] is used for helper functions
// It contains the following functions:
// 1. showAppSnackBar
// 2. trimToElevenDigits
// 3. hideAppKeyboard
// 4. showAppDialog
// 5. getAssetsSvgByUserType
// 6. getAssetsSvgByAlertType
// 7. getCardBorderColorByUserType
// 8. getCardBorderColorByAlertType
// 9. getCardColorByAlertType
// 10. showProgressDialog
// 11. getCardColorByUserType
// 12. getCardBorderColorByAlertType
// 13. getCardColorByAlertType
// 14. showProgressDialog
// 15. showDatePickerDialog
// 16. stringToListWithRx
// 17. stringToList
// 18. filterList
// 19. getMillisecondsSinceEpoch
// 20. today
// 21. generateRemoteImageUrl


import 'dart:async';

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/enums/message_type.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/helper/datetime_helper.dart';
import '../constants/app_constants.dart';
import '../constants/dimens.dart';
import '../enums/user_type.dart';

void showAppSnackBar(
  BuildContext context,
  String? msg, {
  SnackBarAction? action,
  int durationInSeconds = 2,
  required MessageType type,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  bool hasRadius = true,
  EdgeInsets? padding,
  bool alignBottom = true,
  DismissDirection? direction,
  ShapeBorder? shape,
}) {
  Color mainColor=getMessageColor(type);
  Color color = mainColor.shade(220);
  Color shadowColor = mainColor.shade(100);
  Color textColor = color.determineTextColor;

  final isFixed = behavior == SnackBarBehavior.fixed;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isFixed ? null : Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.none,
      behavior: behavior,
      padding: isFixed ? null : EdgeInsets.zero,
      dismissDirection: direction,
      shape: shape,
      //width: 400,
      //margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: isFixed
          ? null
          : alignBottom
              ? null
              : const EdgeInsets.only(bottom: 110),

      content: Container(
          padding: isFixed
              ? null
              : padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: isFixed ? null : color,
            boxShadow: Styles.boxShadow(color: shadowColor, colorOpacity: 0.6),
            borderRadius:
                hasRadius ? BorderRadius.circular(Dimens.borderRadius30) : null,
          ),
          child: Text(
            msg ?? 'Error',
            textAlign: isFixed ? TextAlign.start : TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: textColor, height: 1),
          )),
      duration: Duration(seconds: durationInSeconds),
      action: action,
    ),
  );
}

String trimToElevenDigits(String phoneNumber) {
  // Remove non-numeric characters
  String sanitizedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Remove the country code '88' if present at the beginning
  if (sanitizedNumber.startsWith('88')) {
    sanitizedNumber = sanitizedNumber.substring(2);
  }

  // Ensure the number is trimmed to the last 11 digits if it exceeds 11 digits
  if (sanitizedNumber.length > 11) {
    sanitizedNumber = sanitizedNumber.substring(sanitizedNumber.length - 11);
  }

  return sanitizedNumber;
}

void hideAppKeyboard(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

Future<T?> showAppDialog<T>(BuildContext context,
    {required Widget dialogWidget,
    bool barrierDismissible = true,
    bool hasBarrier = true}) async {
  final barrierColor = hasBarrier ? const Color(0x80000000) : Colors.transparent;
  return await showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dialog Outside',
    barrierColor: barrierColor,
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialogWidget;
    },
  );
}

String getAssetsSvgByUserType(UserType type) {
  switch (type) {
    case UserType.citizen:
      return Assets.citizenSvg;
    case UserType.police:
      return Assets.policeSvg;
    case UserType.ambulance:
      return Assets.ambulanceSvg;
    case UserType.fireService:
      return Assets.fireServiceSvg;
    default:
      return '';
  }
}

String getAssetsSvgByAlertType(AlertType type) {
  switch (type) {
    case AlertType.community:
      return Assets.citizenSvg;
    case AlertType.police:
      return Assets.policeSvg;
    case AlertType.ambulance:
      return Assets.ambulanceSvg;
    case AlertType.fireService:
      return Assets.fireServiceSvg;
    default:
      return '';
  }
}

Color getCardBorderColorByUserType(UserType type) {
  switch (type) {
    case UserType.citizen:
      return AppColors.communityCardBorderColor;
    case UserType.police:
      return AppColors.policeCardBorderColor;
    case UserType.ambulance:
      return AppColors.ambulanceCardBorderColor;
    case UserType.fireService:
      return AppColors.fireServiceCardBorderColor;
    default:
      return AppColors.colorBlack;
  }
}

Color getCardColorByUserType(UserType type) {
  switch (type) {
    case UserType.citizen:
      return AppColors.communityCardColor;
    case UserType.police:
      return AppColors.policeCardColor;
    case UserType.ambulance:
      return AppColors.ambulanceCardColor;
    case UserType.fireService:
      return AppColors.fireServiceCardColor;
    default:
      return AppColors.colorBlack;
  }
}

Color getCardBorderColorByAlertType(AlertType type) {
  switch (type) {
    case AlertType.community:
      return AppColors.communityCardBorderColor;
    case AlertType.police:
      return AppColors.policeCardBorderColor;
    case AlertType.ambulance:
      return AppColors.ambulanceCardBorderColor;
    case AlertType.fireService:
      return AppColors.fireServiceCardBorderColor;
    default:
      return AppColors.colorBlack;
  }
}

Color getCardColorByAlertType(AlertType type) {
  switch (type) {
    case AlertType.community:
      return AppColors.communityCardColor;
    case AlertType.police:
      return AppColors.policeCardColor;
    case AlertType.ambulance:
      return AppColors.ambulanceCardColor;
    case AlertType.fireService:
      return AppColors.fireServiceCardColor;
    default:
      return AppColors.colorBlack;
  }
}

Future<dynamic> showProgressDialog(BuildContext context,
    {String? customMessage}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
            contentPadding: const EdgeInsets.all(8.0),
            children: [
              ListTile(
                title: Text(customMessage ?? 'Please Wait...'),
                trailing: const CircularProgressIndicator(),
              ),
            ],
          ));
}

Future<DateTime?> showDatePickerDialog({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1970),
    lastDate: lastDate ?? DateTime(2030),
  );
  return selectedDate;
}

List<String> stringToListWithRx(String str) {
  // Use a regular expression to remove all unwanted characters
  String cleanedVal = str.replaceAll(RegExp(r'[^0-9a-zA-Z,-]'), '');

  // Split the string by commas to get a list
  List<String> numberList = cleanedVal.split(',');

  // Remove any empty strings from the list (in case there are multiple commas together)
  numberList = numberList.where((element) => element.isNotEmpty).toList();

  return numberList;
}

List<String> stringToList(String str) {
  // Split the string by commas to get a list
  List<String> list = str.split(',');

  // Remove any empty strings from the list (in case there are multiple commas together)
  list = list.where((element) => element.isNotEmpty).toList();

  return list;
}

List<String> filterList(List<String> list, String search) {
  return list.where((element) => element.contains(search)).toList();
}

num get getMillisecondsSinceEpoch => getCurrentDateTime.millisecondsSinceEpoch;

DateTime get today => DateTime.now()
    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

String generateRemoteImageUrl({required String endPoint}) {
  if (endPoint.isEmpty) {
    return '';
  }
  return '${AppConstants.appImageLoadBaseUrl}$endPoint';
}
