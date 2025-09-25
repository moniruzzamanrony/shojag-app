class ForgotPasswordOtpVerifyRemoteResponseModel {
  ForgotPasswordOtpVerifyRemoteResponseModel({
    this.success,
    this.message,
    this.token,
    this.userId,
  });

  ForgotPasswordOtpVerifyRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userId = json['user_id'];
  }

  bool? success;
  String? message;
  String? token;
  int? userId;

  ForgotPasswordOtpVerifyRemoteResponseModel copyWith({
    bool? success,
    String? message,
    String? token,
    int? userId,
  }) =>
      ForgotPasswordOtpVerifyRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        token: token ?? this.token,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['token'] = token;
    map['user_id'] = userId;
    return map;
  }
}
