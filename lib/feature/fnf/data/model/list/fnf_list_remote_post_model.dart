class FnfListRemotePostModel {
  final int userId;

  const FnfListRemotePostModel({required this.userId});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    return map;
  }

  factory FnfListRemotePostModel.fromMap(Map<String, dynamic> map) =>
      FnfListRemotePostModel(userId: map['user_id']);
}
