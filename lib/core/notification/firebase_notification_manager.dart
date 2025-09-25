import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app/core/notification/notification_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../firebase_options.dart';
import 'local_notification_manager.dart';

/// [FirebaseNotificationManager] class to handle firebase notification
/// It extends [NotificationManager] class
/// It initialize firebase and local notification
/// It handle notification permission,
/// handle notification click,
/// handle background and foreground message,
/// retrieve token and delete token
///
class FirebaseNotificationManager extends NotificationManager {
  FirebaseNotificationManager._();

  static final FirebaseNotificationManager instance =
      FirebaseNotificationManager._();

  factory FirebaseNotificationManager() => instance;

  static FirebaseMessaging? _messaging;

  Future<void> initialize() async {
    try {
      await LocalNotificationManager.instance.initialize();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      _messaging = FirebaseMessaging.instance;
      await _notificationPermission();
      await _initMessaging();
    } catch (_) {}
  }

  Future<String?> getToken() async {
    try {
      //only for ios; return null if apn token is null
      if (Platform.isIOS) {
        final apnsToken = await getApnsToken();
        if (apnsToken == null) return null;
      }
      return await _messaging?.getToken();
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteToken() async {
    try {
      return await _messaging?.deleteToken();
    } catch (_) {}
  }

  // for ios only
  Future<String?> getApnsToken() async {
    try {
      return await _messaging?.getAPNSToken();
    } catch (e) {
      return null;
    }
  }

  // ask user for notification permission
  Future<void> _notificationPermission() async {
    if (_messaging == null) return;

    await _messaging?.requestPermission(criticalAlert: true);
  }

  // initialize message
  Future<void> _initMessaging() async {
    if (_messaging == null) return;

    // set foreground notification channel
    await _messaging?.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // receive a notification
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen(_handleOnMessage);
    }

    // handle background message
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  Future<void> messageClick() async {
    _messaging?.getInitialMessage().then(handleMessageClick);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageClick);
  }

  /// handle background message
  /// when app in background or terminated
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {}

  /// onMessage Received in foreground
  Future<void> _handleOnMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification == null) return;
    final id = Random.secure().nextInt(100);

    String? channelId = message.notification?.android?.channelId;

    final payload = message.data.isEmpty ? null : jsonEncode(message.data);
    LocalNotificationManager.instance.showNotification(
        id, message.notification!.title ?? '', message.notification?.body ?? '',
        payload: payload, channelId: channelId);
  }

  // message click events
  Future<void> handleMessageClick(RemoteMessage? message) async {
    if (message == null) return;

    final data = message.data;
    if (data.isEmpty) return;
    redirection(data);
  }
}
