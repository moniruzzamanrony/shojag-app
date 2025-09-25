// this file [work_manager_helper.dart] is for the work manager helper
// it is used to update the location in background
// headless task: update location in background when app is not running or killed

import 'dart:async';
import 'dart:ui';

import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:app/core/utils/helper/update_location_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:workmanager/workmanager.dart';

import '../../notification/local_notification_manager.dart';
import '../resource/dependency_injection.dart';
import 'background_location_helper.dart';

Future<void> initWorkManager() async {
  await Workmanager().initialize(workManagerCallback);
}

@pragma('vm:entry-point')
void workManagerCallback() {
  Workmanager().executeTask(
    (task, inputData) async {
      DartPluginRegistrant.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();

      try {
        switch (task) {
          case periodicTaskName:
            return _updateLocation();

          case oneOffTaskName:
            return _updateLocation();
          default:
            return Future.value(true);
        }
      } catch (e) {
        return Future.error(e);
      }
    },
  );
}

@pragma('vm:entry-point')
Future<bool> _updateLocation() async {
  const int id = 7777;
  try {
    // check has always permission for background location
    final hasAlwaysPermission =
        await PermissionHelper.hasAlwaysLocationPermission;
    if (!hasAlwaysPermission) {
      return Future.value(true);
    }

    // register dependencies and services
    await registerUpdateLocationRepositoryAndServices();

    // show background notification for user
    LocalNotificationManager.instance.showBackgroundNotification(
        id, 'Shojag Location Update', 'Location is updating in background');

    LatLng? location;
    try {
      location = await getCurrentLocationLatLngInBackground();
    } catch (_) {}

    if (location != null) {
      await updateLocation(location);
    }

  } finally {
    LocalNotificationManager.instance.cancelNotification(id);
  }
  return Future.value(true);
}

Future<void> togglePeriodicUpdateLocationWorker(bool enable) async {
  if (enable) {
    await _registerPeriodicUpdateLocationWorker();
  } else {
    await _cancelPeriodicUpdateLocationWorker();
  }
}

Future<void> _registerPeriodicUpdateLocationWorker() async {
  try {
    await Workmanager().registerPeriodicTask(
      periodicTaskUniqueName,
      periodicTaskName,
      initialDelay: const Duration(seconds: 60),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      constraints: Constraints(
          networkType: NetworkType.connected, requiresBatteryNotLow: true),
    );
  } catch (_) {}
}

Future<void> _cancelPeriodicUpdateLocationWorker() async {
  try {
    await Workmanager().cancelByUniqueName(periodicTaskUniqueName);
  } catch (_) {}
}

// Future<void> registerOneOffUpdateLocationWorker() async {
//   await Workmanager().registerOneOffTask(
//     oneOffTaskId,
//     oneOffTaskName,
//     existingWorkPolicy: ExistingWorkPolicy.replace,
//     constraints: Constraints(
//         networkType: NetworkType.connected, requiresBatteryNotLow: true),
//   );
// }

const String periodicTaskUniqueName = 'update_location_worker_task_id';
const String periodicTaskName = 'update_location_worker_task_name';
const String updateLocationWorkerTag = 'update_location_worker_tag';

const String oneOffTaskId = 'update_one_off_location_worker_task_id';
const String oneOffTaskName = 'update_one_off_location_worker_task_name';
