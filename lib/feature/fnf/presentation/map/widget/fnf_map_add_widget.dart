import 'dart:async';

import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/presentation/list/provider/fnf_list_provider.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_map_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/constants/assets.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../provider/current_fnf_model_provider.dart';
import '../provider/fnf_map_view_provider.dart';

class FnfMapAddWidget extends ConsumerStatefulWidget {
  const FnfMapAddWidget({super.key});

  @override
  ConsumerState<FnfMapAddWidget> createState() => _FnfMapAddWidgetState();
}

class _FnfMapAddWidgetState extends ConsumerState<FnfMapAddWidget> {
  late Completer<MapboxMap> _mapController;

  double bearing = 0.0;
  double pitch = 0.0;
  double cameraZoom = 14.4;
  final double maxZoom = 18.0;

  LatLng? selectedLocation;

  late TextEditingController _addressController;

  bool locationButtonVisibility = false;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController();

    _addressController.addListener(_controllerListener);

    _mapController = Completer<MapboxMap>();

    _hideScaleBar();
  }

  void _controllerListener() {
    bool visibility = false;
    if (selectedLocation != null) {
      if (_addressController.text.trim().isNotEmpty) {
        visibility = true;
      } else {
        visibility = false;
      }
    }
    if (mounted && visibility != locationButtonVisibility) {
      {
        setState(() {
          locationButtonVisibility = visibility;
        });
      }
    }
  }

  @override
  void dispose() {
    _addressController.removeListener(_controllerListener);
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(currentFnfModelProvider);
    return Stack(
      children: [
        MapWidget(
          onMapCreated: _onMapCreated,
          onTapListener: (l) => _flyToLocation(l.point),
          key: const ValueKey('add_mapbox_map'),
          styleUri: AppConstants.mapboxStyleForFnf,
          onScrollListener: _onScrollListener,
          cameraOptions: CameraOptions(
            zoom: cameraZoom,
            pitch: pitch,
            bearing: bearing,
            center: model.baseLocation == null
                ? null
                : Point(
                    coordinates: Position(
                        selectedLocation?.longitude ?? model.longitude!,
                        selectedLocation?.latitude ?? model.latitude!)),
          ),
        ),

        // select location label info
        if (selectedLocation == null)
          Positioned(
            top: Dimens.verticalSpace,
            bottom: Dimens.verticalSpace,
            left: Dimens.horizontalSpace,
            right: Dimens.horizontalSpace,
            child: IgnorePointer(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Text(
                    context.language.tapOnMapToAddALocationAddSetALabel,
                    style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorAppGreen),
                  ),
                ),
              ),
            ),
          ),

        // address text field
        if (selectedLocation != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 150.r,
            child: Center(
              child: SizedBox(
                  width: 0.66.sw,
                  child: TextFormField(
                    controller: _addressController,
                    maxLength: 14,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return context.language.nameIsRequired;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 12.sp, height: 1.0),
                    decoration: InputDecoration(
                      hintText: context.language.enterPlaceName,
                      fillColor: Colors.white.withAlpha(244),
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      errorStyle: TextStyle(
                          fontSize: 10.sp,
                          color: context.colorScheme.error,
                          backgroundColor:
                              context.colorScheme.error.shade(240)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none),
                    ),
                  )),
            ),
          ),

        // center location pin
        if (selectedLocation != null)
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 36.r,
              child: Center(
                  child: Image.asset(Assets.locationPinPng,
                      height: 36.r, width: 36.r))),

        // confirm button
        if (selectedLocation != null)
          Positioned(
            left: Dimens.horizontalSpace,
            right: Dimens.horizontalSpace,
            bottom: 36.r,
            child: SafeArea(
              child: LoadingAnimatedButton(
                  height: 40.h,
                  width: 1.sw,
                  minWidth: 10,
                  text: context.language.confirm,
                  btnColor: ColoredButtonType.green,
                  onTap: locationButtonVisibility
                      ? (startLoading, stopLoading, btnState) {
                          return _addLocation(
                              context, _addressController, selectedLocation!,
                              startLoading: startLoading,
                              stopLoading: stopLoading);
                        }
                      : null),
            ),
          ),
      ],
    );
  }

  void _onMapCreated(MapboxMap controller) {
    if (_mapController.isCompleted) return;
    controller.setBounds(CameraBoundsOptions(maxZoom: maxZoom));
    _mapController.complete(controller);
  }

  void _hideScaleBar() {
    _mapController.future.then((controller) {
      controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    });
  }

  void _flyToLocation(Point location) {
    _mapController.future.then((controller) async {
      final cameraState = await controller.getCameraState();

      controller.flyTo(
        CameraOptions(
          center: location,
          zoom: cameraState.zoom,
          bearing: cameraState.bearing,
          pitch: cameraState.pitch,
        ),
        MapAnimationOptions(duration: 1000),
      );

      setState(() {
        selectedLocation = LatLng(location.coordinates.lat.toDouble(),
            location.coordinates.lng.toDouble());
      });
    });
  }

  void _addLocation(
      BuildContext ctx, TextEditingController controller, LatLng latLng,
      {required Function startLoading, required Function stopLoading}) {
    if (controller.text.isEmpty) {
      return;
    }

    startLoading.call();

    final notifier = ref.read(fnfMapViewAddressProvider.notifier);
    final model = ref.watch(fnfMapViewProvider).model;

    notifier
        .addAddress(
      fnfId: model.id,
      userId: model.userId,
      token: ctx.apiToken,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      label: controller.text,
    )
        .onError((error, stacktrace) {
      if (mounted) {
        showAppSnackBar(context, error.toString(), type: MessageType.error);
      }
      return false;
    }).then((isSuccess) {
      if (isSuccess) {
        if (mounted) {
          showAppSnackBar(context, context.language.addressAddedSuccessfully,
              type: MessageType.success);
        }
        _updateFnfListAndModel(model.id);
      }
    }).whenComplete(() {
      stopLoading.call();
    });
  }

  void _onScrollListener(MapContentGestureContext mcgc) {
    final gestureState = mcgc.gestureState;

    if (gestureState == GestureState.ended) {
      setState(() {
        if (selectedLocation != null) {
          selectedLocation = LatLng(mcgc.point.coordinates.lat.toDouble(),
              mcgc.point.coordinates.lng.toDouble());
        }
      });
    }
  }

  void _updateFnfListAndModel(int id) async {
    await ref
        .read(fnfListProvider.notifier)
        .loadList(token: context.apiToken, userId: context.userId);

    final updatedModel = ref.read(fnfListProvider).getListItemById(id);

    if (updatedModel != null) {
      ref.read(currentFnfModelProvider.notifier).state = updatedModel;
    }
  }
}
