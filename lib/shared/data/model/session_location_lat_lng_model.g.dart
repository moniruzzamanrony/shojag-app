// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_location_lat_lng_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionLocationLatLngModelAdapter
    extends TypeAdapter<SessionLocationLatLngModel> {
  @override
  final int typeId = 102;

  @override
  SessionLocationLatLngModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionLocationLatLngModel(
      latitude: fields[0] == null ? 0 : fields[0] as double,
      longitude: fields[1] == null ? 0 : fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SessionLocationLatLngModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionLocationLatLngModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
