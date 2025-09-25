class AlertUpdateRemoteResponseModel {
  final bool? success;
  final String? message;

  AlertUpdateRemoteResponseModel({
    this.success,
    this.message,
  });

  factory AlertUpdateRemoteResponseModel.fromJson(dynamic json) =>
      AlertUpdateRemoteResponseModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
