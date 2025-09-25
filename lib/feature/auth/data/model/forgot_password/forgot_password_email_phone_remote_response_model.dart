class ForgotPasswordEmailPhoneRemoteResponseModel {
  ForgotPasswordEmailPhoneRemoteResponseModel({
    this.success,
    this.message,
    this.userId,
  });

  ForgotPasswordEmailPhoneRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    userId = json['user_id'];
  }

  bool? success;
  String? message;
  int? userId;

  ForgotPasswordEmailPhoneRemoteResponseModel copyWith({
    bool? success,
    String? message,
    String? token,
    int? userId,
  }) =>
      ForgotPasswordEmailPhoneRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['user_id'] = userId;
    return map;
  }
}
