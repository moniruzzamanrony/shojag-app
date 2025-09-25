class SearchFnfRemoteResponseModel {
  SearchFnfRemoteResponseModel({
    this.success,
    this.status,
    this.message,
    this.userId,
    this.name,
    this.phone,
    this.profilePic,
  });

  SearchFnfRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
  }

  bool? success;
  num? status;
  String? message;
  num? userId;
  String? name;
  String? phone;
  String? profilePic;

  SearchFnfRemoteResponseModel copyWith({
    bool? success,
    num? status,
    String? message,
    num? userId,
    String? name,
    String? phone,
    String? profilePic,
  }) =>
      SearchFnfRemoteResponseModel(
        success: success ?? this.success,
        status: status ?? this.status,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        profilePic: profilePic ?? this.profilePic,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    map['user_id'] = userId;
    map['name'] = name;
    map['phone'] = phone;
    map['profile_pic'] = profilePic;
    return map;
  }
}
