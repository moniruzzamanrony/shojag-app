class RegistrationRemoteResponseModel {
  RegistrationRemoteResponseModel({
    this.success,
    this.message,
    this.token,
    this.user,
  });

  RegistrationRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  bool? success;
  String? message;
  String? token;
  User? user;

  RegistrationRemoteResponseModel copyWith({
    bool? success,
    String? message,
    String? token,
    User? user,
  }) =>
      RegistrationRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        token: token ?? this.token,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.id,
    this.typeId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profilePic,
    this.policeId,
    this.thana,
    this.fireStation,
    this.hospitalAgency,
    this.dob,
    this.gender,
    this.nid,
    this.address,
    this.areaLimit,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.premiumInfo,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    typeId = json['type_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
    policeId = json['police_id'];
    thana = json['thana'];
    fireStation = json['fire_station'];
    hospitalAgency = json['hospital_agency'];
    dob = json['dob'];
    gender = json['gender'];
    nid = json['nid'];
    address = json['address'];
    areaLimit = json['area_limit'];
    isEmailVerified = json['is_email_verified'];
    isPhoneVerified = json['is_phone_verified'];
    premiumInfo = json['premium_info'] != null
        ? PremiumInfo.fromJson(json['premium_info'])
        : null;
  }

  int? id;
  int? typeId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? profilePic;
  String? policeId;
  String? thana;
  String? fireStation;
  String? hospitalAgency;
  String? dob;
  String? gender;
  String? nid;
  String? address;
  num? areaLimit;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  PremiumInfo? premiumInfo;

  User copyWith({
    int? id,
    int? typeId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? profilePic,
    String? policeId,
    String? thana,
    String? fireStation,
    String? hospitalAgency,
    String? dob,
    String? gender,
    String? nid,
    String? address,
    num? areaLimit,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    PremiumInfo? premiumInfo,
  }) =>
      User(
        id: id ?? this.id,
        typeId: typeId ?? this.typeId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        profilePic: profilePic ?? this.profilePic,
        policeId: policeId ?? this.policeId,
        thana: thana ?? this.thana,
        fireStation: fireStation ?? this.fireStation,
        hospitalAgency: hospitalAgency ?? this.hospitalAgency,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        nid: nid ?? this.nid,
        address: address ?? this.address,
        areaLimit: areaLimit ?? this.areaLimit,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
        premiumInfo: premiumInfo ?? this.premiumInfo,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type_id'] = typeId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['profile_pic'] = profilePic;
    map['police_id'] = policeId;
    map['thana'] = thana;
    map['fire_station'] = fireStation;
    map['hospital_agency'] = hospitalAgency;
    map['dob'] = dob;
    map['gender'] = gender;
    map['nid'] = nid;
    map['address'] = address;
    map['area_limit'] = areaLimit;
    map['is_email_verified'] = isEmailVerified;
    map['is_phone_verified'] = isPhoneVerified;
    if (premiumInfo != null) {
      map['premium_info'] = premiumInfo?.toJson();
    }
    return map;
  }
}

class PremiumInfo {
  PremiumInfo({
    this.isPremium,
    this.premiumExpireAt,
  });

  PremiumInfo.fromJson(dynamic json) {
    isPremium = json['is_premium'];
    premiumExpireAt = json['premium_expire_at'];
  }

  int? isPremium;
  String? premiumExpireAt;

  PremiumInfo copyWith({
    int? isPremium,
    String? premiumExpireAt,
  }) =>
      PremiumInfo(
        isPremium: isPremium ?? this.isPremium,
        premiumExpireAt: premiumExpireAt ?? this.premiumExpireAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_premium'] = isPremium;
    map['premium_expire_at'] = premiumExpireAt;
    return map;
  }
}
