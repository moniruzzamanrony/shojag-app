// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionLanguageModelAdapter extends TypeAdapter<SessionLanguageModel> {
  @override
  final typeId = 103;

  @override
  SessionLanguageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionLanguageModel(
      language: fields[0] == null ? 'en' : fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SessionLanguageModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionLanguageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
