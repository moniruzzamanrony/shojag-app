import 'package:animations/animations.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/shared/presentation/widget/mini_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../domain/entity/alert_response_entity.dart';
import 'location_direction_page.dart';

class MapViewSwitchWidget extends StatelessWidget {
  final LatLng eventLatLng;
  final bool isOwnPost;

  const MapViewSwitchWidget({
    super.key,
    required this.eventLatLng,
    required this.isOwnPost,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return Selector<AlertDetailsProvider, List<AlertResponseEntity>>(
          selector: (_, p1) => p1.responseMapList.values.toList(),
          builder: (_, responses, __) => LocationDirectionPage(
              eventLatLng: eventLatLng,
              isOwnPost: isOwnPost,
              responses: responses),
        );
      },
      closedElevation: 0,
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: IgnorePointer(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1.sw, maxHeight: 1.sw),
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColors.colorGreyExtraLight),
              ),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 2,
                child: MiniMapWidget(
                  key: ValueKey(eventLatLng),
                  longitude: eventLatLng.longitude,
                  latitude: eventLatLng.latitude,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
