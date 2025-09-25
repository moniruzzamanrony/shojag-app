/* *
 * local notification manager
 * */

import 'dart:convert';

import 'package:app/core/notification/notification_channels.dart';
import 'package:app/core/notification/notification_manager.dart';
import 'package:app/core/utils/helper/permission_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:logger/logger.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

/// [LocalNotificationManager] class to handle local notification
/// It extends [NotificationManager] class
/// [showNotification] method to show local notification
/// [cancelNotification] method to cancel local notification
class LocalNotificationManager extends NotificationManager {
  static LocalNotificationManager instance = LocalNotificationManager._();

  LocalNotificationManager._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    for (AndroidNotificationChannel channel
        in NotificationChannelManager.channels) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      final payload = details.payload;
      if (payload == null || payload.isEmpty) return;
      final data = jsonDecode(payload);
      if (data is Map<String, dynamic>) {
        redirection(data);
      }
    });
  }

  /// [showNotification] method to show local notification
  void showNotification(int id, String title, String body,
      {String? payload, String? channelId}) async {
    final notificationPermissionGranted =
        await PermissionHelper.notificationPermissionHandler();

    if (!notificationPermissionGranted) return;

    AndroidNotificationChannel notification;
    if (channelId != null) {
      final alertChannel = NotificationChannelEnum.fromId(channelId);
      notification = NotificationChannelManager.getChannel(alertChannel);
    } else {
      notification = NotificationChannelManager.getChannel(
          NotificationChannelEnum.defaultChannel);
    }

    final androidNotificationDetails = AndroidNotificationDetails(
      notification.id,
      notification.name,
      channelDescription: notification.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      category: AndroidNotificationCategory.event,
    );
    final iOSNotificationDetails = const DarwinNotificationDetails(
        presentSound: true,
        presentBadge: true,
        presentBanner: true,
        sound: 'default');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: payload);
  }

  /// [showBackgroundNotification] method to show background notification
  Future<void> showBackgroundNotification(int id, String title, String body,
      {String? payload}) async {
    final backgroundChannel = NotificationChannelManager.getChannel(
        NotificationChannelEnum.backgroundSync);
    final androidNotificationDetails = AndroidNotificationDetails(
      backgroundChannel.id,
      backgroundChannel.name,
      channelDescription: backgroundChannel.description,
      category: AndroidNotificationCategory.locationSharing,
      icon: '@mipmap/ic_launcher',
      ongoing: false,
      autoCancel: false,
      playSound: false,
      enableVibration: false,
      when: DateTime.now().millisecondsSinceEpoch,
    );
    final iOSNotificationDetails = const DarwinNotificationDetails(
      presentSound: false,
      presentBadge: true,
      presentBanner: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
    try {
      await flutterLocalNotificationsPlugin
          .show(id, title, body, notificationDetails, payload: payload);
    } catch (e) {
      // Logger().d(e.toString());
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
    } catch (_) {}
  }
}
