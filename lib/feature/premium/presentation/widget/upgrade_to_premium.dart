import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/config/router/routes.dart';

Future showPremiumBottomSheet(BuildContext context) async {
  return await showMaterialModalBottomSheet(
      context: context,
      builder: (_) => const UpgradeToPremium(),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      )));
}

class UpgradeToPremium extends StatelessWidget {
  const UpgradeToPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 330.h,
        child: CurvedBottomBackground(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              32.gapH,
              SvgPicture.asset(Assets.premiumCrownSvg, height: 80.h),
              16.gapH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.language.upgrade,
                    style: TextStyle(
                      fontSize: 20.sp,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  8.gapW,
                  Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Text(
                      context.language.pro,
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                          color: context.colorScheme.onPrimary),
                    ),
                  )
                ],
              ),
              8.gapH,
              Text(
                context.language.pleaseUpgradeToProToUnlockAllFeatures,textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: AppColors.colorAppGrey),
              ),
              8.gapH,
              const Spacer(),
              FilledButton(
                  onPressed: () {
                    context.pop();
                    context.goNamed(Routes.premiumPackageSelection);
                  },
                  style: FilledButton.styleFrom(
                    //backgroundColor: context.colorScheme.primary,
                  ),
                  child: Text(context.language.upgradeNow,)),
              40.gapH,
            ],
          ),
        ),
      ),
    );
  }
}
