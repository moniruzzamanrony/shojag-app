import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// [NotificationChannelEnum] class to handle notification channels
enum NotificationChannelEnum {
  defaultChannel(
      'default_channel', 'Default Channel', 'This is default channel'),
  alert('alert', 'Alert Notification',
      'This channel is used for shojag alert notifications.'),
  backgroundSync('background_sync', 'Background Notification',
      'This channel is used for background running notifications.'),
  miscellaneousChannel('miscellaneous_channel', 'Miscellaneous Notification',
      'This channel is used for shojag miscellaneous notifications.');

  final String id;
  final String title;
  final String description;

  const NotificationChannelEnum(this.id, this.title, this.description);

  factory NotificationChannelEnum.fromId(String id) {
    return values.firstWhere((element) => element.id == id,
        orElse: () => defaultChannel);
  }
}

/// [NotificationChannelManager] class to handle notification channels
class NotificationChannelManager {
  static final Map<NotificationChannelEnum, AndroidNotificationChannel>
      _channelMap = {
    NotificationChannelEnum.defaultChannel: AndroidNotificationChannel(
      NotificationChannelEnum.defaultChannel.id, // id
      NotificationChannelEnum.defaultChannel.title, // title
      description:
          NotificationChannelEnum.defaultChannel.description, // description
    ),
    NotificationChannelEnum.alert: AndroidNotificationChannel(
      NotificationChannelEnum.alert.id, // id
      NotificationChannelEnum.alert.title, // title
      description: NotificationChannelEnum.alert.description, // description
      importance: Importance.high,
      //sound: const RawResourceAndroidNotificationSound('alert_sound'),
    ),
    NotificationChannelEnum.backgroundSync: AndroidNotificationChannel(
        NotificationChannelEnum.backgroundSync.id, // id
        NotificationChannelEnum.backgroundSync.title, // title
        description: NotificationChannelEnum.backgroundSync.description,
        // description
        playSound: false,
        enableVibration: false),
    NotificationChannelEnum.miscellaneousChannel: AndroidNotificationChannel(
      NotificationChannelEnum.miscellaneousChannel.id, // id
      NotificationChannelEnum.miscellaneousChannel.title, // title
      description: NotificationChannelEnum.miscellaneousChannel.description,
    )
  };

  Map<NotificationChannelEnum, AndroidNotificationChannel> get channelMap =>
      _channelMap;

  static List<AndroidNotificationChannel> get channels =>
      _channelMap.values.toList();

  static AndroidNotificationChannel getChannel(
      NotificationChannelEnum channel) {
    return _channelMap[channel] ??
        _channelMap[NotificationChannelEnum.defaultChannel]!;
  }
}
