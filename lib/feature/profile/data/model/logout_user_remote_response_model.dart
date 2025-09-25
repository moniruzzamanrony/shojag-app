class LogoutUserRemoteResponseModel {
  LogoutUserRemoteResponseModel({
    this.success,
    this.message,
  });

  LogoutUserRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  LogoutUserRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      LogoutUserRemoteResponseModel(
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
