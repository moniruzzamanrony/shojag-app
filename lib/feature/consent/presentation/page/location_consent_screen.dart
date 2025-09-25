import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_text/styled_text.dart';

import '../../../../core/utils/style/style.dart';

class LocationConsentScreen extends StatelessWidget {
  const LocationConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.shade(248),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop(false);
                  }
                },
                child: Text(context.language.cancel)),
            FilledButton(
                onPressed: () {
                  final locationProvider = context.location;
                  PermissionHelper.requestLocationPermission.then((value) {
                    if (value && context.mounted) {
                      locationProvider.updateLocationConsent(consent: true);
                      context.pop(true);
                    }
                  });
                },
                child: Text(context.language.agreeAndContinue)),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: Styles.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.gapH,
                Center(
                  child: Text(
                    context.language.locationAccessRequired,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorAppGrey,
                    ),
                  ),
                ),
                Center(
                    child: SimpleLottie(Assets.locationPinAnimationJson,
                        height: 180.h)),
                10.gapH,
                Text(
                  context.language.shojagCollectsYourLocationDataTo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.gapH,
                _buildStyleText(
                    context.language.shojagLocationDataUsageMessages),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StyledText _buildStyleText(String text) {
    return StyledText(
      text: text,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 12.sp),
      tags: {
        'tab1': StyledTextWidgetTag(SizedBox(width: 20.w)),
        'icon': StyledTextIconTag(
          Icons.location_on_rounded,
          size: 12.sp,
        ),
        'bold': StyledTextTag(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        'red': StyledTextTag(
          style: TextStyle(color: Colors.red.shade(50)),
        ),
      },
    );
  }
}
