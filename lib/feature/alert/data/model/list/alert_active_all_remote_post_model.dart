class AlertActiveAllRemotePostModel {
  int userId;

  AlertActiveAllRemotePostModel({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {'user_id': userId};
  }

  factory AlertActiveAllRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertActiveAllRemotePostModel(userId: map['user_id'] as int);
  }
}
