import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// [BackButtonWidget] : widget for back button.
///
///  If user press back button, it will pop to previous screen
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.primary,
          ),
          child: Icon(
            Icons.arrow_back,
            size: 16.r,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
