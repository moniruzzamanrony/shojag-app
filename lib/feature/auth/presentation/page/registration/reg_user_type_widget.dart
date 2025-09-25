import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/constants/assets.dart';
import '../../../../../core/utils/enums/user_type.dart';
import '../../provider/registration_provider.dart';

class RegUserTypeWidget extends StatelessWidget {
  final UserType userType;
  final String title;
  final bool isSelected;

  const RegUserTypeWidget(
      {super.key,
      required this.userType,
      required this.isSelected,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RegistrationProvider>()
          ..resetAll()
          ..setErrorMessage('')
          ..selectedUserType = userType;
      },
      child: Column(
        children: [
          Container(
            height: 72.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? backgroundColor : Colors.white,
              boxShadow: isSelected
                  ? Styles.boxShadow(color: borderColor, colorOpacity: 0.3)
                  : null,
              border: Border.all(
                  color: isSelected ? borderColor : Colors.grey.shade200,
                  width: isSelected ? 1.2 : 1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: SvgPicture.asset(
              icon,
              height: 32.h,
            ),
          ),
          8.gapH,
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.0,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          )
        ],
      ),
    );
  }

  Color get backgroundColor {
    switch (userType) {
      case UserType.fireService:
        return AppColors.fireServiceCardColor;
      case UserType.police:
        return AppColors.policeCardColor;
      case UserType.ambulance:
        return AppColors.ambulanceCardColor;
      case UserType.citizen:
        return AppColors.communityCardColor;
      case UserType.none:
    }
    return Colors.grey.shade50;
  }

  Color get borderColor {
    switch (userType) {
      case UserType.fireService:
        return AppColors.fireServiceCardBorderColor;
      case UserType.police:
        return AppColors.policeCardBorderColor;
      case UserType.ambulance:
        return AppColors.ambulanceCardBorderColor;
      case UserType.citizen:
        return AppColors.communityCardBorderColor;
      case UserType.none:
    }
    return Colors.grey.shade50;
  }

  String get icon {
    String icon = '';
    switch (userType) {
      case UserType.fireService:
        icon = Assets.fireServiceSvg;
        break;
      case UserType.police:
        icon = Assets.policeSvg;
        break;
      case UserType.ambulance:
        icon = Assets.ambulanceSvg;
        break;
      case UserType.citizen:
        icon = Assets.citizenSvg;
        break;
      case UserType.none:
    }
    return icon;
  }
}
