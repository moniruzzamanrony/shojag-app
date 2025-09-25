class LoginRemotePostModel {
  String emailOrPhone;
  String password;

  LoginRemotePostModel({
    required this.emailOrPhone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'emailOrphone': emailOrPhone,
      'password': password,
    };
  }

  factory LoginRemotePostModel.fromMap(Map<String, dynamic> map) {
    return LoginRemotePostModel(
      emailOrPhone: map['emailOrphone'] as String,
      password: map['password'] as String,
    );
  }
}
