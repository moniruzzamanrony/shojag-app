class UserLocationUpdateRemotePostModel {
  int userId;
  double latitude;
  double longitude;

  UserLocationUpdateRemotePostModel({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory UserLocationUpdateRemotePostModel.fromMap(Map<String, dynamic> map) {
    return UserLocationUpdateRemotePostModel(
      userId: map['user_id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
