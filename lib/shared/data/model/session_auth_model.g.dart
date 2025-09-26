// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAuthModelAdapter extends TypeAdapter<SessionAuthModel> {
  @override
  final typeId = 101;

  @override
  SessionAuthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionAuthModel(
      loginStatus: fields[0] == null ? false : fields[0] as bool,
      userId: fields[1] == null ? 0 : (fields[1] as num).toInt(),
      userType: fields[2] == null ? 0 : (fields[2] as num).toInt(),
      apiToken: fields[3] == null ? '' : fields[3] as String,
      firstName: fields[4] == null ? '' : fields[4] as String,
      lastName: fields[5] == null ? '' : fields[5] as String,
      phone: fields[7] == null ? '' : fields[7] as String,
      email: fields[6] as String?,
      gender: fields[8] as String?,
      dob: fields[9] as String?,
      nid: fields[10] as String?,
      address: fields[11] as String?,
      photo: fields[12] as String?,
      policeId: fields[13] as String?,
      thana: fields[14] as String?,
      fireStation: fields[15] as String?,
      hospitalOrAgency: fields[16] as String?,
      isEmailVerified: fields[17] == null ? false : fields[17] as bool,
      isPhoneVerified: fields[18] == null ? false : fields[18] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SessionAuthModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.loginStatus)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.userType)
      ..writeByte(3)
      ..write(obj.apiToken)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.dob)
      ..writeByte(10)
      ..write(obj.nid)
      ..writeByte(11)
      ..write(obj.address)
      ..writeByte(12)
      ..write(obj.photo)
      ..writeByte(13)
      ..write(obj.policeId)
      ..writeByte(14)
      ..write(obj.thana)
      ..writeByte(15)
      ..write(obj.fireStation)
      ..writeByte(16)
      ..write(obj.hospitalOrAgency)
      ..writeByte(17)
      ..write(obj.isEmailVerified)
      ..writeByte(18)
      ..write(obj.isPhoneVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAuthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
