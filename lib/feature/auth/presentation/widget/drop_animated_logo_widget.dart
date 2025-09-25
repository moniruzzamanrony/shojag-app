import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants/assets.dart';
import '../../../../shared/presentation/widget/drop_lottie_anim.dart';

class DropAnimatedLogoWidget extends StatelessWidget {
  final double height;
  final double? width;
  final double logoSize;
  final Color? rippleColor;

  const DropAnimatedLogoWidget(
      {super.key,
      required this.height,
      this.width,
      required this.logoSize,
      this.rippleColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DropLottieAnim(
            color: rippleColor ?? Colors.white,
          ),
          SvgPicture.asset(Assets.shojagLogoSvg,
              height: logoSize, width: logoSize),
        ],
      ),
    );
  }
}
