// This file contains the widget for displaying the active alert map page.
// It includes functionalities to load alerts, display them on the map, and interact with alert items.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/location_helper.dart';
import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:app/feature/alert_map/presentation/widget/all_map_loading_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mbf show Size;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../shared/presentation/utils/annotation_click_listener.dart';
import '../../../alert/domain/entity/alert_entity.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../provider/alert_map_provider.dart';
import 'alert_map_card_single_item.dart';
import 'map_filter_widget.dart';

class AllActiveAlertViewMapWidget extends StatefulWidget {
  const AllActiveAlertViewMapWidget({super.key});

  @override
  State<AllActiveAlertViewMapWidget> createState() =>
      _AllActiveAlertViewMapWidgetState();
}

class _AllActiveAlertViewMapWidgetState
    extends State<AllActiveAlertViewMapWidget> {
  late final PageController _pageController;
  late Completer<MapboxMap> _mapController;
  late Completer<PointAnnotationManager> _markerManager;

  double bearing = 0.0;
  double pitch = 0.0;
  double cameraZoom = 14.4;
  late LatLng _mapCenter;

  double radiusInMeters = 0.0;
  List<AlertEntity> _activeAlertList = [];
  AlertEntity? _selectedAlert;

  int _currentIndex = 0;
  bool _isListLoading = false;
  bool _isMarkerProcessing = false;

  List<PointAnnotation> alertAnnotationsList = [];

  Uint8List? alertIcon;
  Uint8List? selectedAlertIcon;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _pageController = PageController();
    _mapController = Completer<MapboxMap>();
    _markerManager = Completer<PointAnnotationManager>();

    final mapProvider = context.read<AlertMapProvider>();
    _mapCenter = mapProvider.center;

    _hideScaleBar();
    _showMyLocation();
    _initControllers();
    _drawRadiusCircle();
    _fitCameraToBounds();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setRadius(num radius) {
    radiusInMeters = radius.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final currentRadius =
        context.select<SettingsProvider, num>((p) => p.radiusInMeter);

    if (radiusInMeters != currentRadius) {
      _setRadius(currentRadius);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadList(context).then((_) async {
          await _drawRadiusCircle();
          _fitCameraToBounds();
        });
      });
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        _mapSection(),
        _filterSection(context),
        _zoomController(context),
        _alertCardSection(),
        _refreshSection(context),
        const AllMapLoadingPopupWidget(),
      ],
    );
  }

  MapWidget _mapSection() {
    return MapWidget(
      onMapCreated: _onMapCreated,
      onCameraChangeListener: _onCameraChanged,
      key: const ValueKey('all_alert_view_mapbox_map'),
      onTapListener: (context) {
        if (_showCardNotifier.value) {
          _showCardNotifier.value = false;
        }
      },
      styleUri: AppConstants.mapboxStyleForFnf,
      cameraOptions: CameraOptions(
        zoom: cameraZoom,
        pitch: pitch,
        bearing: bearing,
        center: Point(
          coordinates: Position(_mapCenter.longitude, _mapCenter.latitude),
        ),
      ),
    );
  }

  Positioned _filterSection(BuildContext context) {
    return Positioned(
      top: 8.w,
      left: 8.w,
      right: 52.w,
      child: MapFilterWidget(
        onSelection: () {
          final mapProvider = context.read<AlertMapProvider>();
          _activeAlertList = mapProvider.alertsByCategories;
          _selectedAlert = _activeAlertList.firstOrNull;
          _currentIndex = 0;
          if (mounted) {
            setState(() {
              _loadAndPlaceMarkersAnnotation();
            });
          }
        },
      ),
    );
  }

  Positioned _zoomController(BuildContext context) {
    final buttonStyle = IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        backgroundColor: context.colorScheme.onPrimary,
        foregroundColor: context.colorScheme.primary,
        padding: EdgeInsets.all(4.r),
        elevation: 0.2,
        shadowColor: context.colorScheme.primary);

    return Positioned(
        right: 12.w,
        top: 8.w + 50.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
          child: Padding(
            padding: EdgeInsets.all(4.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12.h,
              children: [
                IconButton.filled(
                    onPressed: () async {
                      final controller = await _mapController.future;
                      final cameraState = await controller.getCameraState();
                      cameraState.zoom += 0.25;

                      controller.easeTo(cameraState.toCameraOptions(), null);
                    },
                    style: buttonStyle,
                    icon: Icon(
                      Icons.add,
                      size: Dimens.iconSize20,
                    )),
                IconButton.filled(
                    onPressed: () async {
                      final controller = await _mapController.future;
                      final cameraState = await controller.getCameraState();
                      cameraState.zoom -= 0.25;

                      controller.easeTo(cameraState.toCameraOptions(), null);
                    },
                    style: buttonStyle,
                    icon: Icon(Icons.remove, size: Dimens.iconSize20)),
              ],
            ),
          ),
        ));
  }

  final ValueNotifier<bool> _showCardNotifier = ValueNotifier<bool>(false);

  Positioned _alertCardSection() {
    return Positioned(
        bottom: 120.h,
        left: 0,
        right: 0,
        child: SizedBox(
            height: 132.h,
            width: double.infinity,
            child: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _showCardNotifier,
                  builder: (_, showCard, __) => AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: showCard ? Offset.zero : const Offset(1, 0),
                    child: PageView.builder(
                        controller: _pageController,
                        clipBehavior: Clip.none,
                        onPageChanged: (newIndex) {
                          final oldIndex = _currentIndex;
                          _selectedAlert = _activeAlertList[newIndex];
                          _currentIndex = newIndex;
                          _updateMarkersAnnotation(oldIndex, newIndex);
                        },
                        itemBuilder: (_, index) {
                          if (index < _activeAlertList.length) {
                            return AlertMapCardSingleItem(
                                item: _activeAlertList[index]);
                          }

                          return const SizedBox.shrink();
                        },
                        itemCount: _activeAlertList.length),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    top: 0,
                    right: Dimens.horizontalSpace + 8,
                    child: Center(
                      child: InkWell(
                          onTap: () {
                            _showCardNotifier.value = !_showCardNotifier.value;
                          },
                          child: ValueListenableBuilder(
                              valueListenable: _showCardNotifier,
                              builder: (_, showCard, __) => CircleAvatar(
                                    child: Icon(showCard
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ))),
                    ))
              ],
            )));
  }

  Positioned _refreshSection(BuildContext context) {
    return Positioned(
        right: 12.w,
        top: 8.w,
        child: SizedBox(
          height: 40.h,
          child: IconButton(
              style: IconButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.all(8.r),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const CircleBorder(),
                backgroundColor: AppColors.colorWhite,
              ),
              onPressed: () {
                _loadList(context).then((_) async {
                  await _drawRadiusCircle();
                  _flyToLocation(Point(
                      coordinates:
                          Position(_mapCenter.longitude, _mapCenter.latitude)));
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.repeat,
                color: context.colorScheme.primary,
                size: Dimens.iconSize18,
              )),
        ));
  }

  // load list from api
  Future<void> _loadList(BuildContext ctx) async {
    if (_isListLoading) return;
    _isListLoading = true;
    try {
      final alertMapProvider = ctx.read<AlertMapProvider>();
      await alertMapProvider.populateAllActiveAlertList(
          token: ctx.apiToken, userId: ctx.userId);
      final userAlerts = alertMapProvider.alertsByCategories;
      _mapCenter = alertMapProvider.center;
      _activeAlertList = userAlerts;

      _selectedAlert = _activeAlertList.firstOrNull;
      _currentIndex = 0;
      if (mounted) {
        _pageController.jumpToPage(_currentIndex);
      }
    } catch (e) {
      Logger().e(e);
    } finally {
      if (mounted) {
        setState(() {
          _isListLoading = false;
        });
        await _loadAndPlaceMarkersAnnotation();
      }
    }
  }

  // on map created
  void _onMapCreated(MapboxMap controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  // on camera changed
  void _onCameraChanged(CameraChangedEventData data) {
    bearing = data.cameraState.bearing;
    cameraZoom = data.cameraState.zoom;
    pitch = data.cameraState.pitch;
  }

  // hide scale bar
  void _hideScaleBar() {
    _mapController.future.then((controller) {
      controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    });
  }

  // show user location icon
  void _showMyLocation() {
    _mapController.future.then((controller) {
      PermissionHelper.hasLocationPermission
          .onError((error, stackTrace) => false)
          .then((hasPermission) {
        if (hasPermission) {
          controller.location.updateSettings(
              LocationComponentSettings(enabled: true, pulsingEnabled: true));
        }
      });
    });
  }

  // initialize point annotation manager
  void _initControllers() async {
    final controller = await _mapController.future;

    //point annotation manager
    final pointAnnotationManager =
        await controller.annotations.createPointAnnotationManager();

    pointAnnotationManager.addOnPointAnnotationClickListener(
        AnnotationClickListener(onAnnotationClick: _onPointAnnotationClick));

    _markerManager.complete(pointAnnotationManager);
  }

  // load marker icons
  Future<void> _loadMarkerIcons() async {
    try {
      alertIcon ??= (await rootBundle.load(Assets.alertLocationRedPng))
          .buffer
          .asUint8List();
    } catch (_) {}
    try {
      selectedAlertIcon ??=
          (await rootBundle.load(Assets.alertLocationGreenPng))
              .buffer
              .asUint8List();
    } catch (_) {}
  }

  // place markers
  Future<void> _placeMarkersAnnotation() async {
    final pointAnnotationManager = await _markerManager.future;

    await pointAnnotationManager.deleteAll();
    alertAnnotationsList.clear();

    for (var i = 0; i < _activeAlertList.length; i++) {
      final alert = _activeAlertList[i];
      final isSelected = alert == _selectedAlert;

      final annotationOption = PointAnnotationOptions(
          iconSize: isSelected ? 1.0 : 0.8,
          geometry: Point(
            coordinates: Position(alert.longitude, alert.latitude),
          ),
          image: isSelected ? selectedAlertIcon : alertIcon,
          iconAnchor: IconAnchor.BOTTOM,
          iconColor: Colors.black.value);

      final annotation = await pointAnnotationManager.create(annotationOption);

      alertAnnotationsList.add(annotation);
    }
  }

  // load and place markers
  Future<void> _loadAndPlaceMarkersAnnotation() async {
    if (!mounted) return;
    await _loadMarkerIcons();
    await _placeMarkersAnnotation();
  }

  // update markers
  Future<void> _updateMarkersAnnotation(int unselected, int selected) async {
    if (unselected < 0 ||
        unselected >= alertAnnotationsList.length ||
        selected < 0 ||
        selected >= alertAnnotationsList.length) {
      return;
    }

    if (!mounted) return;

    await _markerManager.future.then((pointAnnotationManager) async {
      try {
        final unselectedAnnotation = alertAnnotationsList[unselected];
        unselectedAnnotation.iconImage = null;
        unselectedAnnotation.image = alertIcon;
        unselectedAnnotation.iconSize = 0.8;
        await pointAnnotationManager.update(unselectedAnnotation);
      } catch (_) {}

      try {
        final selectedAnnotation = alertAnnotationsList[selected];
        selectedAnnotation.iconImage = null;
        selectedAnnotation.image = selectedAlertIcon;
        selectedAnnotation.iconSize = 1.0;
        await pointAnnotationManager.update(selectedAnnotation);
      } catch (_) {}
    });
  }

  // fit camera to bounds
  void _fitCameraToBounds() {
    _mapController.future.then((controller) async {
      final bounds =
          LocationHelper.calculateBoundsByRadius(_mapCenter, radiusInMeters);
      mbf.Size? mapSize;
      if (Platform.isAndroid) {
        mapSize = await controller.getSize();
      }
      final adjustedPadding = _getAdjustedPadding(mapSize);

      final cameraOptions = await controller.cameraForCoordinateBounds(
          bounds, adjustedPadding, bearing, pitch, cameraZoom, null);

      controller.flyTo(cameraOptions, MapAnimationOptions());
    });
  }

  /// Generates a GeoJSON object representing a circle as a polygon.
  Map<String, dynamic> _generateCircleGeoJson({
    required Point center,
    required double radiusInMeters,
    int steps = 64, // Number of points to generate around the circle
  }) {
    const double earthRadius = 6378137.0; // Earth's radius in meters
    final double centerLat = center.coordinates.lat * pi / 180;
    final double centerLng = center.coordinates.lng * pi / 180;

    final List<List<double>> coordinates = [];

    for (int i = 0; i <= steps; i++) {
      final double angle = (i * 2 * pi) / steps;
      final double latitude = math.asin(
        math.sin(centerLat) * math.cos(radiusInMeters / earthRadius) +
            math.cos(centerLat) *
                math.sin(radiusInMeters / earthRadius) *
                math.cos(angle),
      );
      final double longitude = centerLng +
          math.atan2(
            math.sin(angle) *
                math.sin(radiusInMeters / earthRadius) *
                math.cos(centerLat),
            math.cos(radiusInMeters / earthRadius) -
                math.sin(centerLat) * math.sin(latitude),
          );

      coordinates.add([
        longitude * 180 / pi,
        latitude * 180 / pi,
      ]);
    }

    return {
      "type": "Feature",
      "geometry": {
        "type": "Polygon",
        "coordinates": [coordinates],
      },
    };
  }

  // draw radius circle
  Future<void> _drawRadiusCircle() async {
    await _mapController.future.then((controller) async {
      // Define a GeoJSON source with a polygon representing the circle
      const String sourceId = "circle-polygon-source";
      const String layerId = "circle-polygon-layer";

      // Create the polygon for the circle
      final Map<String, dynamic> circleGeoJson = _generateCircleGeoJson(
        center: Point(
            coordinates: Position(_mapCenter.longitude, _mapCenter.latitude)),
        radiusInMeters: radiusInMeters, // Radius in meters
      );

      // remove if exist style layer
      if (await controller.style.styleLayerExists(layerId)) {
        await controller.style.removeStyleLayer(layerId);
      }

      // remove if exist style source
      if (await controller.style.styleSourceExists(sourceId)) {
        await controller.style.removeStyleSource(sourceId);
      }

      // Add the GeoJSON source
      await controller.style.addSource(GeoJsonSource(
        id: sourceId,
        data: jsonEncode(circleGeoJson),
      ));

      // Add the FillLayer to represent the circle
      await controller.style.addLayer(FillLayer(
        id: layerId,
        sourceId: sourceId,
        fillColor: AppColors.colorAppRed.value, // Red fill color
        fillOpacity: 0.3, // Semi-transparent
      ));
    });
  }

  // on point annotation click
  void _onPointAnnotationClick(PointAnnotation annotation) {
    if (_isMarkerProcessing) return;
    _isMarkerProcessing = true;
    final newIndex = alertAnnotationsList
        .indexWhere((element) => element.id == annotation.id);
    if (newIndex != -1) {
      _pageController.jumpToPage(newIndex);
    }

    Future.delayed(const Duration(milliseconds: 300), (() {
      _isMarkerProcessing = false;
      if (!_showCardNotifier.value) {
        _showCardNotifier.value = true;
      }
    }));
  }

  // fly to location
  void _flyToLocation(Point location) async {
    final controller = await _mapController.future;

    mbf.Size? mapSize;
    if (Platform.isAndroid) {
      mapSize = await controller.getSize();
    }

    await controller.flyTo(
      CameraOptions(
        center: location,
        zoom: cameraZoom,
        bearing: bearing,
        pitch: pitch,
        padding: _getAdjustedPadding(mapSize),
      ),
      MapAnimationOptions(duration: 1000),
    );
  }

  MbxEdgeInsets _getAdjustedPadding(mbf.Size? mapSize) {
    if (mapSize == null) {
      return MbxEdgeInsets(top: 10, left: 10, bottom: 210, right: 10);
    }
    return MbxEdgeInsets(
      top: math.min(10, mapSize.height / 2),
      left: math.min(10, mapSize.width / 2),
      bottom: math.min(210, mapSize.height / 2),
      right: math.min(10, mapSize.width / 2),
    );
  }
}
