import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/shared/presentation/widget/error_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../shared/presentation/widget/countdown_timer_clock.dart';
import '../provider/registration_provider.dart';

class OtpDialog extends StatefulWidget {
  final String phoneNumber;
  final int tempId;

  const OtpDialog({super.key, required this.phoneNumber, required this.tempId});

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  bool isOtpLengthValid = false;

  bool resendOtpButtonVisibility = false;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
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

    return Dialog(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.language.verification,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
            ),
            20.gapH,
            Text(
              context.language.enterTheOtpSentToTheNumber,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AppColors.colorAppGrey),
            ),
            8.gapH,
            Text(
              widget.phoneNumber,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            8.gapH,
            Selector<RegistrationProvider, bool>(
              builder: (_, value, __) {
                if (value) {
                  return const CircularProgressIndicator();
                }

                if (!resendOtpButtonVisibility) {
                  return CountdownTimerClock(
                    timeInSeconds: 120,
                    onFinished: () {
                      setState(() {
                        resendOtpButtonVisibility = true;
                      });
                    },
                  );
                } else {
                  return TextButton(
                      onPressed: () {
                        _resendOtp(context);
                      },
                      child: Text(context.language.resendOtp));
                }
              },
              selector: (_, provider) => provider.isPhoneVerifying,
            ),
            20.gapH,
            Pinput(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              defaultPinTheme: defaultPinTheme,
              onChanged: (value) {
                final tempValid = controller.text.length == 4;
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
                controller.setText(value);
              },
            ),
            16.gapH,
            ErrorTextWidget(errorText: _errorText),
            16.gapH,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(context.language.cancel)),
                16.gapW,
                FilledButton(
                    onPressed: isOtpLengthValid
                        ? () {
                            _verify(context,
                                tempId: widget.tempId, otp: controller.text);
                          }
                        : null,
                    child: Selector<RegistrationProvider, bool>(
                        selector: (_, provider) => provider.isOtpVerifying,
                        builder: (_, value, __) => AnimatedSize(
                              duration: const Duration(milliseconds: 350),
                              child: value
                                  ? SizedBox(
                                      height: 16.r,
                                      width: 16.r,
                                      child: CircularProgressIndicator(
                                        color: context.colorScheme.onPrimary,
                                      ),
                                    )
                                  : Text(context.language.verify),
                            ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context,
      {required int tempId, required String otp}) async {
    final registrationProvider = context.read<RegistrationProvider>();
    setState(() {
      _errorText = null;
    });

    final entity =
        await registrationProvider.verifyOtp(otp: otp, tempId: tempId).onError(
      (error, stackTrace) {
        setState(() {
          _errorText = error?.toString();
        });
        return null;
      },
    );
    if (entity == null) {
      return;
    }

    if (entity.id > 0) {
      if (!context.mounted) {
        return;
      }
      context.read<RegistrationProvider>().isPhoneVerified = true;
      context.read<RegistrationProvider>().tempId = entity.id;
      context.read<RegistrationProvider>().tempToken = entity.token;
      context.pop();
      showAppSnackBar(
        context,
        '${widget.phoneNumber} is verified',
        type: MessageType.normal,
      );
    }
  }

  void _resendOtp(BuildContext context) async {
    final registrationProvider = context.read<RegistrationProvider>();
    await registrationProvider.verifyPhone(widget.phoneNumber).onError(
      (error, stackTrace) {
        if (context.mounted) {
          showAppSnackBar(context, error?.toString(), type: MessageType.error);
        }
        return -1;
      },
    );
  }
}
