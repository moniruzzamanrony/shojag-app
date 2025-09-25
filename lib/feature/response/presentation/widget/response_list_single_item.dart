import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../../../../core/config/theme/app_colors.dart';
import '../../../alert/domain/entity/alert_response_entity.dart';

class ResponseListSingleItem extends StatelessWidget {
  final AlertResponseEntity item;

  const ResponseListSingleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.name,
            style: TextStyle(
                fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.2),
          ),
          Row(
            children: [
              Text(
                time_ago.format(item.createdAt!),
                style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.colorAppGrey,
                    fontWeight: FontWeight.w400),
              ),
              8.gapW,
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: getCardColorByUserType(item.userType)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.isBangla
                            ? item.userType.titleBn
                            : item.userType.titleEn,
                        style: TextStyle(
                            fontSize: 9.sp,
                            height: 1,
                            color: getCardBorderColorByUserType(item.userType)),
                      ),
                      4.gapW,
                      SvgPicture.asset(getAssetsSvgByUserType(item.userType),
                          width: 9.r, height: 9.r),
                    ],
                  )),
            ],
          ),
        ],
      ),
      subtitle: item.message == null
          ? null
          : Text(
              item.message!,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 12.sp),
            ),
    );
  }
}
