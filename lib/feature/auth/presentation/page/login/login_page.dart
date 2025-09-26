/*
* ui: login page
*/

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/core/utils/validator/field_validators.dart';
import 'package:app/feature/auth/presentation/provider/login_provider.dart';
import 'package:app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:app/feature/auth/presentation/widget/drop_animated_logo_widget.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/helper/datetime_helper.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/provider/session_provider.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import 'login_error_text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      bottomPadding: 350.h,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Column(
              children: [
                40.gapH,
                DropAnimatedLogoWidget(height: 220.h, logoSize: 120.h),
                const Spacer(),
                const _LoginForm(),
                20.gapH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.language.notAMember,
                      style: TextStyle(
                          color: AppColors.colorAppGrey, fontSize: 14.sp),
                    ),
                    4.gapW,
                    InkWell(
                      onTap: () {
                        hideAppKeyboard(context);
                        context.pushNamed(Routes.registration);
                      },
                      child: Text(
                        context.language.joinNow,
                        style: TextStyle(
                            color: context.colorScheme.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
                100.gapH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailOrPhoneController;
  late final TextEditingController passwordController;
  late final FocusNode emailOrPhoneFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailOrPhoneController = TextEditingController();
    passwordController = TextEditingController();
    emailOrPhoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    final savedEmailOrPhone =
        context.read<SessionProvider>().getRememberAuthInfo();
    emailOrPhoneController.text = savedEmailOrPhone ?? '';
  }

  @override
  void dispose() {
    emailOrPhoneFocusNode.dispose();
    passwordFocusNode.dispose();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //user login action
  void _login(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    hideAppKeyboard(context);
    final loginProvider = ctx.read<LoginProvider>();
    loginProvider.setErrorMessage('');

    final isFormValid = _formKey.currentState?.validate();

    if (isFormValid == true) {
      final settingsProvider = ctx.read<SettingsProvider>();
      final sessionProvider = ctx.read<SessionProvider>();
      final premiumProvider = ctx.read<PremiumProvider>();
      final emailOrPhone = emailOrPhoneController.text.trim();
      final password = passwordController.text.trim();

      startLoading();
      final user = await loginProvider
          .login(email: emailOrPhone, password: password)
          .onError(
        (error, stackTrace) {
          loginProvider.setErrorMessage(error.toString());
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

      //save user info to session on successful login
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

      //save user phone/email for next time autofill
      await sessionProvider.saveRememberAuthInfo(phoneOrEmail: emailOrPhone);
      if (ctx.mounted) {
        ctx.goNamed(Routes.dashboard);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.horizontalPadding,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.language.login,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorAppGreenDark),
                ),
              ),
              30.gapH,
              AuthTextField(
                controller: emailOrPhoneController,
                focusNode: emailOrPhoneFocusNode,
                validator: FieldValidators(context).phoneValidator,
                suffixIcon: Icon(
                  Icons.phone,
                  color: AppColors.colorAppGrey,
                  size: Dimens.iconSize16,
                ),
                hintText: context.language.phone,
                keyboardType: TextInputType.number,
              ),
              20.gapH,
              Selector<LoginProvider, bool>(
                selector: (_, provider) => provider.passwordObscureText,
                builder: (_, value, __) => AuthTextField(
                  obscureText: value,
                  validator: FieldValidators(context).passwordValidator,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      context.read<LoginProvider>().togglePasswordObscure();
                    },
                    child: Icon(
                      value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.colorAppGrey,
                      size: Dimens.iconSize16,
                    ),
                  ),
                  hintText: context.language.password,
                ),
              ),
              20.gapH,
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    hideAppKeyboard(context);
                    context.pushNamed(Routes.forgotPassword);
                  },
                  child: Text(
                    context.language.forgot_password,
                    style: TextStyle(
                        color: AppColors.colorAppRed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              32.gapH,
              LoadingAnimatedButton(
                height: 48.h,
                width: 1.sw,
                text: context.language.login,
                btnColor: ColoredButtonType.red,
                onTap: (startLoading, stopLoading, btnState) {
                  _login(context,
                      startLoading: startLoading, stopLoading: stopLoading);
                  //context.goNamed(Routes.dashboard);
                },
              ),
              16.gapH,
              const LoginErrorTextWidget(),
            ],
          ),
        )
      ]),
    );
  }
}
