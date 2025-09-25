import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPassBackButtonWidget extends StatelessWidget {
  const ForgotPassBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        child: Center(
          child: CircleAvatar(
            backgroundColor: context.colorScheme.primary.shade(220),
            radius: 16.r,
            child: Icon(
              Icons.adaptive.arrow_back_rounded,
              size: Dimens.iconSize20,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
