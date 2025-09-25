class OtpVerifyRemoteResponseModel {
  OtpVerifyRemoteResponseModel({
    this.success,
    this.message,
    this.tempId,
    this.token,
  });

  OtpVerifyRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    tempId = json['temp_id'];
    token = json['token'];
  }

  bool? success;
  String? message;
  int? tempId;
  String? token;

  OtpVerifyRemoteResponseModel copyWith({
    bool? success,
    String? message,
    int? tempId,
    String? token,
  }) =>
      OtpVerifyRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        tempId: tempId ?? this.tempId,
        token: token ?? this.token,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['temp_id'] = tempId;
    map['token'] = token;
    return map;
  }
}
