class FnfLocationAddRemoteResponseModel {
  final bool success;
  final String message;

  FnfLocationAddRemoteResponseModel({
    required this.success,
    required this.message,
  });

  factory FnfLocationAddRemoteResponseModel.fromJson(dynamic json) {
    return FnfLocationAddRemoteResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
