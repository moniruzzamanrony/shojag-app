/*
* ui: forgot password input page
*/

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/validator/field_validators.dart';
import 'package:app/feature/auth/presentation/provider/forgot_password_provider.dart';
import 'package:app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:app/feature/auth/presentation/widget/forgot_pass_back_button_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../widget/drop_animated_logo_widget.dart';
import '../../widget/forgot_pass_error_text_widget.dart';

class ForgotPasswordInputPage extends StatefulWidget {
  const ForgotPasswordInputPage({super.key});

  @override
  State<ForgotPasswordInputPage> createState() =>
      _ForgotPasswordInputPageState();
}

class _ForgotPasswordInputPageState extends State<ForgotPasswordInputPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailOrPhoneController;
  late final FocusNode emailFocusNode;

  @override
  void initState() {
    super.initState();
    emailOrPhoneController = TextEditingController();
    emailFocusNode = FocusNode();
    context.read<ForgotPasswordProvider>().setErrorMessage('', refresh: false);
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      bottomPadding: 350.h,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const ForgotPassBackButtonWidget(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DropAnimatedLogoWidget(height: 220.h, logoSize: 120.h),
              40.gapH,
              Padding(
                padding: Styles.horizontalPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        child: Text(
                          context.language.forgot_password,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.sp,
                              height: 1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorAppGreenDark),
                        ),
                      ),
                      20.gapH,
                      Align(
                        child: Text(
                          context.language.resetYourAccountPasswordAndAccess,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                              color: AppColors.colorAppGrey),
                        ),
                      ),
                      30.gapH,
                      AuthTextField(
                        controller: emailOrPhoneController,
                        focusNode: emailFocusNode,
                        validator: FieldValidators(context).phoneValidator,
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(
                          Icons.phone,
                          color: AppColors.colorAppGrey,
                          size: Dimens.iconSize16,
                        ),
                        hintText: context.language.phone,
                      ),
                      30.gapH,
                      LoadingAnimatedButton(
                        height: 48.h,
                        width: 1.sw,
                        text: context.language.sendCode,
                        btnColor: ColoredButtonType.red,
                        onTap: (startLoading, stopLoading, btnState) {
                          _sendCode(context,
                              startLoading: startLoading,
                              stopLoading: stopLoading);
                        },
                      ),
                      16.gapH,
                      const ForgotPassErrorTextWidget(),
                      16.gapH,
                    ],
                  ),
                ),
              ),
              //130.gapH,
            ],
          ),
        ),
      ),
    );
  }

  // send otp code to user
  void _sendCode(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    final forgotPassProvider = ctx.read<ForgotPasswordProvider>();
    forgotPassProvider.setErrorMessage('');

    FocusScope.of(ctx).unfocus();
    final isFormValid = _formKey.currentState?.validate();

    if (isFormValid == true) {
      final emailOrPhone = emailOrPhoneController.text.trim();

      startLoading();
      final userId = await forgotPassProvider
          .sendOtpCode(emailOrPhone: emailOrPhone)
          .onError(
        (error, stackTrace) {
          if (ctx.mounted) {
            forgotPassProvider.setErrorMessage(error.toString());
          }
          return null;
        },
      ).whenComplete(
        () {
          stopLoading();
        },
      );

      if (userId == null) {
        return;
      }

      if (ctx.mounted) {
        forgotPassProvider.emailOrPhone = emailOrPhone;
        forgotPassProvider.userId = userId;
        ctx.pushNamed(Routes.otpVerify);
      }
    }
  }
}
