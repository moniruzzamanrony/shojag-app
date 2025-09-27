import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/enums/alert_type.dart';
import '../../../../shared/presentation/widget/drop_lottie_anim.dart';
import '../../../alert/presentation/incident_provider.dart';

class HomeButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String buttonText;
  final String icon;
  //final void Function() onTap;
  final AlertType buttonType;

  const HomeButtonWidget(
      {super.key,
      required this.backgroundColor,
      required this.borderColor,
      required this.buttonText,
      required this.icon,
      required this.buttonType,
      //required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onTap,
      onTap: () async {
        await context
            .read<IncidentProvider>()
            .getIncidentList(categoryId: buttonType.id);
        if (context.mounted) {
          context.goNamed(Routes.alertAdd, extra: buttonType);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              //color: backgroundColor,
              border: Border.all(color: borderColor, width: 1.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                DropLottieAnim(color: borderColor.shade(180)),
                SvgPicture.asset(icon, height: 32.h),
              ],
            ),
          ),
          Gap(Dimens.padding8),
          Text(buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: AppColors.colorBlack, height: 1))
        ],
      ),
    );
  }
}
