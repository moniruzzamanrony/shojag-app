import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/config/router/routes.dart';
import '../../../../../../core/utils/helper/datetime_helper.dart';
import '../../../alert/domain/entity/alert_entity.dart';

class AlertMapCardSingleItem extends StatelessWidget {
  final AlertEntity item;

  const AlertMapCardSingleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.colorScheme.primary.shade(240).withAlpha(240);

    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.alertDetails, extra: item);
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        margin: Styles.horizontalPadding,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: Styles.boxShadow()),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.userName,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    item.createdAt
                            ?.formatDate(pattern: pattern_ddMMMyyyhhmma) ??
                        '-',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorBlack),
                  ),
                  8.gapH,
                  const Spacer(),
                  Text(
                    item.incidentTitle,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    item.geoAddress ?? '',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
