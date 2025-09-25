class FeedbackSendRemoteResponseModel {
  FeedbackSendRemoteResponseModel({
    this.success,
    this.message,
  });

  FeedbackSendRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  FeedbackSendRemoteResponseModel copyWith({
    bool? success,
    String? message,
  }) =>
      FeedbackSendRemoteResponseModel(
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
