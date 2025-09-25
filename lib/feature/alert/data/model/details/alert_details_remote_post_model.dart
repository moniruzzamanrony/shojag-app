class AlertDetailsRemotePostModel {
  int alertId;
  int requestUserId;

  AlertDetailsRemotePostModel({
    required this.alertId,
    required this.requestUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'alert_id': alertId,
      'requested_user_id': requestUserId,
    };
  }

  factory AlertDetailsRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertDetailsRemotePostModel(
      alertId: map['alert_id'] as int,
      requestUserId: map['requested_user_id'] as int,
    );
  }
}
