import 'package:app/core/notification/firebase_notification_manager.dart';
import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/helper/datetime_helper.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/core/utils/helper/location_helper.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/router/routes.dart';
import '../../../../../shared/presentation/provider/session_provider.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../provider/registration_provider.dart';

class RegButtonWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController policeIdController;
  final TextEditingController organizationController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;

  const RegButtonWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.policeIdController,
    required this.organizationController,
    required this.phoneController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    // final bool enable = context.read<RegistrationProvider>().selectedUserType ==
    //     UserType.citizen; //TODO: disable for only community
    final enable = true;
    final buttonText =
        enable ? context.language.register : context.language.comingSoon;

    return LoadingAnimatedButton(
      height: 48.h,
      width: 1.sw,
      text: buttonText,
      btnColor: ColoredButtonType.red,
      onTap: enable
          ? (startLoading, stopLoading, btnState) {
              _register(context,
                  startLoading: startLoading, stopLoading: stopLoading);
            }
          : null,
    );
  }

  void _register(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    hideAppKeyboard(ctx);
    final registrationProvider = ctx.read<RegistrationProvider>();
    registrationProvider.setErrorMessage('');

    final selectedUserType = registrationProvider.selectedUserType;

    final isFormValid = formKey.currentState?.validate();
    if (isFormValid == true) {
      final sessionProvider = ctx.read<SessionProvider>();
      final premiumProvider = ctx.read<PremiumProvider>();
      final settingsProvider = ctx.read<SettingsProvider>();
      if (!registrationProvider.isPhoneVerified) {
        registrationProvider
            .setErrorMessage('Please verify your phone number first');
        return;
      }
      final tempId = registrationProvider.tempId;
      if (tempId == null) {
        return;
      }
      final tempToken = registrationProvider.tempToken;
      if (tempToken == null) {
        return;
      }

      final selectedType = registrationProvider.selectedUserType;
      if (selectedType == null) {
        registrationProvider
            .setErrorMessage('Select a user type, what you are');
        return;
      }

      final selectedGender = registrationProvider.selectGender;
      if (selectedUserType == UserType.citizen && selectedGender == null) {
        registrationProvider.setErrorMessage('Select your gender');
        return;
      }

      final selectedThana = registrationProvider.selectedThana;
      if (selectedUserType == UserType.police && selectedThana == null) {
        registrationProvider.setErrorMessage('Select your thana');
        return;
      }

      final isTermsAndConditionAccepted =
          registrationProvider.acceptTermsAndCondition;
      if (!isTermsAndConditionAccepted) {
        registrationProvider
            .setErrorMessage('Please accept the terms and conditions');
        return;
      }

      final location = await LocationHelper.getLastKnownLocation().onError(
        (error, stackTrace) {
          registrationProvider.setErrorMessage(error.toString());
          return null;
        },
      );
      final longitude = location?.latitude ?? AppConstants.dhakaLatLng.latitude;
      final latitude =
          location?.longitude ?? AppConstants.dhakaLatLng.longitude;
      final deviceToken =
          await FirebaseNotificationManager.instance.getToken() ?? '';

      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final email = emailController.text;
      final phone = phoneController.text;
      final policeId = policeIdController.text;
      final organization = organizationController.text;
      final password = passwordController.text;

      startLoading();
      final user = await registrationProvider
          .register(
              firstName: firstName,
              lastName: lastName,
              email: email,
              typeId: selectedType.id,
              thanaId: selectedThana?.id ?? 0,
              longitude: latitude,
              latitude: longitude,
              deviceToken: deviceToken,
              gender: selectedGender?.titleEn,
              policeId: policeId,
              organization: organization,
              phone: phone,
              password: password,
              tempToken: tempToken,
              tempId: tempId)
          .onError(
        (error, stackTrace) {
          registrationProvider.setErrorMessage(error.toString());

          return null;
        },
      ).whenComplete(
        () {
          stopLoading();
        },
      );

      if (user == null) {
        return;
      }

      await sessionProvider.saveSessionInfo(
          loginStatus: true,
          userId: user.userId,
          apiToken: user.apiToken ?? '',
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone ?? '',
          isEmailVerified: user.isEmailVerified,
          email: user.email,
          address: user.address,
          dob: user.dob?.formatDate(pattern: pattern_YYYYMMdd),
          gender: user.gender?.titleEn,
          isPhoneVerified: user.isPhoneVerified,
          hospitalOrAgency: user.hospitalOrAgency,
          policeId: user.policeId,
          // thana: user.thana,
          fireStation: user.fireStation,
          userType: user.userType.id,
          nid: user.nid,
          photo: user.photo);

      //save premium user info
      await premiumProvider.savePremiumInfo(
          isPremium: user.premiumInfo.isPremium,
          expireDate: user.premiumInfo.expireDate,
          currentPackage: user.premiumInfo.currentPackage);

      // save area limit preference for the user
      if (user.areaLimit != null) {
        await settingsProvider.saveRadius(user.areaLimit! * 1000);
      }

      await sessionProvider.saveRememberAuthInfo(phoneOrEmail: phone);
      if (ctx.mounted) {
        ctx.goNamed(Routes.dashboard);
      }
    }
  }
}
