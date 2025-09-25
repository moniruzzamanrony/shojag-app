import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/style/style.dart';

final nameStyle = TextStyle(
    fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.colorBlack);

final phoneStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.colorAppGrey);

final timeLimitStyle = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.colorAppGrey);

ButtonStyle fnfButtonStyle(BuildContext context) => FilledButton.styleFrom(
  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
  visualDensity: Styles.minimumVisualDensity,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  textStyle: context.textTheme.bodyMedium?.copyWith(
    color: AppColors.colorWhite,
    //fontSize: Dimens.fontSize12,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
  foregroundColor: AppColors.colorWhite,
);

final listPrimaryButtonStyle = FilledButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
    visualDensity: Styles.minimumVisualDensity,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    foregroundColor: AppColors.colorWhite,
    backgroundColor: AppColors.colorAppGreen);

final listSecondaryButtonStyle = FilledButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
    visualDensity: Styles.minimumVisualDensity,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    foregroundColor: AppColors.colorWhite,
    backgroundColor: AppColors.colorGrey);

final listVerticalPadding = EdgeInsets.symmetric(vertical: 8.h);
final gapBetweenTitles = 4.0.gapR;
final gapBetweenButtons = 8.0.gapR;
final gapBetweenTitleAndButtons = 8.0.gapR;

final listPopupButtonHeight = 32.h;
final listPopupButtonWidth = 80.w;
final listPopupButtonMinWidth = 10.w;
