// This file contains the widget for displaying the FNF map page.
// It includes functionalities to load location, display them on the map, and interact with location items.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/location_helper.dart';
import 'package:app/feature/consent/presentation/widget/consent_checker.dart';
import 'package:app/feature/fnf/presentation/list/provider/fnf_list_provider.dart';
import 'package:app/feature/fnf/presentation/map/provider/current_fnf_model_provider.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_map_address_provider.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_map_view_provider.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_message_card_widget.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_message_send_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/constants/assets.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/helper/marker_helper.dart';
import '../../../../../core/utils/helper/permission_helper.dart';
import '../../../../../shared/domain/entity/map_marker.dart';
import '../../../../../shared/presentation/utils/annotation_click_listener.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../domain/entity/fnf_list_entity.dart';

class FnfMapViewWidget extends ConsumerStatefulWidget {
  const FnfMapViewWidget({super.key});

  @override
  ConsumerState<FnfMapViewWidget> createState() => _FnfMapViewWidgetState();
}

class _FnfMapViewWidgetState extends ConsumerState<FnfMapViewWidget> {
  late Completer<MapboxMap> _mapController;
  late Completer<PointAnnotationManager> _markerManager;

  double bearing = 0.0;
  double pitch = 0.0;
  double cameraZoom = 14.4;
  final double maxZoom = 18.0;

  StreamSubscription? _locationSubscription;
  late LatLng currentLocation;
  late LatLng? othersLocation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _mapController = Completer<MapboxMap>();
    _markerManager = Completer<PointAnnotationManager>();
    currentLocation = context.lastSavedLocationLatLng;
    othersLocation = ref.read(currentFnfModelProvider).baseLocation;

    final model = ref.read(currentFnfModelProvider);
    _hideScaleBar();
    _addressPinMarker();
    _initControllers(model);

    Future.microtask(() {
      if (!mounted) return;
      _loadMarkerIcons(context, model).then((value) {
        if (mounted) {
          _populateMarkers(context, ref.read(currentFnfModelProvider));
          _placeMarkersAnnotation();
          _fitCameraToBounds();
        }
      });
    });

    _refreshLocation();

    PermissionHelper.hasLocationPermission.onError((error, stackTrace) {
      if (mounted) {
        showAppSnackBar(context, error.toString(), type: MessageType.error);
      }
      return false;
    }).then((hasPermission) {
      if (hasPermission && mounted) {
        _locationSubscription ??= context.location.locationStream?.listen(
          (position) =>
              _onMyLocationUpdate(position, ref.read(currentFnfModelProvider)),
        );
      }
    });

    Future.microtask(() {
      if (!mounted) return;
      if (model.baseLocation == null) {
        showAppSnackBar(
            context,
            context.language
                .didNotSharedLocationWithYouUserName(model.userName),
            type: MessageType.error);
        return;
      }
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(currentFnfModelProvider);

    return Stack(
      children: [
        MapWidget(
          onMapCreated: _onMapCreated,
          onCameraChangeListener: _onCameraChanged,
          key: const ValueKey('view_mapbox_map'),
          styleUri: AppConstants.mapboxStyleForFnf,
          cameraOptions: CameraOptions(
            zoom: cameraZoom,
            pitch: pitch,
            bearing: bearing,
            center: Point(
                coordinates: Position(
                    currentLocation.longitude, currentLocation.latitude)),
          ),
        ),
        if (!model.isFriendSharedIsEnabled)
          Positioned(
              bottom: 24.h,
              left: Dimens.horizontalSpace,
              right: Dimens.horizontalSpace,
              child: SafeArea(
                child: Center(
                  child: LayoutBuilder(
                    builder: (_, constraints) => LoadingAnimatedButton(
                      onTap: (startLoading, stopLoading, btnState) {
                        _askForLiveLocation(
                            startLoading: startLoading,
                            stopLoading: stopLoading);
                      },
                      text: context.language.requestToShareLocation,
                      height: 44.h,
                      width: constraints.maxWidth,
                      btnColor: ColoredButtonType.green,
                    ),
                  ),
                ),
              )),
        Positioned(
            bottom: 24.h + (model.isFriendSharedIsEnabled ? 0.h : 60.h),
            left: Dimens.horizontalSpace,
            right: Dimens.horizontalSpace,
            child: FnfMessageCardWidget(model: model)),
        Positioned(
            right: 16.w,
            top: 52.h,
            child: FutureBuilder(
              future: PermissionHelper.hasLocationPermission,
              builder: (context, snapshot) => snapshot.data == true
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () async {
                        final hasPermission = await consentChecker(context);
                        if (!hasPermission || !context.mounted) {
                          return;
                        }
                        _locationSubscription ??=
                            context.location.locationStream?.listen(
                          (position) => _onMyLocationUpdate(position, model),
                        );
                        setState(() {});
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary),
                      icon: const Icon(Icons.my_location)),
            ))
      ],
    );
  }

