// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_premium_service_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionPremiumServiceModelAdapter
    extends TypeAdapter<SessionPremiumServiceModel> {
  @override
  final int typeId = 107;

  @override
  SessionPremiumServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionPremiumServiceModel(
      isPremium: fields[0] == null ? false : fields[0] as bool,
      expireDate: fields[1] as DateTime,
      currentPackage: fields[2] == null ? 'none' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SessionPremiumServiceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isPremium)
      ..writeByte(1)
      ..write(obj.expireDate)
      ..writeByte(2)
      ..write(obj.currentPackage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionPremiumServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
