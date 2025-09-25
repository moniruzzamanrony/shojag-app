import 'dart:async';
import 'dart:typed_data';

import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/enums/user_type.dart';
import '../../../../../core/utils/helper/marker_helper.dart';
import '../../../../../shared/domain/entity/map_marker.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';
import '../../../domain/entity/alert_response_entity.dart';

class LocationDirectionPage extends StatefulWidget {
  final LatLng eventLatLng;
  final bool isOwnPost;
  final List<AlertResponseEntity> responses;

  const LocationDirectionPage(
      {super.key,
      required this.eventLatLng,
      required this.isOwnPost,
      required this.responses});

  @override
  State<LocationDirectionPage> createState() => _LocationDirectionPageState();
}

class _LocationDirectionPageState extends State<LocationDirectionPage> {
  late Completer<MapboxMap> _mapController;
  late Completer<PointAnnotationManager> _markerManager;
  late Completer<PolylineAnnotationManager> _polylineManager;

  late LatLng sourceLocation;
  late LatLng destinationLocation;
  late LatLng currentLocation;

  StreamSubscription<LatLng>? _locationSubscription;

  late UserType currentUserType;

  bool isResponder = false;

  double bearing = 0.0;
  double pitch = 0.0;
  double cameraZoom = 14.4;

  @override
  void initState() {
    super.initState();
    _mapController = Completer();
    _markerManager = Completer();
    _polylineManager = Completer();

    currentUserType = context.userType ?? UserType.none;
    isResponder =
        context.read<AlertDetailsProvider>().isResponded(context.userId);
    destinationLocation = widget.eventLatLng;
    sourceLocation = context.lastSavedLocationLatLng;
    currentLocation = sourceLocation;

    _hideScaleBar();
    _initControllers();
    _loadMarkerIcons().then((value) async {
      await _initMarkers();
      _fitCameraToBounds();
    });

    _onLocationUpdate(currentLocation);
    _populateCurrentLocationStream(context);
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Column(
        children: [
          CustomAppBar(
            title: context.language.viewMap,
          ),
          Expanded(
            child: CurvedTopRadiusToChild(
              child: MapWidget(
                onMapCreated: _onMapCreated,
                styleUri: 'mapbox://styles/shojagapp/cm3n4u7c8002n01qw1vmp4x6p',
                //styleUri: MapboxStyles.OUTDOORS,
                cameraOptions: CameraOptions(
                  zoom: cameraZoom,
                  center: Point(
                      coordinates: Position(destinationLocation.longitude,
                          destinationLocation.latitude)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap controller) {
    _mapController.complete(controller);
  }

  void _hideScaleBar() {
    _mapController.future.then((controller) {
      controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    });
  }

  Uint8List? myLocationIcon;
  Uint8List? alertLocationIcon;
  Uint8List? citizenIcon;
  Uint8List? policeIcon;
  Uint8List? ambulanceIcon;
  Uint8List? fireServiceIcon;

  Future<void> _loadMarkerIcons() async {
    await generateMapIconsWithShape(Assets.myLocationPng,
            customShape: false, snippet: 'My Location')
        .then(
      (value) {
        if (value != null) {
          myLocationIcon = value;
        }
      },
    );

    await generateMapIconsWithShape(Assets.alertLocationRedPng,
            snippet: 'Alert Location', customShape: false)
        .then(
      (value) {
        if (value != null) {
          alertLocationIcon = value;
        }
      },
    );

    await generateMapIconsWithShape(Assets.citizenPng,
            customShape: false, snippet: UserType.citizen.titleEn)
        .then(
      (value) {
        if (value != null) {
          citizenIcon = value;
        }
      },
    );

    await generateMapIconsWithShape(Assets.policeLocationPng,
            customShape: false, snippet: UserType.police.titleEn)
        .then(
      (value) {
        if (value != null) {
          policeIcon = value;
        }
      },
    );

    await generateMapIconsWithShape(Assets.ambulanceLocationPng,
            customShape: false, snippet: UserType.ambulance.titleEn)
        .then(
      (value) {
        if (value != null) {
          ambulanceIcon = value;
        }
      },
    );

    await generateMapIconsWithShape(Assets.fireServiceLocationPng,
            customShape: false, snippet: UserType.fireService.titleEn)
        .then(
      (value) {
        if (value != null) {
          fireServiceIcon = value;
        }
      },
    );
  }

  void _initControllers() async {
    await _mapController.future.then((controller) async {
      await controller.annotations
          .createPointAnnotationManager()
          .then((pointAnnotationManager) {
        _markerManager.complete(pointAnnotationManager);
      });

      await controller.annotations
          .createPolylineAnnotationManager()
          .then((polylineAnnotationManager) {
        _polylineManager.complete(polylineAnnotationManager);
      });
    });
  }

  Map<String, MapMarker> markersMap = {};

  void _populateMarkers() {
    markersMap.clear();
    if (widget.isOwnPost) {
      // own alert marker page
      markersMap['destination'] = MapMarker(
          latitude: destinationLocation.latitude,
          longitude: destinationLocation.longitude,
          title: 'Destination',
          snippet: '',
          image: alertLocationIcon,
          markerId: 'destination');

      //current location marker
      markersMap['my_location'] = MapMarker(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          title: 'My Location',
          snippet: '',
          image: myLocationIcon,
          markerId: 'my_location');

      for (final element in widget.responses) {
        if (element.userType == UserType.police) {
          markersMap['police'] = MapMarker(
              latitude: element.latitude,
              longitude: element.longitude,
              title: element.userType.titleEn,
              snippet: element.message,
              image: policeIcon,
              markerId: 'police');
        } else if (element.userType == UserType.ambulance) {
          markersMap['ambulance'] = MapMarker(
              latitude: element.latitude,
              longitude: element.longitude,
              title: element.userType.titleEn,
              snippet: element.message,
              image: ambulanceIcon,
              markerId: 'ambulance');
        } else if (element.userType == UserType.fireService) {
          markersMap['fire_service'] = MapMarker(
            markerId: 'fire_service',
            latitude: element.latitude,
            longitude: element.longitude,
            title: element.userType.titleEn,
            snippet: element.message,
            image: fireServiceIcon,
          );
        }
      }
    } else {
      //responders marker page
      if (currentUserType == UserType.police ||
          currentUserType == UserType.ambulance ||
          currentUserType == UserType.fireService) {
        markersMap['alert_location'] = MapMarker(
            latitude: destinationLocation.latitude,
            longitude: destinationLocation.longitude,
            title: 'Destination',
            snippet: '',
            image: alertLocationIcon,
            markerId: 'alert_location');
        markersMap['my_location'] = MapMarker(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude,
            title: 'My Location',
            snippet: '',
            image: myLocationIcon,
            markerId: 'my_location');
      } else {
        markersMap['alert_location'] = MapMarker(
            latitude: destinationLocation.latitude,
            longitude: destinationLocation.longitude,
            title: 'Destination',
            snippet: '',
            image: alertLocationIcon,
            markerId: 'alert_location');
      }
    }
  }

  Map<String, PointAnnotation?> points = {};

  Future<void> _initMarkers() async {
    await _markerManager.future.then((markerManager) async {
      await markerManager.deleteAll();
      points.clear();
      _populateMarkers();

      for (final mKey in markersMap.keys) {
        final item = markersMap[mKey];
        if (item == null) continue;
        PointAnnotationOptions pointAnnotationOptions = PointAnnotationOptions(
          iconAnchor: IconAnchor.BOTTOM,
          geometry: Point(coordinates: Position(item.longitude, item.latitude)),
          image: item.image,
          iconSize: 1.0,
        );

        points[mKey] = await markerManager.create(pointAnnotationOptions);
      }
    });
  }

  Future<void> _updateMarkers(Map<String, LatLng> updatedMarkers) async {
    await _markerManager.future.then((markerManager) async {
      for (final key in updatedMarkers.keys) {
        final point = points[key];
        if (point != null) {
          point.geometry = Point(
              coordinates: Position(updatedMarkers[key]!.longitude,
                  updatedMarkers[key]!.latitude));
          await markerManager.update(point);
        }
      }
    });
  }

  void _onLocationUpdate(LatLng position) {
    currentLocation = position;
    if (mounted && currentUserType != UserType.none) {
      _updateMarkers({'my_location': currentLocation});
    }
  }

  void _fitCameraToBounds() {
    _mapController.future.then((controller) async {
      final latLngList = markersMap.values
          .map((m) => LatLng(m.latitude, m.longitude))
          .toList();
      if (latLngList.isNotEmpty) {
        controller.setCamera(await controller.cameraForCoordinateBounds(
            calculateBounds(latLngList),
            MbxEdgeInsets(top: 100, left: 50, bottom: 100, right: 50),
            bearing,
            pitch,
            cameraZoom,
            null));
      }
    });
  }

  CoordinateBounds calculateBounds(List<LatLng> markers) {
    var latitudes = markers.map((m) => m.latitude).toList();
    var longitudes = markers.map((m) => m.longitude).toList();

    double minLat = latitudes.reduce((a, b) => a < b ? a : b);
    double maxLat = latitudes.reduce((a, b) => a > b ? a : b);
    double minLng = longitudes.reduce((a, b) => a < b ? a : b);
    double maxLng = longitudes.reduce((a, b) => a > b ? a : b);

    return CoordinateBounds(
      southwest: Point(coordinates: Position(minLng, minLat)),
      northeast: Point(coordinates: Position(maxLng, maxLat)),
      infiniteBounds: false,
    );
  }

  void _populateCurrentLocationStream(BuildContext context) async {
    if (await PermissionHelper.hasLocationPermission && context.mounted) {
      _locationSubscription ??= context.location.locationStream?.listen(
        (position) =>
            _onLocationUpdate(LatLng(position.latitude, position.longitude)),
      );
    }
  }
}
