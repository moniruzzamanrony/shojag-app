class FnfDetailsRemotePostModel {
  final int friendId;

  const FnfDetailsRemotePostModel({required this.friendId});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['friend_id'] = friendId;
    return map;
  }

  factory FnfDetailsRemotePostModel.fromMap(Map<String, dynamic> map) =>
      FnfDetailsRemotePostModel(friendId: map['friend_id']);
}
