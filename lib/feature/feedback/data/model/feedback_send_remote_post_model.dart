class FeedbackSendRemotePostModel {
  final int userId;
  final String review;

  const FeedbackSendRemotePostModel(
      {required this.userId, required this.review});

  Map<String, dynamic> toMap() {
    return {'user_id': userId, 'comment': review};
  }

  factory FeedbackSendRemotePostModel.fromMap(Map<String, dynamic> map) {
    return FeedbackSendRemotePostModel(
        userId: map['user_id'] as int, review: map['comment'] as String);
  }
}
