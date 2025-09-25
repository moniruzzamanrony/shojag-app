/* UI: Settings page
* handle settings for the app
* */

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/enums/language.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:app/feature/settings/presentation/widget/delete_account_popup.dart';
import 'package:app/shared/domain/entity/language_entity.dart';
import 'package:app/shared/presentation/provider/session_provider.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/notification/firebase_notification_manager.dart';
import '../../../../core/utils/constants/dimens.dart';
import '../../../../core/utils/style/style.dart';
import '../../../dashboard/presentation/provider/dashboard_provider.dart';

/// UI: Settings page
/// This page is responsible for displaying the settings page.
/// It contains the following sections:
/// 1. Notification settings
/// 2. Radius settings
/// 3. Language settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffoldBackgroundColorPaleMint,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.language.settings),
            Expanded(
              child: Padding(
                padding: Styles.horizontalPadding,
                child: Column(
                  children: [
                    _notificationSettingsSection(context),
                    _itemGap,
                    _radiusSection(context),
                    _itemGap,

                    _languageSection(context),
                    _itemGap,

                    _locationSettingsSection(context),
                    _itemGap,

                    _changePasswordSection(context),
                    const Spacer(),

                    // delete account button
                    TextButton(
                      onPressed: () {
                        showAppDialog(context, dialogWidget: const DeleteAccountPopup());
                      },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimens.fontSize14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        foregroundColor: AppColors.colorAppRed,
                      ),
                      child: Text(context.language.deleteYourAccount),
                    ),
                    24.gapH,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _leadingIcon(IconData icon) {
    return Icon(icon, color: Colors.grey.shade400, size: Dimens.iconSize16);
  }

  TextStyle get _titleTextStyle => TextStyle(color: Colors.black, fontSize: 14.sp);

  TextStyle get _subtitleTextStyle => TextStyle(color: Colors.grey.shade400, fontSize: 12.sp);

  ShapeBorder get _tileShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r));

  // update password button
  ListTile _changePasswordSection(BuildContext context) {
    return ListTile(
      onTap: () {
        context.goNamed(Routes.changePassword);
      },
      shape: _tileShape,
      title: Text(context.language.changePassword, style: _titleTextStyle),
      subtitle: Text(context.language.changeYourAccountPassword, style: _subtitleTextStyle),
      trailing: const Icon(Icons.keyboard_arrow_right),
      leading: _leadingIcon(Icons.lock),
      tileColor: Styles.tileColorGrey,
    );
  }

  // location settings button
  ListTile _locationSettingsSection(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.locationSettings);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      title: Text(context.language.locationSettings, style: _titleTextStyle),
      subtitle: Text(context.language.updatePermissionAndService, style: _subtitleTextStyle),
      trailing: const Icon(Icons.keyboard_arrow_right),
      leading: _leadingIcon(Icons.location_on),
      tileColor: Styles.tileColorGrey,
    );
  }

  // language change section tile
  Selector<SettingsProvider, LanguageEntity> _languageSection(BuildContext context) {
    return Selector<SettingsProvider, LanguageEntity>(
      selector: (_, provider) => provider.language,
      builder: (_, language, __) => ListTile(
        shape: _tileShape,
        title: Text(context.language.language, style: _titleTextStyle),
        subtitle: Text(context.language.selectAppLanguage, style: _subtitleTextStyle),
        trailing: PopupMenuButton<Language>(
          onSelected: (value) {
            Provider.of<SettingsProvider>(context, listen: false).saveLanguage(value.shortName);
          },
          offset: const Offset(20, 48),
          itemBuilder: (context) {
            final languageList = Language.values;
            return List.generate(
              languageList.length,
              (index) =>
                  PopupMenuItem<Language>(value: languageList[index], child: Text(languageList[index].nativeName)),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                language.name == Language.en.shortName ? Language.en.nativeName : Language.bn.nativeName,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        leading: _leadingIcon(Icons.translate),
        tileColor: Styles.tileColorGrey,
      ),
    );
  }

  // select  are radius for the app notification and list
  Selector<SettingsProvider, num> _radiusSection(BuildContext context) {
    return Selector<SettingsProvider, num>(
      selector: (_, provider) => provider.radiusInMeter,
      builder: (_, radius, __) => ListTile(
        shape: _tileShape,
        title: Text(context.language.radius, style: _titleTextStyle),
        subtitle: Text(context.language.selectYourAreaRadius, style: _subtitleTextStyle),
        trailing: Selector<SettingsProvider, bool>(
          selector: (_, provider) => provider.isRadiusUpdating,
          builder: (_, value, __) => AnimatedCrossFade(
            alignment: Alignment.center,
            layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) =>
                Stack(alignment: Alignment.center, children: [topChild, bottomChild]),
            duration: const Duration(milliseconds: 100),
            crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: SizedBox(
              height: 32.r,
              width: 32.r,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            secondChild: PopupMenuButton(
              onSelected: (value) {
                _updateAreaLimit(context, value);
              },
              offset: const Offset(20, 48),
              itemBuilder: (context) {
                return List.generate(
                  AppConstants.maxAreaRadius ~/ 1000,
                  (index) => PopupMenuItem<int>(
                    value: index + 1,
                    child: ListTile(
                      leading: Icon(Icons.location_on_outlined, color: Colors.grey, size: 14.sp),
                      title: Text(context.language.toKMConverter('km', index + 1)),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.language.toKMConverter('km', (radius ~/ 1000)),
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
        leading: _leadingIcon(Icons.map_sharp),
        tileColor: Styles.tileColorGrey,
      ),
    );
  }

  // notification on / off for the app
  Selector<SettingsProvider, bool> _notificationSettingsSection(BuildContext context) {
    return Selector<SettingsProvider, bool>(
      selector: (_, provider) => provider.isNotificationOn,
      builder: (_, isNotificationOn, __) => SwitchListTile(
        shape: _tileShape,
        title: Text(context.language.notification, style: _titleTextStyle),
        subtitle: Text(context.language.turnOnToGetNotifications, style: _subtitleTextStyle),
        secondary: _leadingIcon(Icons.notifications),
        tileColor: Styles.tileColorGrey,
        value: isNotificationOn,
        onChanged: (isOn) async {
          await context.read<SettingsProvider>().toggleNotification();
          if (!context.mounted) {
            return;
          }

          if (isOn) {
            final deviceToken = await FirebaseNotificationManager.instance.getToken();
            if (deviceToken != null && context.mounted) {
              context.read<DashboardProvider>().updateDeviceToken(
                context.userId,
                context.apiToken,
                deviceToken: deviceToken,
              );
            }
          } else {
            context.read<SessionProvider>().deleteNotificationToken();
          }
        },
      ),
    );
  }

  Gap get _itemGap => 16.gapH;

  // update area limit in remote
  void _updateAreaLimit(BuildContext context, int value) async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final isUpdatedInRemote = await settingsProvider.updateAreaLimit(
      token: context.apiToken,
      userId: context.userId,
      areaLimit: value,
    );
    if (isUpdatedInRemote) {
      await settingsProvider.saveRadius(value * 1000);
    }
  }
}
