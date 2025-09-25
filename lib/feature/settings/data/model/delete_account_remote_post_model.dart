class DeleteAccountRemotePostModel {
  final int userId;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'password': password,
    };
  }

  factory DeleteAccountRemotePostModel.fromMap(Map<String, dynamic> map) {
    return DeleteAccountRemotePostModel(
      userId: map['user_id'] as int,
      password: map['password'] as String,
    );
  }

  const DeleteAccountRemotePostModel(
      {required this.userId, required this.password});
}
