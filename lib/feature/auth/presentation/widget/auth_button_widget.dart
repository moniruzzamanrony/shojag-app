import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/assets.dart';

class AuthButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double? buttonHeight;
  final TextStyle? textStyle;

  const AuthButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonHeight,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);
    final enabled = onPressed != null;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          fixedSize: Size.fromHeight(buttonHeight ?? 48.h),
          textStyle: textStyle,
          shape: RoundedRectangleBorder(borderRadius: borderRadius)),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                Assets.backgroundButtonBackgroundRed,
                colorFilter: enabled
                    ? null
                    : const ColorFilter.mode(
                        AppColors.colorGreyLight, BlendMode.color),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    fontSize: 16.sp,
                    height: 1,
                    color: Colors.white.shade(50, darker: !enabled),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
