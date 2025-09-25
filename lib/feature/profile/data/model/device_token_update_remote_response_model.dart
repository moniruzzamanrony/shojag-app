class DeviceTokenUpdateRemoteResponseModel {
  DeviceTokenUpdateRemoteResponseModel({
    this.success,
    this.message,
  });

  DeviceTokenUpdateRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  DeviceTokenUpdateRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      DeviceTokenUpdateRemoteResponseModel(
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
