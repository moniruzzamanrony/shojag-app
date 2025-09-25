class LocationShareLimitRemotePostModel {
  final int fnfId;
  final String shareStatus;
  final String? timeLimit;

  const LocationShareLimitRemotePostModel({
    required this.fnfId,
    required this.shareStatus,
    this.timeLimit,
  });

  Map<String, dynamic> toMap() {
    return {
      'friend_id': fnfId,
      'share_status': shareStatus,
      'time_limit': timeLimit,
    };
  }

  factory LocationShareLimitRemotePostModel.fromMap(Map<String, dynamic> map) {
    return LocationShareLimitRemotePostModel(
      fnfId: map['friend_id'] as int,
      shareStatus: map['share_status'] as String,
      timeLimit: map['time_limit'] as String,
    );
  }
}
