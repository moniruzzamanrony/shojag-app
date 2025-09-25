import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/assets.dart';
import 'colored_background_button.dart';

/// [SuccessWidget] : widget for success dialog
/// It will show success dialog after successful operation
/// like creating alert or updating alert
class SuccessWidget extends StatelessWidget {
  final String subTitle;
  const SuccessWidget({super.key, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration:  const BoxDecoration(),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.successCheckPng,
                height: 80.h,
              ),
              16.gapH,
              Text(
                context.language.congratulationsWithQuotes,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: context.colorScheme.primary,
                    height: 1),
              ),
              12.gapH,
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.2,
                    color: context.colorScheme.primary.shade(100)),
              ),
              32.gapH,
              SizedBox(
                width: 100.w,
                height: 40.h,
                child: ColoredBackgroundButton(
                  onPressed: () {
                    context.pop();
                  },
                  text: context.language.ok,
                  buttonColor: ColoredButtonType.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
