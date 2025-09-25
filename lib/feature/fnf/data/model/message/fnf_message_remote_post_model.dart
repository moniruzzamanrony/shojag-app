class FnfMessageRemotePostModel {
  final int fnfId;
  final int userId;
  final String message;

  const FnfMessageRemotePostModel({
    required this.fnfId,
    required this.userId,
    required this.message,
  });

  factory FnfMessageRemotePostModel.fromMap(Map<String, dynamic> map) {
    return FnfMessageRemotePostModel(
      fnfId: map['friend_id'] as int,
      userId: map['user_id'] as int,
      message: map['message'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friend_id': fnfId,
      'user_id': userId,
      'message': message,
    };
  }
}
