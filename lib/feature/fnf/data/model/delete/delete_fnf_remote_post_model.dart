class DeleteFnfRemotePostModel {
  final int userId;
  final int friendId;

  const DeleteFnfRemotePostModel({
    required this.userId,
    required this.friendId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'friend_id': friendId,
    };
  }

  factory DeleteFnfRemotePostModel.fromMap(Map<String, dynamic> map) {
    return DeleteFnfRemotePostModel(
      userId: map['user_id'] as int,
      friendId: map['friend_id'] as int,
    );
  }
}
