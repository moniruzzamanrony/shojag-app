class DeviceTokenUpdateRemotePostModel {
  final int userId;
  final String deviceToken;

  DeviceTokenUpdateRemotePostModel({
    required this.userId,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'device_token': deviceToken,
    };
  }

  factory DeviceTokenUpdateRemotePostModel.fromMap(Map<String, dynamic> map) {
    return DeviceTokenUpdateRemotePostModel(
      userId: map['user_id'],
      deviceToken: map['device_token'],
    );
  }
}
