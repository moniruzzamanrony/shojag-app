class ForgotPasswordOtpVerifyRemotePostModel {
  int userId;
  String otp;
  String phone;

  ForgotPasswordOtpVerifyRemotePostModel({
    required this.userId,
    required this.otp,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'otp': otp,
      'phone': phone,
    };
  }

  factory ForgotPasswordOtpVerifyRemotePostModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordOtpVerifyRemotePostModel(
      userId: map['user_id'] as int,
      otp: map['otp'] as String,
      phone: map['phone'] as String,
    );
  }
}
