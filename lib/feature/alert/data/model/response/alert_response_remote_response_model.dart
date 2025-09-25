class AlertResponseRemoteResponseModel {
  AlertResponseRemoteResponseModel({
    this.success,
    this.message,
  });

  AlertResponseRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  AlertResponseRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      AlertResponseRemoteResponseModel(
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
