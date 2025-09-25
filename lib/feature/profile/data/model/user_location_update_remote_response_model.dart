class UserLocationUpdateRemoteResponseModel {
  UserLocationUpdateRemoteResponseModel({
    this.success,
    this.message,
  });

  UserLocationUpdateRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  UserLocationUpdateRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      UserLocationUpdateRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }
}