  void _onMyLocationUpdate(LatLng position, FnfListEntity model) {
    currentLocation = position;
    if (mounted) {
      _populateMarkers(context, model);
      _updateMarkersAnnotation();
    }
  }

  void _onOtherLocationUpdate(FnfListEntity model) {
    if (model.baseLocation == null) {
      return;
    }
    othersLocation = model.baseLocation;
    if (mounted) {
      _populateMarkers(context, model);
      _updateMarkersAnnotation();
    }
  }

  void _onMapCreated(MapboxMap controller) {
    if (_mapController.isCompleted) return;
    controller.setBounds(CameraBoundsOptions(maxZoom: maxZoom));
    _mapController.complete(controller);
    ref.read(fnfMapViewProvider.notifier).setMapController(controller);
  }

  void _hideScaleBar() {
    _mapController.future.then((controller) {
      controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    });
  }

  Uint8List? myLocationIcon;
  Uint8List? otherLocationIcon;

  Future<void> _loadMarkerIcons(
      BuildContext context, FnfListEntity model) async {
    await _generateMyLocationMarkerIcon();
    await _generateOthersLocationMarkerIcon(model);
  }

  Future<void> _generateMyLocationMarkerIcon() async {
    final title = context.language.you;
    final snippet = context.language.tapToSendMessage;
    final photoUrl = context.user?.photo;

    myLocationIcon ??= await generateMapIconsWithShape(
      Assets.userProfilePng,
      title: title,
      snippet: snippet,
    ).catchError((_) => null);

    if (photoUrl != null) {
      final icon = await generateNetworkMapIconsWithShape(
        photoUrl,
        title: title,
        snippet: snippet,
      ).catchError((_) => null);

      if (icon?.isNotEmpty ?? false) {
        myLocationIcon = icon;
      }
    }
  }

  Future<void> _generateOthersLocationMarkerIcon(FnfListEntity model) async {
    final title = model.userName;
    final snippet = model.locationLastUpdateTime == null
        ? null
        : timeago.format(model.locationLastUpdateTime!);
    final photoUrl = model.image;

    //default icon (other location)
    otherLocationIcon ??= await generateMapIconsWithShape(
      Assets.userProfilePng,
      title: title,
      snippet: snippet,
    ).catchError((_) => null);

    // other location icon (with photo)
    if (photoUrl != null) {
      final icon = await generateNetworkMapIconsWithShape(photoUrl,
              title: title, snippet: snippet)
          .catchError((_) => null);
      if (icon?.isNotEmpty ?? false) {
        otherLocationIcon = icon;
      }
    }
  }

  void _initControllers(FnfListEntity model) async {
    await _mapController.future.then((controller) async {
      await controller.annotations
          .createPointAnnotationManager()
          .then((pointAnnotationManager) {
        pointAnnotationManager
            .addOnPointAnnotationClickListener(AnnotationClickListener(
          onAnnotationClick: (annotation) =>
              _onPointAnnotationClick(annotation, model),
        ));
        _markerManager.complete(pointAnnotationManager);
      });
    });
  }

  final Map<String, MapMarker> _markers = {};

  final String myLocationMarkerId = 'my_location';
  final String otherLocationMarkerId = 'other_location';

  // populate markers
  void _populateMarkers(BuildContext context, FnfListEntity model) {
    _markers.clear();

    //others marker
    if (othersLocation != null) {
      _markers[otherLocationMarkerId] = MapMarker(
          latitude: othersLocation!.latitude,
          longitude: othersLocation!.longitude,
          title: model.userName,
          snippet: model.locationLastUpdateTime == null
              ? null
              : timeago.format(model.locationLastUpdateTime!),
          image: otherLocationIcon,
          markerId: otherLocationMarkerId);
    }

    //self marker
    _markers[myLocationMarkerId] = MapMarker(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        title: context.language.tapToSendMessage,
        snippet: context.language.you,
        image: myLocationIcon,
        markerId: myLocationMarkerId);
  }

  final Map<String, PointAnnotation> _annotations = <String, PointAnnotation>{};

  // place markers
  Future<void> _placeMarkersAnnotation() async {
    await _markerManager.future.then((pointAnnotationManager) async {
      await pointAnnotationManager.deleteAll();
      _annotations.clear();

      for (final entry in _markers.entries) {
        await _addAnnotations(entry, pointAnnotationManager);
      }
    });
  }

