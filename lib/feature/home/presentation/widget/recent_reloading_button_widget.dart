import 'dart:math' as math;

import 'package:app/core/utils/enums/operation_state.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/home/presentation/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/dimens.dart';

class RecentReloadingButtonWidget extends StatefulWidget {
  const RecentReloadingButtonWidget({super.key});

  @override
  State<RecentReloadingButtonWidget> createState() =>
      _RecentReloadingButtonWidgetState();
}

class _RecentReloadingButtonWidgetState
    extends State<RecentReloadingButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, bool>(
      selector: (_, p1) => p1.operationState == OperationState.waiting,
      builder: (_, isLoading, __) {
        if (!isLoading) {
          controller.stop();
        }
        return IconButton(
          onPressed: isLoading
              ? null
              : () {
                  context.read<HomeProvider>().getDashboardData(
                      userId: context.userId, token: context.apiToken);
                  controller.repeat();
                },
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
          ),
          icon: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2 * math.pi,
                child: child,
              );
            },
            child: Icon(
              Icons.refresh,
              color: context.colorScheme.primary,
              size: Dimens.iconSize18,
            ),
          ),
        );
      },
    );
  }
}
