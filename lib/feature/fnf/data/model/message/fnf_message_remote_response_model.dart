class FnfMessageRemoteResponseModel {
  FnfMessageRemoteResponseModel({
    this.success,
    this.message,
  });

  FnfMessageRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  FnfMessageRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      FnfMessageRemoteResponseModel(
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
