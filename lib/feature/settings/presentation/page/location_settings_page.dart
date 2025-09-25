import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/consent/presentation/widget/consent_checker.dart';
import 'package:app/shared/presentation/provider/location_provider.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/helper/background_location_helper.dart';
import '../../../../core/utils/helper/work_manager_helper.dart';
import '../../../../core/utils/style/style.dart';

/// UI: Location settings
/// This page is responsible for displaying the location settings page.
class LocationSettingsPage extends StatelessWidget {
  const LocationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColorPaleMint,
      body: Column(
        children: [
          CustomAppBar(title: context.language.locationSettings),
          Expanded(
            child: Padding(
              padding: Styles.horizontalPadding,
              child: Column(
                children: [
                  _buildCard(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Selector<LocationProvider, bool>(
      selector: (_, provider) => provider.hasBackgroundLocationPermission,
      builder: (_, enabled, __) {
        final mainColor = AppColors.colorBlack;
        final buttonColor = enabled
            ? context.colorScheme.secondary
            : context.colorScheme.primary;
        final buttonBackgroundColor = buttonColor.shade(240);

        return Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(6.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.locationArrow,
                size: Dimens.iconSize32,
                color: mainColor,
              ),
              4.gapH,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${context.language.backgroundLocation} : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Dimens.fontSize14, color: mainColor),
                  ),
                  Text(enabled ? context.language.on : context.language.off,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Dimens.fontSize14,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
              4.gapH,
              Text(
                context.language.accessToYourLocationWhenTheAppIsInBackground,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mainColor.shade(150), fontSize: Dimens.fontSize12),
              ),
              8.gapH,
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: buttonColor,
                      textStyle: TextStyle(fontSize: Dimens.fontSize14)),
                  onPressed: () => _changeSettings(context, !enabled),
                  child: Text(enabled
                      ? context.language.turnOff
                      : context.language.turnOn))
            ],
          ),
        );
      },
    );
  }

  /// [_changeSettings] for toggle background location settings
  ///
  /// if [isOn == true] then  check consent first then request permission for always permission, then
  /// request permission for background permission
  /// update work manager for background permission
  /// enable background locator service
  ///
  /// else if [isOn == false] then disable background locator service
  /// update work manager
  /// disable background locator service
  void _changeSettings(BuildContext context, bool isOn) async {
    final locationProvider = context.location;

    if (isOn) {
      final hasConsent = await consentChecker(context);
      if (!hasConsent) return;
      if (!context.mounted) return;

      final hasAlwaysPermission = await alwaysPermissionChecker(context);
      if (!hasAlwaysPermission) return;
    }

    await togglePeriodicUpdateLocationWorker(isOn);
    await toggleBackgroundTracking(isOn);

    await locationProvider.updateBackgroundLocationPermission(permission: isOn);
  }
}
