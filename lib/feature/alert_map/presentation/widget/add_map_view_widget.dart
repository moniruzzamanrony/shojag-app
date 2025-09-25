import 'dart:async';

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/location_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../shared/presentation/widget/colored_background_button.dart';

class AddMapViewWidget extends StatefulWidget {
  final LatLng center;
  final void Function(LatLng latLng) onConfirm;

  const AddMapViewWidget({super.key, required this.onConfirm, required this.center});

  @override
  State<AddMapViewWidget> createState() => _AddMapViewWidgetState();
}

class _AddMapViewWidgetState extends State<AddMapViewWidget> {
  late Position _selectedPosition;
  final double cameraZoom = 18.0;
  final double cameraTilt = 10.0;
  late Completer<MapboxMap> _mapboxMap;

  @override
  void initState() {
    super.initState();

    _mapboxMap = Completer();

    _selectedPosition = Position(widget.center.longitude, widget.center.latitude);
  }

  void _hideScaleBar() {
    _mapboxMap.future.then((controller) => controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false)));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      child: ColoredBox(
        color: AppColors.colorWhite,
        child: SafeArea(
          child: Stack(
            children: [
              MapWidget(
                styleUri: AppConstants.mapboxStyleForBasic,
                onMapCreated: _onMapCreated,
                onScrollListener: (a) {
                  _selectedPosition = Position(a.point.coordinates.lng, a.point.coordinates.lat);
                },
                onTapListener: (a) {
                  _selectedPosition = Position(a.point.coordinates.lng, a.point.coordinates.lat);
                  _mapboxMap.future.then(
                    (controller) => controller.flyTo(
                      CameraOptions(center: Point(coordinates: _selectedPosition)),
                      MapAnimationOptions(),
                    ),
                  );
                },
                cameraOptions: CameraOptions(
                  zoom: cameraZoom,
                  center: Point(coordinates: _selectedPosition),
                ),
                onCameraChangeListener: _onCameraChanged,
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 36.h),
                  child: Icon(Icons.location_on, size: 36.sp, color: Colors.red),
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: Dimens.horizontalSpace,
                right: Dimens.horizontalSpace,
                child: ColoredBackgroundButton(
                  onPressed: () =>
                      widget.onConfirm(LatLng(_selectedPosition.lat.toDouble(), _selectedPosition.lng.toDouble())),
                  buttonColor: ColoredButtonType.green,
                  text: context.language.confirm,
                ),
              ),
              Positioned(
                bottom: 110.h,
                right: 16.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      key: const ValueKey('my_location_button'),
                      onPressed: () => _moveToPosition(context),
                      shape: const CircleBorder(),
                      backgroundColor: AppColors.colorWhite,
                      child: Icon(Icons.my_location, color: AppColors.colorAppGreen, size: Dimens.iconSize16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _moveToPosition(BuildContext ctx) async {
    //if location is not enabled then request for it
    final isLocationEnabled = await LocationHelper.isLocationServiceEnabled;
    if (!ctx.mounted) {
      return;
    }
    if (!isLocationEnabled) {
      showAppSnackBar(
        ctx,
        'Location service is not enabled',
        type: MessageType.normal,
        behavior: SnackBarBehavior.fixed,
        action: SnackBarAction(
          label: 'Enable',
          onPressed: () {
            ctx.pop();
            LocationHelper.openLocationSettings();
          },
        ),
      );
      return;
    }
    _goToMyLocation();
  }

  Future<void> _goToMyLocation() async {
    Point? currentLocation;
    try {
      final location = await LocationHelper.getCurrentPosition();
      if (location != null) {
        currentLocation = Point(coordinates: Position(location.longitude, location.latitude));
      }
    } catch (_) {}

    if (currentLocation != null) {
      _mapboxMap.future.then(
        (controller) => controller.flyTo(CameraOptions(center: currentLocation), MapAnimationOptions()),
      );
    }
  }

  void _onMapCreated(MapboxMap controller) {
    _mapboxMap.complete(controller);
    _hideScaleBar();
  }

  void _onCameraChanged(CameraChangedEventData cameraChangedEventData) async {
    final cameraState = await (await _mapboxMap.future).getCameraState();
    final position = cameraState.center.coordinates;
    _selectedPosition = position;
  }
}
