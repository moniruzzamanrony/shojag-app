import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/constants/dimens.dart';

/// [ErrorTextWidget] : widget for error text
class ErrorTextWidget extends StatelessWidget {
  final String? errorText;
  final int? maxLines;

  const ErrorTextWidget({super.key, this.errorText, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return errorText == null
        ? const SizedBox.shrink()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.colorAppRed.shade(220),
                borderRadius: BorderRadius.circular(Dimens.borderRadius6)),
            child: Text(
              errorText!,
              maxLines: maxLines,
              style: TextStyle(
                  color: AppColors.colorAppRed,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          );
  }
}
