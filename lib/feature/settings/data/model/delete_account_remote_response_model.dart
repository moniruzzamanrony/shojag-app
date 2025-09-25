class DeleteAccountRemoteResponseModel {
  DeleteAccountRemoteResponseModel({
    this.success,
    this.message,
  });

  DeleteAccountRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  DeleteAccountRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      DeleteAccountRemoteResponseModel(
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
