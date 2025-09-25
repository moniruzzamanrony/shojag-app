/*
* ui: getting started page
*/

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/auth/presentation/widget/drop_animated_logo_widget.dart';
import 'package:app/feature/auth/presentation/widget/language_switch_button.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/helper/permission_helper.dart';
import '../widget/auth_button_widget.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 40.h,
              left: 0,
              right: 0,
              child: DropAnimatedLogoWidget(height: 330.h, logoSize: 150.r),
            ),
            Positioned(
                top: 300.h, left: 0, right: 0, child: _buildAppText(context)),
            Positioned(
                top: 56.h, right: 24.w, child: const LanguageSwitchButton()),
            Positioned(
              left: 0,
              right: 0,
              bottom: 80.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.w),
                child: AuthButtonWidget(
                  buttonText: context.language.get_started,
                  textStyle: TextStyle(
                      fontFamily: context.isBangla
                          ? GoogleFonts.baloo2().fontFamily
                          : null,
                      height: 1.0),
                  onPressed: () => _getStarted(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 0.5.sw,
            height: 50.h,
            child: SvgPicture.asset(
              context.isBangla
                  ? Assets.shojagPoweredByLogoBnSvg
                  : Assets.shojagPoweredByLogoEnSvg,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          8.gapH,
          Text(
            context.language.togetherWeConnectTogetherWeProtect,
            style: TextStyle(
                fontFamily:
                    context.isBangla ? GoogleFonts.baloo2().fontFamily : null,
                fontSize: context.isBangla ? 20.sp : 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.colorWhite),
            textAlign: TextAlign.center,
          ).animate(effects: [
            const SlideEffect(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 700),
                begin: Offset(0, -0.5),
                end: Offset(0, 0)),
            const FadeEffect(
              duration: Duration(milliseconds: 700),
            ),
          ])
        ],
      ),
    );
  }

  void _getStarted(BuildContext context) async {
    final provider = context.location;
    final isUserLocationConsent = provider.locationConsent;

    final hasPermission = await PermissionHelper.hasLocationPermission;
    if (!context.mounted) {
      return;
    }

    // if has location permitted and user consent
    // navigate to login
    if (hasPermission && isUserLocationConsent) {
      context.goNamed(Routes.login);
    }
    // else if has location not permitted or user not consent
    else {
      context.pushNamed(Routes.locationServiceUsageConsent).then((value) {
        // wait for the response by user [value]
        if (value == true && context.mounted) {
          context.goNamed(Routes.login);
        }
      });
    }
  }
}
