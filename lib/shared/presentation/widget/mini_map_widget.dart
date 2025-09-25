/*
 * ui : map widget for mapbox details page mini map page
 */

import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../core/config/theme/app_colors.dart';

/// [MiniMapWidget] : widget for mini map
/// which is used in mapbox details page
/// this widget will show the location of alert
class MiniMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MiniMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MiniMapWidget> createState() => _MiniMapWidgetState();
}

class _MiniMapWidgetState extends State<MiniMapWidget> {
  late final MapboxMap _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  late Position position;

  @override
  void initState() {
    super.initState();
    position = Position(widget.longitude, widget.latitude);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapWidget(
          styleUri: MapboxStyles.OUTDOORS,
          cameraOptions: CameraOptions(
            center: Point(
              coordinates: position, // San Francisco
            ),
            zoom: 13.4,
            pitch: 45.0,
            bearing: 0.0,
          ),
          onMapCreated: _onMapCreated,
        ),
        Positioned(
            right: 4.r,
            bottom: 4.r,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.colorWhite.withAlpha(240),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fullscreen,
                        size: 16.sp,
                        color: context.colorScheme.primary,
                      ),
                      4.gapW,
                      Text(
                        context.language.viewMap,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )))
      ],
    );
  }

  void _onMapCreated(MapboxMap controller) {
    _mapboxMap = controller;
    _hideScaleBar();
    _initializePointAnnotationManager();
  }

  void _hideScaleBar() {
    _mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
  }

  //markers and annotation
  void _initializePointAnnotationManager() async {
    _pointAnnotationManager =
        await _mapboxMap.annotations.createPointAnnotationManager();
    _initialMarker();
  }

  void _initialMarker() async {
    final ByteData bytes = await rootBundle.load(Assets.alertLocationRedPng);
    final Uint8List imageData = bytes.buffer.asUint8List();

    // Create a PointAnnotationOptions
    PointAnnotationOptions pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: position),
        image: imageData,
        iconAnchor: IconAnchor.BOTTOM,
        iconSize: 0.6);

    // Add the annotation to the map
    await _pointAnnotationManager?.create(pointAnnotationOptions);
  }
}
