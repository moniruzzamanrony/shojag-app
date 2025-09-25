import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/theme/app_colors.dart';

/// [ColoredBackgroundButton] : button design for auth ui
class ColoredBackgroundButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Widget? customChild;

  final ColoredButtonType buttonColor;

  const ColoredBackgroundButton(
      {super.key,
      required this.onPressed,
      this.text,
      required this.buttonColor,
      this.customChild})
      : assert(customChild != null || text != null,
            'Either text or customChild should be provided');

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);
    String background;
    switch (buttonColor) {
      case ColoredButtonType.red:
        background = Assets.backgroundButtonBackgroundRed;
        break;
      case ColoredButtonType.green:
        background = Assets.backgroundButtonBackgroundGreen;
        break;
    }

    final enabled = onPressed != null;

    return MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: EdgeInsets.zero,
        child: Ink(
          child: SizedBox(
            height: 48.h,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(
                      background,
                      fit: BoxFit.fill,
                      colorFilter: enabled
                          ? null
                          :  const ColorFilter.mode(
                              AppColors.colorGreyLight, BlendMode.color),
                    ),
                  ),
                  if (text != null)
                    Center(
                      child: Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp,
                            height: 1,
                            color: Colors.white.shade(50, darker: !enabled),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (customChild != null) Center(child: customChild!)
                ],
              ), //Text
            ),
          ),
        ));
  }
}

enum ColoredButtonType {
  red,
  green;
}
