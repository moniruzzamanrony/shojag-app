import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/assets.dart';

/// [DropLottieAnim] : widget for drop lottie animation
/// It will take color and reverse as optional parameter
/// otherwise default color will be used [AppColors.colorPrimary]
class DropLottieAnim extends HookWidget {
  final Color? color;
  final bool? reverse;

  const DropLottieAnim({super.key, this.color, this.reverse});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration.zero);

    return Lottie.asset(
      controller: animationController,
      Assets.pulseCircleDropJson,
      reverse: reverse,
      onLoaded: (composition) {
        animationController
          ..duration = composition.duration
          ..repeat();
      },
      frameRate: FrameRate.composition,
      delegates: LottieDelegates(
        text: (initialText) => '**$initialText**',
        values: [
          ValueDelegate.color(
            const ['Circle - 1', 'Ellipse 1', 'Fill 1'],
            value: color ?? AppColors.colorPrimary,
          ),
          ValueDelegate.color(
            const ['Circle - 2', 'Ellipse 1', 'Fill 1'],
            value: color ?? AppColors.colorPrimary,
          ),
          ValueDelegate.color(
            const ['Circle - 3', 'Ellipse 1', 'Fill 1'],
            value: color ?? AppColors.colorPrimary,
          ),
          ValueDelegate.color(
            const ['Circle - 4', 'Ellipse 1', 'Fill 1'],
            value: color ?? AppColors.colorPrimary,
          ),
          ValueDelegate.color(
            const ['Circle - 5', 'Ellipse 1', 'Fill 1'],
            value: color ?? AppColors.colorPrimary,
          ),
        ],
      ),
    );
  }
}

/// [PulseLottieAnim] : widget for pulse lottie animation
/// It will take color and reverse as optional parameter
/// otherwise default color will be used [AppColors.colorPrimary]
class PulseLottieAnim extends HookWidget {
  final Color? color;
  final bool? reverse;

  const PulseLottieAnim({super.key, this.color, this.reverse});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration.zero);
    final shadeColor = color?.shade(150);

    return Lottie.asset(
      Assets.locationPulseJson,
      reverse: reverse,
      frameRate: const FrameRate(30),
      repeat: true,
      onLoaded: (composition) {
        animationController
          ..duration = composition.duration
          ..repeat();
      },
      controller: animationController,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(const ['Circle', 'Ellipse 1', 'Fill 1'],
              value: color),
          ValueDelegate.color(const ['Fade 12', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 11', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 10', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 9', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 8', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 7', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 6', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 5', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 4', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 3', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 2', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade 1', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
          ValueDelegate.color(const ['Fade', 'Ellipse 1', 'Fill 1'],
              value: shadeColor),
        ],
      ),
    );
  }
}

/// [SimpleLottie] : widget for simple lottie animation
/// It will take [height] and [width] as optional parameter
/// It will take [asset] as required parameter
class SimpleLottie extends HookWidget {
  final String asset;
  final double? height;
  final double? width;

  const SimpleLottie(this.asset, {super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration.zero);

    return Lottie.asset(
      asset,
      height: height,
      width: width,
      frameRate: const FrameRate(30),
      controller: animationController,
      onLoaded: (composition) {
        animationController
          ..duration = composition.duration
          ..repeat();
      },
    );
  }
}
