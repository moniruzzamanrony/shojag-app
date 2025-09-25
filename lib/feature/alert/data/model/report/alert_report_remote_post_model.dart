class AlertReportRemotePostModel {
  final int userId;
  final int alertId;
  final String comment;

  const AlertReportRemotePostModel(
      {required this.userId, required this.alertId, required this.comment});

  Map<String, dynamic> toMap() {
    return {'user_id': userId, 'alert_id': alertId, 'comment': comment};
  }

  factory AlertReportRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertReportRemotePostModel(
        userId: map['user_id'] as int,
        alertId: map['alert_id'] as int,
        comment: map['comment'] as String);
  }
}
