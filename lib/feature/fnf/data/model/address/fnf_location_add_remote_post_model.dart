class FnfLocationAddRemotePostModel {
  final int fnfId;
  final int userId;
  final String label;
  final double latitude;
  final double longitude;

  const FnfLocationAddRemotePostModel({
    required this.fnfId,
    required this.userId,
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  factory FnfLocationAddRemotePostModel.fromMap(Map<String, dynamic> json) {
    return FnfLocationAddRemotePostModel(
      fnfId: json['friend_id'],
      userId: json['user_id'],
      label: json['label'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toMap() => {
        'friend_id': fnfId,
        'user_id': userId,
        'label': label,
        'latitude': latitude,
        'longitude': longitude,
      };
}