  // add markers
  Future<void> _addAnnotations(
      MapEntry<String, MapMarker> entry, PointAnnotationManager manager) async {
    final key = entry.key;
    final value = entry.value;

    final annotation = PointAnnotationOptions(
        iconSize: 1.0,
        geometry: Point(coordinates: Position(value.longitude, value.latitude)),
        image: value.image,
        iconAnchor: IconAnchor.BOTTOM,
        iconColor: Colors.black.value);

    await manager.create(annotation).then((val) {
      _annotations[key] = val;
    });
  }

  // update markers or insert if null
  Future<void> _updateMarkersAnnotation() async {
    await _markerManager.future.then((pointAnnotationManager) async {
      try {
        for (final entry in _markers.entries) {
          final key = entry.key;
          final annotation = _annotations[key];

          // add if annotation is null [ not exist ]
          if (annotation == null) {
            await _addAnnotations(entry, pointAnnotationManager);
          }
          // update if exist
          else {
            await _updateAnnotations(entry, pointAnnotationManager);
          }
        }
      } catch (_) {}
    });
  }

  // update annotation
  Future<void> _updateAnnotations(
      MapEntry<String, MapMarker> entry, PointAnnotationManager manager) async {
    final key = entry.key;
    final value = entry.value;
    final annotation = _annotations[key];

    if (annotation != null) {
      annotation.geometry =
          Point(coordinates: Position(value.longitude, value.latitude));
      annotation.image = value.image;
      annotation.iconImage = null;
      await manager.update(annotation);
    }
  }

  // fit camera to bounds
  void _fitCameraToBounds() {
    _mapController.future.then((controller) async {
      final latLngList =
          _markers.values.map((m) => LatLng(m.latitude, m.longitude)).toList();
      if (latLngList.isNotEmpty) {
        final bounds = LocationHelper.calculateBoundsByList(latLngList);
        MbxEdgeInsets adjustedPadding = MbxEdgeInsets(
          top: 100,
          left: 20,
          bottom: 100,
          right: 20,
        );
        if (Platform.isAndroid) {
          final mapSize = await controller.getSize();
          adjustedPadding = MbxEdgeInsets(
            top: math.min(100, mapSize.height / 2),
            left: math.min(50, mapSize.width / 2),
            bottom: math.min(100, mapSize.height / 2),
            right: math.min(50, mapSize.width / 2),
          );
        }

        final cameraOptions = await controller.cameraForCoordinateBounds(
            bounds, adjustedPadding, bearing, pitch, cameraZoom, null);

        controller.flyTo(cameraOptions, MapAnimationOptions());
      }
    });
  }

