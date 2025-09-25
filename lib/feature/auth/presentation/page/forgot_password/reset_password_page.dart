/*
* ui : reset password page
*/

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/validator/field_validators.dart';
import 'package:app/feature/auth/presentation/provider/forgot_password_provider.dart';
import 'package:app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../widget/drop_animated_logo_widget.dart';
import '../../widget/forgot_pass_back_button_widget.dart';
import '../../widget/forgot_pass_error_text_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
          padding: Styles.horizontalPadding,
          child: Column(children: [
            40.gapH,
            DropAnimatedLogoWidget(height: 220.h, logoSize: 120.h),
            40.gapH,
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    child: Text(
                      context.language.resetPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorAppGreenDark),
                    ),
                  ),
                  16.gapH,
                  Align(
                    child: Text(
                      context.language.setANewPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: AppColors.colorAppGrey),
                    ),
                  ),
                  30.gapH,
                  Selector<ForgotPasswordProvider, bool>(
                    selector: (_, provider) => provider.isObscureText,
                    builder: (_, value, __) => AuthTextField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: value,
                      validator: FieldValidators(context).passwordValidator,
                      suffixIcon: InkWell(
                        onTap: () {
                          context
                              .read<ForgotPasswordProvider>()
                              .toggleObscureText();
                        },
                        child: Icon(
                          value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.colorAppGrey,
                          size: Dimens.iconSize16,
                        ),
                      ),
                      hintText: context.language.newPassword,
                    ),
                  ),
                  16.gapH,
                  Selector<ForgotPasswordProvider, bool>(
                    selector: (_, provider) => provider.isObscureText,
                    builder: (_, value, __) => AuthTextField(
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      obscureText: value,
                      validator: (p0) {
                        return FieldValidators(context).repeatPasswordValidator(
                            p0,
                            anotherValue: passwordController.text);
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          context
                              .read<ForgotPasswordProvider>()
                              .toggleObscureText();
                        },
                        child: Icon(
                          value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.colorAppGrey,
                          size: Dimens.iconSize16,
                        ),
                      ),
                      hintText: context.language.confirmPassword,
                    ),
                  ),
                  40.gapH,
                  LoadingAnimatedButton(
                    height: 48.h,
                    width: 1.sw,
                    text: context.language.confirm,
                    btnColor: ColoredButtonType.red,
                    onTap: (startLoading, stopLoading, btnState) {
                      _confirmPassword(context,
                          startLoading: startLoading, stopLoading: stopLoading);
                    },
                  ),
                  16.gapH,
                  const ForgotPassErrorTextWidget(),
                  16.gapH,
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _confirmPassword(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    final forgotPassProvider = ctx.read<ForgotPasswordProvider>();
    forgotPassProvider.setErrorMessage('');
    FocusScope.of(ctx).unfocus();
    final isFormValid = _formKey.currentState?.validate();

    if (isFormValid == true) {
      final password = passwordController.text.trim();
      startLoading();

      final response = await forgotPassProvider
          .updatePassword(
              token: forgotPassProvider.userIdWithTokenViewModel!.token,
              password: password,
              userId: forgotPassProvider.userIdWithTokenViewModel!.userId)
          .onError(
        (error, stackTrace) {
          forgotPassProvider.setErrorMessage(error.toString());
          return false;
        },
      ).whenComplete(
        () {
          stopLoading();
        },
      );

      if (response == false) {
        return;
      }
      if (ctx.mounted) {
        await showAppDialog(ctx,
            barrierDismissible: false,
            dialogWidget: AlertDialog.adaptive(
              content: Text(
                'Password updated successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      ctx.pop();
                    },
                    child: const Text('Login Now'))
              ],
            ));
      }
      if (ctx.mounted) {
        ctx.goNamed(Routes.login);
      }
    }
  }
}
