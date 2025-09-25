class FnfLocationDeleteRemoteResponseModel {
  final bool success;
  final String message;

  FnfLocationDeleteRemoteResponseModel({
    required this.success,
    required this.message,
  });

  factory FnfLocationDeleteRemoteResponseModel.fromJson(dynamic json) {
    return FnfLocationDeleteRemoteResponseModel(
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
