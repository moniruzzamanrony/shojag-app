class AlertDeleteRemotePostModel {
  int userId;
  int alertId;

  AlertDeleteRemotePostModel({
    required this.userId,
    required this.alertId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'alert_id': alertId,
    };
  }

  factory AlertDeleteRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertDeleteRemotePostModel(
      userId: map['user_id'] as int,
      alertId: map['alert_id'] as int,
    );
  }
}
