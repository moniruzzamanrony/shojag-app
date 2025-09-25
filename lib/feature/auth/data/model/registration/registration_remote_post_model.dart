class RegistrationRemotePostModel {
  int tempId;
  String token;
  int typeId;
  String firstName;
  String lastName;
  String? email;
  String? gender;
  String password;
  int? thanaId;
  String? policeId;
  String? fireStation;
  String? hospitalOrAgency;
  double? latitude;
  double? longitude;
  String? deviceToken;

  RegistrationRemotePostModel({
    required this.tempId,
    required this.token,
    required this.typeId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.gender,
    required this.password,
    this.thanaId,
    this.policeId,
    this.fireStation,
    this.hospitalOrAgency,
    this.latitude,
    this.longitude,
    this.deviceToken,
  });

  Map<String, dynamic> toMap() => {
        'temp_id': tempId,
        'token': token,
        'type_id': typeId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'gender': gender,
        'password': password,
        'thana_id': thanaId,
        'police_id': policeId,
        'fire_station': fireStation,
        'hospital_agency': hospitalOrAgency,
        'latitude': latitude,
        'longitude': longitude,
        'device_token': deviceToken,
      };

  factory RegistrationRemotePostModel.fromMap(Map<String, dynamic> map) {
    return RegistrationRemotePostModel(
      tempId: map['temp_id'] as int,
      token: map['token'] as String,
      typeId: map['type_id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      password: map['password'] as String,
      thanaId: map['thana_id'] as int,
      policeId: map['police_id'] as String,
      fireStation: map['fire_station'] as String,
      hospitalOrAgency: map['hospital_agency'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      deviceToken: map['device_token'] as String,
    );
  }
}
