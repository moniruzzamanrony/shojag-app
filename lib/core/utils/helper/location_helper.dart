import 'dart:math' as math;

import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo_cod;
import 'package:geolocator/geolocator.dart' as geo_loc;
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

/// [LocationHelper] contains the helper function for location
/// It has the following functions:
/// * [isLocationServiceEnabled]
/// * [openLocationSettings]
/// * [getCurrentPosition]
/// * [getLastKnownLocation]
/// * [getLocationSettings]
/// * [getLocationStream]
/// * [getPlaceMarks]
/// * [getDistanceInMeter]
/// * [placeMarkToPlaceString]
/// * [calculateZoomByRadius]
/// * [calculateBoundsByList]
/// * [calculateBoundsByRadius]
///
class LocationHelper {
  static Future<bool> get isLocationServiceEnabled async {
    return await geo_loc.Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> openLocationSettings() async {
    return await geo_loc.Geolocator.openLocationSettings();
  }

  @pragma('vm:entry-point')
  static Future<geo_loc.Position?> getCurrentPosition(
      {bool isBackground = false,
      double? distanceFilter,
      Duration? timeLimit,
      Duration? interval,
      bool forceLocationManager = false}) async {
    bool locationPermissionGranted = false;
    try {
      locationPermissionGranted = await PermissionHelper.hasLocationPermission;
    } catch (e) {
      return null;
    }
    if (!locationPermissionGranted) {
      return null;
    }
    final settings = getLocationSettings(
        isBackground: isBackground,
        timeLimit: timeLimit,
        forceLocationManager: forceLocationManager,
        interval: interval,
        distanceFilter: distanceFilter);

    return await geo_loc.Geolocator.getCurrentPosition(
        locationSettings: settings);
  }

  /// Returns the last known location
  static Future<geo_loc.Position?> getLastKnownLocation() async {
    geo_loc.LocationPermission permission;

    permission = await geo_loc.Geolocator.checkPermission();
    if (permission == geo_loc.LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    if (permission == geo_loc.LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await geo_loc.Geolocator.getLastKnownPosition();
  }

  /// Returns the location settings
  static geo_loc.LocationSettings getLocationSettings(
      {double? distanceFilter,
      Duration? interval,
      Duration? timeLimit,
      required bool isBackground,
      required bool forceLocationManager}) {
    geo_loc.LocationSettings locationSettings;

    final distanceFilterInMeter = distanceFilter?.toInt() ?? 0;
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = geo_loc.AndroidSettings(
        distanceFilter: distanceFilterInMeter,
        intervalDuration: interval,
        timeLimit: timeLimit,
        forceLocationManager: forceLocationManager,
        foregroundNotificationConfig: isBackground
            ? const geo_loc.ForegroundNotificationConfig(
                notificationText: "Shojag using your location service",
                notificationTitle: "Shojag Running in Background",
                notificationChannelName: 'Location Channel',
                enableWakeLock: true,
                setOngoing: true,
                enableWifiLock: true,
              )
            : null,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = geo_loc.AppleSettings(
        accuracy: geo_loc.LocationAccuracy.high,
        distanceFilter: distanceFilterInMeter,
        timeLimit: timeLimit,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = geo_loc.LocationSettings(
        accuracy: geo_loc.LocationAccuracy.high,
        distanceFilter: distanceFilterInMeter,
        timeLimit: timeLimit,
      );
    }
    return locationSettings;
  }

  /// Returns the location stream
  static Stream<geo_loc.Position> getLocationStream(
      {double? customDistanceFilter,
      Duration? duration,
      required bool isBackground,
      bool forceLocationManager = false}) {
    try {
      return geo_loc.Geolocator.getPositionStream(
          locationSettings: getLocationSettings(
              distanceFilter: customDistanceFilter,
              interval: duration,
              forceLocationManager: forceLocationManager,
              isBackground: isBackground));
    } catch (e) {
      return Stream.error(e.toString());
    }
  }

  /// Returns the place marks
  static Future<List<geo_cod.Placemark>> getPlaceMarks(
      {required LatLng latLng}) async {
    try {
      final address = await geo_cod.placemarkFromCoordinates(
          latLng.latitude, latLng.longitude);
      return address;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// Returns the distance in meter
  static double getDistanceInMeter({required LatLng from, required LatLng to}) {
    return geo_loc.Geolocator.distanceBetween(
        from.latitude, from.longitude, to.latitude, to.longitude);
  }

  /// Convert the place marks to place string
  static String? placeMarkToPlaceString(geo_cod.Placemark placeMark) {
    final street = placeMark.street;
    final postalCode = placeMark.postalCode;
    final subLocality = placeMark.subLocality;
    final locality = placeMark.locality;
    final subAdministrativeArea = placeMark.subAdministrativeArea;
    final administrativeArea = placeMark.administrativeArea;
    final country = placeMark.country;

    StringBuffer selectedPlace = StringBuffer();

    if (street != null && street.isNotEmpty) {
      selectedPlace.write(street);
      selectedPlace.write(', ');
    }
    if (subLocality != null && subLocality.isNotEmpty) {
      selectedPlace.write(subLocality);
      selectedPlace.write(', ');
    }
    if (locality != null && locality.isNotEmpty) {
      selectedPlace.write(locality);
      selectedPlace.write(', ');
    }
    if (subAdministrativeArea != null && subAdministrativeArea.isNotEmpty) {
      selectedPlace.write(subAdministrativeArea);
      selectedPlace.write(', ');
    }
    if (administrativeArea != null && administrativeArea.isNotEmpty) {
      selectedPlace.write(administrativeArea);
      selectedPlace.write(', ');
    }
    if (postalCode != null && postalCode.isNotEmpty) {
      selectedPlace.write(postalCode);
      selectedPlace.write(', ');
    }
    if (country != null && country.isNotEmpty) {
      selectedPlace.write(country);
    }

    return selectedPlace.isNotEmpty ? selectedPlace.toString() : null;
  }

  /// Calculate the zoom by radius
  static double calculateZoomByRadius(double radiusInKm) {
    return (math.log(40075 / radiusInKm) / math.log(2)) - 8;
  }

  /// Calculate the bounds by points
  static CoordinateBounds calculateBoundsByList(List<LatLng> points) {
    var latitudes = points.map((m) => m.latitude).toList();
    var longitudes = points.map((m) => m.longitude).toList();

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

  /// Calculate the bounds by radius
  static CoordinateBounds calculateBoundsByRadius(
      LatLng center, double radiusInMeters) {
    const double earthRadius = 6378137.0; // Earth's radius in meters
    final double lat = center.latitude * pi / 180;
    final double lng = center.longitude * pi / 180;

    // Latitude bounds
    final double deltaLat = radiusInMeters / earthRadius;
    final double minLat = lat - deltaLat;
    final double maxLat = lat + deltaLat;

    // Longitude bounds (adjusting for latitude)
    final double deltaLng = radiusInMeters / (earthRadius * math.cos(lat));
    final double minLng = lng - deltaLng;
    final double maxLng = lng + deltaLng;

    // Convert back to degrees
    return CoordinateBounds(
      southwest:
          Point(coordinates: Position(minLng * 180 / pi, minLat * 180 / pi)),
      northeast:
          Point(coordinates: Position(maxLng * 180 / pi, maxLat * 180 / pi)),
      infiniteBounds: false,
    );
  }
}
