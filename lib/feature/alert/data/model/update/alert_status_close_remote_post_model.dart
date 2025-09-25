class AlertStatusCloseRemotePostModel {
  int userId;
  int alertId;

  AlertStatusCloseRemotePostModel({
    required this.userId,
    required this.alertId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'alert_id': alertId,
    };
  }

  factory AlertStatusCloseRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertStatusCloseRemotePostModel(
      userId: map['user_id'] as int,
      alertId: map['alert_id'] as int,
    );
  }
}
