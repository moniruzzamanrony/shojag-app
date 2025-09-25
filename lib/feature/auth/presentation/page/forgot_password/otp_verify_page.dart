/*
* ui : otp verify page
*/

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/auth/presentation/provider/forgot_password_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/countdown_timer_clock.dart';
import '../../widget/drop_animated_logo_widget.dart';
import '../../widget/forgot_pass_back_button_widget.dart';
import '../../widget/forgot_pass_error_text_widget.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController otpController;
  late final FocusNode focusNode;

  bool isOtpLengthValid = false;

  bool resendOtpButtonVisibility = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    otpController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 64.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: context.colorScheme.primary,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

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
                      context.language.otpVerification,
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
                      context.language.pleaseEnter4DigitOtp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: AppColors.colorAppGrey),
                    ),
                  ),
                  8.gapH,
                  Align(
                    child: Text(
                      context.read<ForgotPasswordProvider>().emailOrPhone ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: AppColors.colorAppGreenDark),
                    ),
                  ),
                  8.gapH,
                  if (!resendOtpButtonVisibility)
                    CountdownTimerClock(
                      timeInSeconds: 120,
                      onFinished: () {
                        setState(() {
                          resendOtpButtonVisibility = true;
                        });
                      },
                    ),
                  24.gapH,
                  Pinput(
                    controller: otpController,
                    focusNode: focusNode,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    onChanged: (value) {
                      final tempValid = otpController.text.length == 4;
                      if (tempValid != isOtpLengthValid) {
                        setState(() {
                          isOtpLengthValid = tempValid;
                        });
                      }
                    },
                    separatorBuilder: (index) => const SizedBox(width: 16),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                            offset: Offset(0, 3),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                    onClipboardFound: (value) {
                      otpController.setText(value);
                    },
                  ),
                  40.gapH,
                  LoadingAnimatedButton(
                    height: 48.h,
                    width: 1.sw,
                    text: context.language.submit,
                    btnColor: ColoredButtonType.red,
                    onTap: (startLoading, stopLoading, btnState) {
                      _submitCode(context,
                          startLoading: startLoading, stopLoading: stopLoading);
                    },
                  ),
                  16.gapH,
                  const ForgotPassErrorTextWidget(),
                  16.gapH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.language.didNotReceivedCode,
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.colorAppGrey),
                      ),
                      Selector<ForgotPasswordProvider, bool>(
                        builder: (_, value, __) {
                          if (value) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SizedBox(
                                  height: 24.r,
                                  width: 24.r,
                                  child: const CircularProgressIndicator()),
                            );
                          }

                          return TextButton(
                              onPressed: resendOtpButtonVisibility
                                  ? () async {
                                      _resendOtp(context);
                                    }
                                  : null,
                              child: Text(context.language.resend));
                        },
                        selector: (_, provider) => provider.isOtpSending,
                      ),
                    ],
                  ),
                  20.gapH,
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // resend otp to user if time exceed;
  void _resendOtp(BuildContext ctx) async {
    final forgotPassProvider = ctx.read<ForgotPasswordProvider>();
    forgotPassProvider.setErrorMessage('');

    final userId = await forgotPassProvider
        .sendOtpCode(emailOrPhone: forgotPassProvider.emailOrPhone ?? '')
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          forgotPassProvider.setErrorMessage(error.toString());
        }
        return null;
      },
    );

    if (userId == null) {
      return;
    }
    if (!ctx.mounted) {
      return;
    }
    showAppSnackBar(ctx, 'A new OTP send to ${forgotPassProvider.emailOrPhone}',
        type: MessageType.normal);
    forgotPassProvider.userId = userId;
    setState(() {
      resendOtpButtonVisibility = false;
    });
  }

  // code verify
  void _submitCode(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    final forgotPassProvider = ctx.read<ForgotPasswordProvider>();
    forgotPassProvider.setErrorMessage('');

    FocusScope.of(ctx).unfocus();
    final isFormValid = _formKey.currentState?.validate();

    if (isFormValid == true) {
      final otp = otpController.text.trim();

      startLoading();
      final model = await forgotPassProvider
          .verifyOtp(
              otp: otp,
              userId: forgotPassProvider.userId ?? 0,
              phone: forgotPassProvider.emailOrPhone ?? '')
          .onError(
        (error, stackTrace) {
          forgotPassProvider.setErrorMessage(error.toString());
          return null;
        },
      ).whenComplete(
        () {
          stopLoading();
        },
      );

      if (model == null) {
        return;
      }

      if (ctx.mounted) {
        forgotPassProvider.userIdWithTokenViewModel = model;
        ctx.pushNamed(Routes.resetPassword);
      }
    }
  }
}
