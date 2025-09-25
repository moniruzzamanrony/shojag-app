class AlertResponseDeleteRemotePostModel {
  int alertId;
  int responderId;

  AlertResponseDeleteRemotePostModel({
    required this.alertId,
    required this.responderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'alert_id': alertId,
      'responder_id': responderId,
    };
  }

  factory AlertResponseDeleteRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertResponseDeleteRemotePostModel(
        alertId: map['alert_id'] as int,
        responderId: map['responder_id'] as int);
  }
}
