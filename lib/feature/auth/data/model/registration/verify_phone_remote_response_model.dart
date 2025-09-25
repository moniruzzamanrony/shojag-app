class VerifyPhoneResponseModel {
  VerifyPhoneResponseModel({
    this.success,
    this.message,
    this.tempId,
  });

  VerifyPhoneResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    tempId = json['temp_id'];
  }

  bool? success;
  String? message;
  int? tempId;

  VerifyPhoneResponseModel copyWith({
    bool? success,
    String? message,
    int? tempId,
  }) =>
      VerifyPhoneResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        tempId: tempId ?? this.tempId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['temp_id'] = tempId;
    return map;
  }
}
