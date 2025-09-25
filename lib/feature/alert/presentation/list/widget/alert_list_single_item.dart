/* *
* alert list page single item ui
* */

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/alert_status.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../domain/entity/alert_entity.dart';

class AlertListSingleItem extends StatelessWidget {
  final AlertEntity item;

  const AlertListSingleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;

    switch (item.status) {
      case AlertStatus.active:
        backgroundColor = AppColors.colorAppRed;
        break;
      case AlertStatus.closed:
        backgroundColor = AppColors.colorAppGreen;
        break;
      case AlertStatus.none:
        backgroundColor = AppColors.colorGreyLight;
    }

    Color onBgBoxColor = backgroundColor.shade(220);

    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.alertDetails, extra: item);
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderRadius10)),
        child: Padding(
          padding: EdgeInsets.all(Dimens.padding8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatColumn(
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: item.incidentTitle,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        WidgetSpan(
                            child: Floatable(
                          float: FCFloat.end,
                          clear: FCClear.end,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                                color: onBgBoxColor,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: backgroundColor,
                                  size: Dimens.iconSize10,
                                ),
                                Text(
                                  context.language.toKMConverter(
                                      item.toDistanceModel.unit.name,
                                      item.toDistanceModel.distance,
                                  ),
                                  style: TextStyle(
                                      color: backgroundColor, fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                        )),
                        const TextSpan(text: '\n'),
                        TextSpan(
                            text: context.language.byWithName(item.userName)),
                        if (item.createdAt != null)
                          ...[
                            const TextSpan(text: ' '),
                            TextSpan(
                            text: timeago.format(item.createdAt!),
                            style:
                                const TextStyle(color: AppColors.colorAppGrey),
                          )],
                      ],
                    ),
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: DottedLine(dashColor: AppColors.colorGreyLight),
              ),
              Text(
                item.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorAppGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
