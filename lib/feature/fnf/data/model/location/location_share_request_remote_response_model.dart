class LocationShareRequestRemoteResponseModel {
  LocationShareRequestRemoteResponseModel({
    this.success,
    this.message,
  });

  LocationShareRequestRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  LocationShareRequestRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      LocationShareRequestRemoteResponseModel(
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
