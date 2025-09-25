import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/shared/presentation/widget/powered_by_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/config/theme/app_colors.dart';

/// [AuthBackground] : background design for auth ui
class AuthBackground extends StatelessWidget {
  final Widget child;
  final double? bottomPadding;

  const AuthBackground({super.key, required this.child, this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
              bottom: bottomPadding ?? 0.0,
              child: const DecoratedBox(
                  decoration:
                      BoxDecoration(gradient: AppColors.kGradiantOnboarding))),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                height: 80.h,
                fit: BoxFit.fill,
                Assets.backgroundOnBoardBottomCurve,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: PoweredByWidget(
                textColor: AppColors.colorAppGrey,
                imgColor: AppColors.colorPrimary),
          ),
          child,
        ],
      ),
    );
  }
}

/// [RegistrationBackground] : background design for registration ui
class RegistrationBackground extends StatelessWidget {
  final Widget child;

  const RegistrationBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: Stack(
        children: [
          Positioned(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.kColorGradiant1),
            child: SafeArea(
              child: SvgPicture.asset(
                height: 136.h,
                Assets.backgroundRegTopCurve,
                fit: BoxFit.fill,
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                height: 80.h,
                fit: BoxFit.fill,
                Assets.backgroundOnBoardBottomCurve,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: PoweredByWidget(
                textColor: AppColors.colorAppGrey,
                imgColor: AppColors.colorPrimary),
          ),
          child,
        ],
      ),
    );
  }
}

class NavBackground extends StatelessWidget {
  final Widget child;

  const NavBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          const Positioned.fill(
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: AppColors.kNavBarBackground))),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                height: 100.h,
                fit: BoxFit.fill,
                Assets.backgroundOnBoardBottomCurve,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: PoweredByWidget(
                textColor: AppColors.colorAppGrey,
                imgColor: AppColors.colorPrimary),
          ),
          child,
        ],
      ),
    );
  }
}

/// [HomeBackground] : background design for home ui
class HomeBackground extends StatelessWidget {
  final Widget child;
  final bool hasBottomCurve;
  final bool hasPoweredBy;

  const HomeBackground(
      {super.key,
      required this.child,
      this.hasBottomCurve = false,
      this.hasPoweredBy = false});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: Stack(
        children: [
          Positioned(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffdbfff5)),
            child: SafeArea(
              child: SvgPicture.asset(
                height: 120.h,
                Assets.backgroundHomeTopCurve,
                fit: BoxFit.fill,
              ),
            ),
          )),
          if (hasBottomCurve)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  height: 80.h,
                  fit: BoxFit.fill,
                  Assets.backgroundOnBoardBottomCurve,
                ),
              ),
            ),
          if (hasPoweredBy)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: PoweredByWidget(
                  textColor: AppColors.colorAppGrey,
                  imgColor: AppColors.colorPrimary),
            ),
          child,
        ],
      ),
    );
  }
}

/// [CurvedBottomBackground] : background design for
/// custom ui throughout the app
class CurvedBottomBackground extends StatelessWidget {
  final Widget child;
  final bool hasBackground;
  final double? backgroundHeight;
  final Color? backgroundColor;

  const CurvedBottomBackground(
      {super.key,
      required this.child,
      this.hasBackground = true,
      this.backgroundColor,
      this.backgroundHeight});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        hasBackground ? AppColors.colorWhite : AppColors.colorAppTransparent;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: Styles.curvedTopBorderRadius,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                height: backgroundHeight ?? 100.h,
                fit: BoxFit.fill,
                Assets.backgroundOnBoardBottomCurve,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// [CurvedTopRadiusToChild] : background design for
class CurvedTopRadiusToChild extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const CurvedTopRadiusToChild(
      {super.key, required this.child, this.backgroundColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: padding,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.colorWhite,
          borderRadius: Styles.curvedTopBorderRadius,
        ),
        child: child);
  }
}
