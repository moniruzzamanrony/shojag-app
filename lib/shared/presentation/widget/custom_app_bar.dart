import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'drop_lottie_anim.dart';

/// [CustomAppBar] : widget for custom app bar
class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Color? color;

  const CustomAppBar(
      {super.key, required this.title, this.leading, this.color});

  @override
  Widget build(BuildContext context) {
    final contentColor = color ?? Colors.black;
    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.horizontalSpace),
          child: Row(
            children: [
              if (leading != null)
                leading!
              else if (context.canPop())
                InkWell(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(right: 4.r, top: 4.r, bottom: 4.r),
                        child: Icon(
                          Icons.adaptive.arrow_back_rounded,
                          color: contentColor,
                          size: Dimens.iconSize20,
                        ))),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: contentColor),
                ),
              ),
              SizedBox(
                height: 50.r,
                width: 50.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const SimpleLottie(Assets.pulseCircleDropJson),
                    SvgPicture.asset(
                      Assets.shojagLogoSvg,
                      height: 36.r,
                      width: 36.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

