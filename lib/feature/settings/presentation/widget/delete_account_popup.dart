import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/constants/dimens.dart';
import '../../../../shared/presentation/provider/location_provider.dart';
import '../../../../shared/presentation/provider/session_provider.dart';
import '../../../../shared/presentation/provider/tooltip_provider.dart';
import '../../../premium/presentation/provider/premium_provider.dart';
import '../../../profile/presentation/provider/profile_provider.dart';

class DeleteAccountPopup extends StatefulWidget {
  const DeleteAccountPopup({super.key});

  @override
  State<DeleteAccountPopup> createState() => _DeleteAccountPopupState();
}

class _DeleteAccountPopupState extends State<DeleteAccountPopup> {
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> isObscure = ValueNotifier(true);
  ValueNotifier<bool> passwordIsNotEmpty = ValueNotifier(false);
  ValueNotifier<bool> isDeleting = ValueNotifier(false);
  ValueNotifier<String> errorMessage = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Dimens.padding20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.padding16, vertical: Dimens.padding24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32.r,
              backgroundColor: Colors.red.shade50,
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            16.gapH,
            Text(
              context.language.deleteAccount,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.gapH,
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: context.language.warning,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: ' '),
                TextSpan(
                  text: context.language.thisActionCannotBeUndone,
                )
              ]),
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
            8.gapH,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.language.allYourDataWillBeDeleted,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
            16.gapH,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.language.enterYourPasswordToProceed,
                style: TextStyle(
                    color: AppColors.colorAppGrey,
                    height: 1.0,
                    fontSize: 12.sp),
              ),
            ),
            6.gapH,
            _textField(context),
            8.gapH,
            _errorMessageSection(),
            8.gapH,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: context.pop,
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: Text(context.language.cancel)),
                16.gapW,
                ValueListenableBuilder<bool>(
                  valueListenable: isDeleting,
                  builder: (_, deleting, __) => IndexedStack(
                    index: deleting ? 1 : 0,
                    alignment: Alignment.center,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: passwordIsNotEmpty,
                        builder: (_, notEmpty, __) => FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed:
                                notEmpty ? () => _deleteAccount(context) : null,
                            child: Text(context.language.deletePermanently)),
                      ),
                      SizedBox(
                          height: 28.r,
                          width: 28.r,
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(BuildContext context) {
    final borderRadius = BorderRadius.circular(6.r);
    final border = OutlineInputBorder(borderRadius: borderRadius);
    final focusedBorder = OutlineInputBorder(borderRadius: borderRadius);
    return ValueListenableBuilder<bool>(
      valueListenable: isObscure,
      builder: (_, value, __) => TextFormField(
        obscureText: value,
        controller: passwordController,
        focusNode: passwordFocusNode,
        style: TextStyle(
          fontSize: 14.sp,
        ),
        onChanged: (data) {
          passwordIsNotEmpty.value = data.trim().isNotEmpty;
        },
        decoration: InputDecoration(
            isDense: true,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: GestureDetector(
              onTap: () {
                isObscure.value = !isObscure.value;
              },
              child: Icon(
                value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.colorAppGrey,
                size: Dimens.iconSize16,
              ),
            ),
            hintText: '******',
            border: border,
            focusedBorder: focusedBorder),
      ),
    );
  }

  void _deleteAccount(BuildContext context) async {
    final password = passwordController.text.trim();
    final settingsProvider = context.read<SettingsProvider>();
    final sessionProvider = context.read<SessionProvider>();
    final profileProvider = context.read<ProfileProvider>();
    final locationProvider = context.read<LocationProvider>();
    final premiumProvider = context.read<PremiumProvider>();
    final tooltipProvider = context.read<TooltipProvider>();

    final int userId = context.userId;
    final String token = context.apiToken;
    bool isDeleted = false;
    try {
      isDeleting.value = true;
      isDeleted = await settingsProvider
          .deleteAccount(token: token, userId: userId, password: password)
          .onError((error, stackTrace) {
        errorMessage.value = error.toString();
        return false;
      });
    } finally {
      isDeleting.value = false;
    }
    if (isDeleted) {
      try {
        sessionProvider.deleteNotificationToken();
      } catch (_) {}

      try {
        sessionProvider.clearRememberAuthInfo();
      } catch (_) {}

      try {
        locationProvider.clearLastLocation();
      } catch (_) {}

      try {
        premiumProvider.clearPremiumInfo();
      } catch (_) {}

      try {
        profileProvider.logoutRemote(token);
      } catch (_) {}

      try {
        tooltipProvider.clearTooltipViewDate();
      } catch (_) {}

      sessionProvider.clearSessionInfo().then(
        (value) {
          if (context.mounted) {
            context.goNamed(Routes.gettingStarted);
          }
        },
      );
    }
  }

  Widget _errorMessageSection() {
    return ValueListenableBuilder<String>(
      valueListenable: errorMessage,
      builder: (_, error, __) => error.isNotEmpty
          ? Align(
              alignment: Alignment.centerLeft,
              child: Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
