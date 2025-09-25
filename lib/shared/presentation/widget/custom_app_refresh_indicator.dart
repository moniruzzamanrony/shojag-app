import 'package:app/core/utils/extension/context_extension.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/style/style.dart';

/// [CustomAppRefreshIndicator] : widget for custom refresh indicator
/// used to refresh the screen and data based on [onRefresh]
class CustomAppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomAppRefreshIndicator(
      {super.key, required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      useMaterialContainer: false,
      displacement: 0,
      indicatorBuilder: (context, controller) {
        if (controller.isDragging && controller.value == 0) {
          return  const SizedBox.shrink();
        } else if (controller.isDragging || controller.isArmed) {
          return AnimatedContainer(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: Styles.boxShadow(),
            ),
            duration:  const Duration(milliseconds: 100),
            child:  const Icon(Icons.refresh),
          );
        }

        return RefreshProgressIndicator(
          indicatorMargin: EdgeInsets.zero,
          valueColor: controller.value > 0
              ? AlwaysStoppedAnimation<Color>(context.colorScheme.primary)
              : null,
        );
      },
      onRefresh: onRefresh,
      child: child,
    );
  }
}
