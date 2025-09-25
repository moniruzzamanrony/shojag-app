class LocationShareLimitRemoteResponseModel {
  bool? success;
  String? message;

  LocationShareLimitRemoteResponseModel({
    this.success,
    this.message,
  });

  LocationShareLimitRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
