class AlertResponseDeleteRemoteResponseModel {
  AlertResponseDeleteRemoteResponseModel({
    this.success,
    this.message,
  });

  AlertResponseDeleteRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  AlertResponseDeleteRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      AlertResponseDeleteRemoteResponseModel(
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
