class ProfileUpdateRemoteResponseModel {
  ProfileUpdateRemoteResponseModel({
    this.success,
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.nid,
    this.address,
    this.email,
    this.message,
    this.thana,
  });

  ProfileUpdateRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    gender = json['gender'];
    nid = json['nid'];
    address = json['address'];
    email = json['email'];
    thana = json['thana'];
    message = json['message'];
  }

  bool? success;
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  String? nid;
  String? address;
  String? email;
  String? message;
  String? thana;

  ProfileUpdateRemoteResponseModel copyWith({
    bool? success,
    String? firstName,
    String? lastName,
    String? dob,
    String? gender,
    String? nid,
    String? address,
    String? email,
    String? thana,
    String? message,
  }) =>
      ProfileUpdateRemoteResponseModel(
        success: success ?? this.success,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        nid: nid ?? this.nid,
        address: address ?? this.address,
        email: email ?? this.email,
        thana: thana ?? this.thana,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['dob'] = dob;
    map['gender'] = gender;
    map['nid'] = nid;
    map['address'] = address;
    map['email'] = email;
    map['thana'] = thana;
    map['message'] = message;
    return map;
  }
}
