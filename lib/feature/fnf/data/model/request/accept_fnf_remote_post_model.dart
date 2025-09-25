class AcceptFnfRemotePostModel {
  final int friendId;

  const AcceptFnfRemotePostModel({
    required this.friendId,
  });

  Map<String, dynamic> toMap() {
    return {
      'friend_id': friendId,
    };
  }

  factory AcceptFnfRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AcceptFnfRemotePostModel(
      friendId: map['friend_id'] as int,
    );
  }
}
