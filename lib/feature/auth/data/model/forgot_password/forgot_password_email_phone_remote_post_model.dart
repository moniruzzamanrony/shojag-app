class ForgotPasswordEmailPhoneRemotePostModel {
  String emailOrPhone;

  ForgotPasswordEmailPhoneRemotePostModel({
    required this.emailOrPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'emailOrphone': emailOrPhone,
    };
  }

  factory ForgotPasswordEmailPhoneRemotePostModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordEmailPhoneRemotePostModel(
      emailOrPhone: map['emailOrphone'] as String,
    );
  }
}
