class AlertListRemotePostModel {
  final int userId;
  final int page;
  final String sortBy;

  const AlertListRemotePostModel({
    required this.userId,
    required this.page,
    required this.sortBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'page': page,
      'sort_by': sortBy,
    };
  }

  factory AlertListRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertListRemotePostModel(
      userId: map['user_id'] as int,
      page: map['page'] as int,
      sortBy: map['sort_by'] as String,
    );
  }
}
