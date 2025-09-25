import 'package:hive_ce/hive.dart';

import 'hive_types.dart';

part 'session_notification_settings_model.g.dart';

/// This class represents a model for storing notification settings.
/// It has a field `isOn` of type `bool`, which is used to indicate whether notifications are on or off.
///
/// The `SessionNotificationSettingsModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionNotificationTypeId)
class SessionNotificationSettingsModel {
  @HiveField(0, defaultValue: true)
  final bool isOn;

  const SessionNotificationSettingsModel({required this.isOn});
}
