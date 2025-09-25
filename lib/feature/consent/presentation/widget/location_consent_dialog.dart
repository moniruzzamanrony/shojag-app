import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/enums/message_type.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_text/styled_text.dart';

import '../../../../core/utils/helper/permission_helper.dart';
import '../../../../core/utils/style/style.dart';

class LocationConsentDialog extends StatelessWidget {
  const LocationConsentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final background = context.colorScheme.primary.shade(245);
    final textColor = context.colorScheme.onPrimary.shade(220, darker: true);
    return Dialog(
      backgroundColor: background,
      insetPadding: Styles.horizontalPadding,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.gapH,
              Text('Location Permission Required',
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 16.sp)),
              10.gapH,
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary.shade(220)),
                  child: SimpleLottie(Assets.locationPinAnimationJson,
                      height: 80.h, width: 80.w)),
              10.gapH,
              _textInfo(),
              10.gapH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => context.pop(false),
                      child: const Text('Cancel')),
                  16.gapW,
                  FilledButton(
                      onPressed: () {
                        PermissionHelper.requestLocationPermission.onError(
                          (error, stackTrace) {
                            if (context.mounted) {
                              showAppSnackBar(context, error.toString(),
                                  type: MessageType.error);
                            }
                            return false;
                          },
                        ).then((value) {
                          if (context.mounted) {
                            context.pop(value);
                          }
                        });
                      },
                      child: const Text('Agree and Continue')),
                ],
              ),
              10.gapH,
            ],
          ),
        ),
      ),
    );
  }

  StyledText _textInfo() {
    final textStyle =
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, height: 1.5);
    final text =
        '<bold>Shojag collects location data to-</bold>\n\n<bullet>identify your current location,</bullet>\n<bullet>notify you about nearest incident report,</bullet>\n<bullet>notify your friend and family when you arrive at specific places,</bullet>\n<bullet>and share your real time location with your selected contacts,</bullet>\n\n<bold>even when the app is closed or not in use.</bold>';

    return StyledText(
      text: text,
      style: textStyle,
      tags: {
        'bold': StyledTextTag(
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        'italics': StyledTextTag(
            style: textStyle.copyWith(fontStyle: FontStyle.italic)),
        'bullet': StyledTextWidgetBuilderTag((ctx, data, attributes) {
          return Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                  child: FaIcon(
                    FontAwesomeIcons.solidCircle,
                    size: 6.sp,
                    color: AppColors.colorAppGrey,
                  ),
                ),
                if (attributes != null)
                  Flexible(
                      child: Text(attributes,
                          style: textStyle.copyWith(
                              height: 1.5,
                              fontSize: 11.sp,
                              color: AppColors.colorAppGrey)))
              ],
            ),
          );
        }),
      },
    );
  }
}
