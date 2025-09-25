class DashboardDataRemotePostModel {
  final int userId;
  final String sortBy;

  const DashboardDataRemotePostModel({
    required this.userId,
    required this.sortBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'sort_by': sortBy,
    };
  }

  factory DashboardDataRemotePostModel.fromMap(Map<String, dynamic> map) {
    return DashboardDataRemotePostModel(
      userId: map['user_id'] as int,
      sortBy: map['sort_by'] as String,
    );
  }
}
