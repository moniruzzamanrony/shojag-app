// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_list_sort_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionListSortTypeModelAdapter
    extends TypeAdapter<SessionListSortTypeModel> {
  @override
  final int typeId = 106;

  @override
  SessionListSortTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionListSortTypeModel(
      type: fields[0] == null ? SortType.distance : fields[0] as SortType,
    );
  }

  @override
  void write(BinaryWriter writer, SessionListSortTypeModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionListSortTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
