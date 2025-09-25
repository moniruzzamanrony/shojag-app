import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../alert_map/presentation/widget/add_map_view_widget.dart';

/// UI [LocationBottomSheetView] for location bottom sheet
class LocationBottomSheetView extends StatelessWidget {
  final LatLng center;
  final void Function(LatLng selectedPosition) onConfirm;

  const LocationBottomSheetView({super.key, required this.center, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.h),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            top: 60.h,
            child: AddMapViewWidget(center: center, onConfirm: onConfirm),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 24.r,
                child: Icon(Icons.close, size: 22.sp, color: AppColors.colorAppRed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
