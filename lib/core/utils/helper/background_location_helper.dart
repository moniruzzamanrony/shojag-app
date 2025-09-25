//This file [background_location_helper.dart] is used for background location helper functions
// It contains the following functions:
// 1. registerBackgroundLocator
// 2. backgroundLocatorCallback
// 3. getCurrentLocationLatLngInBackground
// 4. toggleBackgroundTracking
// 5. _stopBackgroundTracking
// 6. _startBackgroundTracking

import 'package:app/core/utils/helper/location_helper.dart';
import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:geolocator/geolocator.dart' as geo_loc;
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

Future<void> registerBackgroundLocator() async {
  await BackgroundLocationTrackerManager.initialize(
    backgroundLocatorCallback,
    config: const BackgroundLocationTrackerConfig(
      androidConfig: AndroidConfig(
        notificationIcon: "@mipmap/ic_launcher",
        notificationBody: "Shojag updating location in background",
        cancelTrackingActionText: 'Stop Tracking',
        channelName: 'Background Location Notification',
        distanceFilterMeters: 30,
        trackingInterval: Duration(seconds: 5),
      ),
      iOSConfig: IOSConfig(
        distanceFilterMeters: 30,
      ),
    ),
  );
}

@pragma('vm:entry-point')
void backgroundLocatorCallback() {
  BackgroundLocationTrackerManager.handleBackgroundUpdated(
    (data) async => _backgroundUpdater(data),
  );
}

Future<void> _backgroundUpdater(BackgroundLocationUpdateData data) async {
  Logger().d(data.toJson());
}

@pragma('vm:entry-point')
Future<LatLng?> getCurrentLocationLatLngInBackground() async {
  geo_loc.Position? locData;
  try {
    locData = await LocationHelper.getCurrentPosition(
        isBackground: true,
        timeLimit: const Duration(seconds: 10),
        forceLocationManager: true);
  } catch (e) {
    Logger().e(e);
    return Future.error(e);
  }
  if (locData == null) {
    return null;
  }

  return LatLng(locData.latitude, locData.longitude);
}

Future<void> toggleBackgroundTracking(bool enable) async {
  if (enable) {
    await _startBackgroundTracking();
  } else {
    await _stopBackgroundTracking();
  }
}

Future<void> _startBackgroundTracking() async {
  final hasAlwaysPermission =
      await PermissionHelper.hasAlwaysLocationPermission;

  if (!hasAlwaysPermission) {
    return;
  }

  final isTracking = await BackgroundLocationTrackerManager.isTracking();
  if (isTracking) {
    // already tracking in background
    return;
  }

  return await BackgroundLocationTrackerManager.startTracking();
}

Future<void> _stopBackgroundTracking() async {
  return await BackgroundLocationTrackerManager.stopTracking();
}
