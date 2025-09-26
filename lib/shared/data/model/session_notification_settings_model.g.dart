// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_notification_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionNotificationSettingsModelAdapter
    extends TypeAdapter<SessionNotificationSettingsModel> {
  @override
  final typeId = 104;

  @override
  SessionNotificationSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionNotificationSettingsModel(
      isOn: fields[0] == null ? true : fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SessionNotificationSettingsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionNotificationSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
