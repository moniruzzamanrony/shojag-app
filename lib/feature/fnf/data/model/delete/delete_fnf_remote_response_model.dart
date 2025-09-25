class DeleteFnfRemoteResponseModel {
  DeleteFnfRemoteResponseModel({
    this.success,
    this.message,
  });

  DeleteFnfRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  DeleteFnfRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      DeleteFnfRemoteResponseModel(
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
