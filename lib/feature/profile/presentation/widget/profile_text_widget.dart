import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String title;
  const ProfileHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          height: 1,
          color: AppColors.colorAppGrey),
    );
  }
}


class ProfileContentWidget extends StatelessWidget {
  final String text;
  const ProfileContentWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.colorAppGreenDark,
          height: 1),
    );
  }
}

Widget headerContentSeparator() => 4.gapH;

Widget itemSeparator() => 16.gapH;

