import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/feature/fnf/presentation/list/widget/fnf_list_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/location_sharing_time_type.dart';

class SharingStatusWidget extends StatelessWidget {
  final String text;
  final LocationSharingTimeType sharingTimeType;
  final DateTime? expireAt;

  const SharingStatusWidget(
      {super.key,
      required this.text,
      required this.sharingTimeType,
      required this.expireAt});

  bool get isLimited => sharingTimeType == LocationSharingTimeType.limited;

  bool get isOff => sharingTimeType == LocationSharingTimeType.off;

  bool get isUnlimited => sharingTimeType == LocationSharingTimeType.unlimited;

  @override
  Widget build(BuildContext context) {
    String status = '';
    Color color = Colors.transparent;
    IconData icon = Icons.location_off;
    if (isOff) {
      icon = Icons.location_off;
      status = 'Share Off';
      color = AppColors.colorAppRed;
    } else if (isUnlimited) {
      status = 'Share On';
      color = AppColors.colorAppGreen;
      icon = Icons.location_on;
    } else if (isLimited) {
      icon = Icons.share_location;
      if (expireAt != null) {
        // format date time limit
        final isSameDay = expireAt!.isSameDay();

        final isSameMonth = expireAt!.isSameMonth();

        final isSameYear = expireAt!.isSameYear();

        String pattern = 'yyyy MMM dd hh:mm a';
        if (isSameDay) {
          pattern = 'hh:mm a';
        } else if (isSameMonth) {
          pattern = 'dd MMM, hh:mm a';
        } else if (isSameYear) {
          pattern = 'MMM dd hh:mm a';
        }

        final date = expireAt!.formatDate(pattern: pattern);

        // check if time has passed
        final hasTimeExceed = DateTime.now().isAfter(expireAt!);
        if (hasTimeExceed) {
          color = AppColors.colorAppRed;
          status = 'Ended In $date';
        } else {
          color = AppColors.colorAppGreen;
          status = 'Sharing Until $date';
        }
      } else {
        status = '---';
      }
    }

    return Skeleton.unite(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.shade(240),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                text,
                style: timeLimitStyle,
              ),
              const Spacer(),
              Icon(icon, size: 12.sp, color: color),
              gapBetweenTitles,
              Text(
                status,
                style: timeLimitStyle.copyWith(color: color),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
