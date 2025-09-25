//This class used for premium user remote post model

class PremiumUserCheckRemotePostModel {
  final int userId;

  const PremiumUserCheckRemotePostModel({required this.userId});

  Map<String, dynamic> toMap() {
    return {'user_id': userId};
  }

  factory PremiumUserCheckRemotePostModel.fromMap(Map<String, dynamic> map) {
    return PremiumUserCheckRemotePostModel(userId: map['user_id'] as int);
  }
}
