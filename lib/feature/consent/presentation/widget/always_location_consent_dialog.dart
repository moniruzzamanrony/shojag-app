import 'dart:io';

import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/helper/permission_helper.dart';
import '../../../../core/utils/style/style.dart';

class AlwaysLocationConsentDialog extends StatelessWidget {
  const AlwaysLocationConsentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = context.colorScheme.onPrimary.shade(220, darker: true);
    final textStyle = TextStyle(color: textColor, fontSize: 12.sp);
    return Dialog(
      insetPadding: Styles.horizontalPadding,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.gapH,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                  context
                      .language.shojagCollectsBackgroundLocationToShareWithFnF,
                  textAlign: TextAlign.start,
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
            ),
            16.gapH,
            Text(
              context.language.toShareYourLocationEvenTheApp,
              textAlign: TextAlign.start,
              style: textStyle.copyWith(color: AppColors.colorAppGrey),
            ),
            16.gapH,
            Text(
              context.language.permissionLocationSettings,
              textAlign: TextAlign.justify,
              style: textStyle.copyWith(
                  color: context.colorScheme.secondary, fontSize: 10.sp),
            ),
            24.gapH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      context.pop(false);
                    },
                    child: Text(context.language.cancel)),
                16.gapW,
                FilledButton(
                  onPressed: () => _changePermission(context),
                  style: FilledButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  ),
                  child: Text(context.language.changePermission),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePermission(BuildContext context) async {
    if (Platform.isIOS) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        if (await Permission.locationAlways.request().isPermanentlyDenied) {
          openAppSettings();
        }
      } else {
        openAppSettings();
      }
    } else {
      if (await Permission.locationWhenInUse.isGranted ||
          await Permission.location.isGranted) {
        if (await Permission.locationAlways.request().isPermanentlyDenied) {
          await PermissionHelper.openSettings();
        }
      }
    }

    if (context.mounted) context.pop();
  }

// void _changePermission(BuildContext context) async {
//   if (Platform.isIOS) {
//     PermissionStatus whenInUseStatus =
//         await Permission.locationWhenInUse.request();
//
//     if (whenInUseStatus.isGranted) {
//       PermissionStatus alwaysStatus =
//           await Permission.locationAlways.request();
//
//       if (alwaysStatus.isGranted) {
//       } else if (alwaysStatus.isDenied) {
//       } else if (alwaysStatus.isPermanentlyDenied) {
//         openAppSettings();
//       }
//     } else if (whenInUseStatus.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   } else {
//     if (await Permission.location.isGranted ||
//         await Permission.locationWhenInUse.isGranted) {
//       if (await Permission.locationAlways.isPermanentlyDenied) {
//         await PermissionHelper.openSettings();
//       } else {
//         await Permission.locationAlways.request();
//       }
//     }
//   }
//
//   if (context.mounted) {
//     context.pop();
//   }
// }
}