  // ask for live location
  void _askForLiveLocation(
      {required Function startLoading, required Function stopLoading}) async {
    showAppDialog(
      context,
      dialogWidget: AlertDialog(
        title: Text(context.language.confirmation),
        content: Text(
          context.language.requestToShareLocation,
          style: const TextStyle(color: AppColors.colorBlack),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.language.cancel,
            ),
          ),
          LoadingAnimatedButton(
            height: 36.h,
            width: 80.w,
            minWidth: 10,
            text: context.language.confirm,
            btnColor: ColoredButtonType.green,
            onTap: (str, stp, btnState) async {
              context.pop();
              startLoading.call();
              ref
                  .read(fnfMapViewProvider.notifier)
                  .locationShareRequest(token: context.apiToken)
                  .then(
                (isSuccess) {
                  if (isSuccess) {
                    if (mounted) {
                      showAppSnackBar(
                          context, context.language.requestSentWaitForAccept,
                          type: MessageType.success);
                    }
                  }
                },
              ).whenComplete(() {
                stopLoading.call();
              });
            },
          ),
        ],
      ),
    );
  }

  void _onPointAnnotationClick(
      PointAnnotation annotation, FnfListEntity model) {
    // click on my location
    if (_annotations[myLocationMarkerId]?.id != null &&
        _annotations[myLocationMarkerId]?.id == annotation.id) {
      showBottomSheet(
        context: context,
        builder: (context) => FnfMessageSendWidget(model: model),
      );
    }
  }

  // go to location with fly animation
  void _flyToLocation(Point location) {
    _mapController.future.then((controller) {
      controller.flyTo(
        CameraOptions(
          center: location,
          zoom: cameraZoom,
          bearing: bearing,
          pitch: pitch,
        ),
        MapAnimationOptions(duration: 1000),
      );
    });
  }

  // go to location with ease animation
  void _easeToLocation(Point location) {
    _mapController.future.then((controller) {
      controller.easeTo(
        CameraOptions(
          center: location,
          zoom: cameraZoom,
          bearing: bearing,
          pitch: pitch,
        ),
        MapAnimationOptions(duration: 1000),
      );
    });
  }

  // camera changed event
  void _onCameraChanged(CameraChangedEventData cameraChangedEventData) {
    final cameraState = cameraChangedEventData.cameraState;
    bearing = cameraState.bearing;
    cameraZoom = cameraState.zoom;
    pitch = cameraState.pitch;
  }

  // add address marker
  void _addressPinMarker() async {
    final addressList = ref.read(fnfMapViewAddressProvider).addressList;

    if (addressList.isEmpty) return;

    List<Map<String, dynamic>> features = addressList.map((address) {
      return {
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [address.longitude, address.latitude],
        },
        "properties": {
          "title": address.label,
          "description":
              "${address.label} lat:${address.latitude} lng:${address.longitude}",
        }
      };
    }).toList();

    final geoJsonData = jsonEncode({
      "type": "FeatureCollection",
      "features": features,
    });

    _mapController.future.then((controller) async {
      final style = controller.style;
      const sourceId = "locations-source";
      const layerId = "locations-layer";

      // Remove existing source and layer if they already exist
      if (await style.styleLayerExists(layerId)) {
        await style.removeStyleLayer(layerId);
      }
      if (await style.styleSourceExists(sourceId)) {
        await style.removeStyleSource(sourceId);
      }

      await style.addSource(GeoJsonSource(id: sourceId, data: geoJsonData));

      await style.addLayer(SymbolLayer(
        id: layerId,
        sourceId: sourceId,
        iconImage: 'mapbox-star',
        // Ensure this icon exists in your Mapbox style
        iconSize: 1.0,
        iconAnchor: IconAnchor.BOTTOM,
        iconOffset: [0.0, -6.0],
        textField: '{title}',
        textAnchor: TextAnchor.BOTTOM,
        textOffset: [0.0, -2.8],
        textSize: 14.0,
      ));
    });
  }

  // refresh details
  void _refreshLocation() {
    _timer ??=
        Timer.periodic(const Duration(seconds: 15), (_) => _loadDetails());
  }

  bool _isLoading = false;

  void _loadDetails() {
    if (_isLoading) return;
    if (!mounted) return;

    _isLoading = true;

    ref
        .read(fnfMapViewProvider.notifier)
        .getUpdatedFnfDetails(context.apiToken)
        .then((_) async {
      final updatedModel = ref.read(fnfMapViewProvider).model;
      await _generateOthersLocationMarkerIcon(updatedModel);
      _onOtherLocationUpdate(updatedModel);
      // if (true) {
      //   if (updatedModel.baseLocationPoint != null) {
      //     _easeToLocation(updatedModel.baseLocationPoint!);
      //   }
      // }

      ref.read(currentFnfModelProvider.notifier).state = updatedModel;
      ref.read(fnfListProvider.notifier).replaceItem(updatedModel);
    }).whenComplete(() => _isLoading = false);
  }

/*  void _iniPusher() async {
    await PusherService.instance.initialize();
    await PusherService.instance.subscribe('friend-details', onEvent: (e) {
      print(e.runtimeType);
      if (e is PusherEvent) {
        final data = e.data;
        print(data.runtimeType);
        print(data);
        final element =
            FnfDetailsRemoteResponseModel.fromJson(jsonDecode(data)).data!;
        final updateModel = FnfListEntity(
            id: element.id?.toInt() ?? 0,
            userId: element.userId?.toInt() ?? 0,
            userName: element.userName ?? '',
            userPhone: element.userPhone ?? '',
            image: element.image,
            selfLocationSharingTimeType: LocationSharingTimeType.fromString(
                element.selfShareStatus ?? ''),
            selfLocationPermissionExpireAt: element.selfTimeLimit?.toDateTime,
            friendLocationSharingTimeType: LocationSharingTimeType.fromString(
                element.friendShareStatus ?? ''),
            friendLocationPermissionExpireAt:
                element.friendTimeLimit?.toDateTime,
            latitude: element.latitude?.toDouble(),
            longitude: element.longitude?.toDouble(),
            locationLastUpdateTime: element.locationUpdateTime.toDateTime,
            type: element.type ?? '',
            locations: element.locations
                    ?.map(
                      (loc) => FnfLocationsEntity(
                          id: loc.id?.toInt() ?? 0,
                          fnfId: loc.friendId?.toInt() ?? 0,
                          label: loc.label ?? '',
                          latitude: loc.latitude?.toDouble() ?? 0.0,
                          longitude: loc.longitude?.toDouble() ?? 0.0),
                    )
                    .toList() ??
                [],
            status: FnfStatus.fromId(element.status?.toInt() ?? 0),
            message: element.message != null
                ? FnfMessageEntity(
                    message: element.message,
                    time: element.messageTime.toDateTime)
                : null);
        print(updateModel);
        _generateOthersLocationMarkerIcon(updateModel).then((_) {
          _onOtherLocationUpdate(updateModel);
        });
        ref.read(currentFnfModelProvider.notifier).state = updateModel;
      }
    });

    await PusherService.instance.connect();
  }*/
}
