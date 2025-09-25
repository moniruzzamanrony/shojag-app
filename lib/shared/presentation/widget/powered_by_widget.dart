import 'package:app/core/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// [PoweredByWidget] : widget for powered by shojag
class PoweredByWidget extends StatelessWidget {
  final Color textColor;
  final Color imgColor;

  const PoweredByWidget(
      {super.key, required this.textColor, required this.imgColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Powered By ',
              style: TextStyle(color: textColor, fontSize: 12.sp),
            ),
            SvgPicture.asset(
              Assets.shojagPoweredByLogoEnSvg,
              height: 10.h,
              colorFilter: ColorFilter.mode(imgColor, BlendMode.srcIn),
      
            ),
          ],
        ),
      ),
    );
  }
}
