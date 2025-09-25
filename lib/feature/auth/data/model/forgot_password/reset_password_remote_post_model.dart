class ResetPasswordRemotePostModel {
  int userId;
  String password;
  String token;

  ResetPasswordRemotePostModel({
    required this.userId,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'password': password,
      'token': token,
    };
  }

  factory ResetPasswordRemotePostModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordRemotePostModel(
      userId: map['user_id'] as int,
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }
}
