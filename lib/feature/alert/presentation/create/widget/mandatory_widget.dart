import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';

/// UI [MandatoryWidget] for mandatory widget
class MandatoryWidget extends StatelessWidget {
  const MandatoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            context.language.starRequired,
            style: TextStyle(
                fontSize: 10.sp, height: 1.2, color: AppColors.colorAppRed),
          ),
        ));
  }
}
