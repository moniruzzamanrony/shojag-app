

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// [PermissionHelper] contains the helper function for permission
/// it handles app permissions for the following:
/// * [storagePermissionHandler]
/// * [microphonePermissionHandler]
/// * [backgroundLocationPermissionHandler]
///
/// more permissions can be added here
class PermissionHelper {
  static Future<bool> storagePermissionHandler() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        if (!((await Permission.photos.request()).isGranted)) {
          return false;
        }
        if (!((await Permission.audio.request()).isGranted)) {
          return false;
        }

        if (!((await Permission.videos.request()).isGranted)) {
          return false;
        }
      } else {
        if (!((await Permission.storage.request()).isGranted)) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      if (!await Permission.storage.request().isGranted) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> imagePermissionHandler() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        if (!((await Permission.photos.request()).isGranted)) {
          return false;
        }
        if (!((await Permission.audio.request()).isGranted)) {
          return false;
        }

        if (!((await Permission.videos.request()).isGranted)) {
          return false;
        }
      } else {
        if (!((await Permission.storage.request()).isGranted)) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      if (!await Permission.storage.request().isGranted) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> microphonePermissionHandler() async {
    if (!(await Permission.microphone.request().isGranted)) {
      return false;
    }
    if (Platform.isIOS) {
      if (!await Permission.speech.request().isGranted) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> notificationPermissionHandler(
      {bool request = false}) async {
    if (request) {
      return await Permission.notification.request().isGranted;
    }
    return await Permission.notification.isGranted;
  }

  static Future<bool> backgroundLocationPermissionHandler() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Permission.locationAlways.request().isGranted;
  }

  static Future<bool> hasWhenInUseLocationPermission(
      {bool requestIfNotGranted = false}) async {
    bool hasPermission = false;
    if (requestIfNotGranted) {
      final result = await Permission.locationWhenInUse.request();
      hasPermission = result.isGranted;
    } else {
      hasPermission = await Permission.locationWhenInUse.isGranted;
    }

    return hasPermission;
  }

  static Future<bool> get hasAlwaysLocationPermission async {
    return await Permission.locationAlways.isGranted;
  }

  @pragma('vm:entry-point')
  static Future<bool> get hasLocationPermission async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (_) {
      return false;
    }
  }

  @pragma('vm:entry-point')
  static Future<bool> get requestLocationPermission async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, grant permission manually');
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // @pragma('vm:entry-point')
  // static Future<bool> locationPermissionHandler() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always;
  // }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> openAppLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  static Future<bool> openSettings() async {
    return Geolocator.openAppSettings();
  }
}
