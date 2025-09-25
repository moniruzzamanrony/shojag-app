// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_area_radius_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAreaRadiusModelAdapter
    extends TypeAdapter<SessionAreaRadiusModel> {
  @override
  final int typeId = 105;

  @override
  SessionAreaRadiusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionAreaRadiusModel(
      radius: fields[0] == null ? 0 : fields[0] as num,
    );
  }

  @override
  void write(BinaryWriter writer, SessionAreaRadiusModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.radius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAreaRadiusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
