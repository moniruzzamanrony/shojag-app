class OtpVerifyRemotePostModel {
  String otp;
  int tempId;

  OtpVerifyRemotePostModel({required this.otp, required this.tempId});

  factory OtpVerifyRemotePostModel.fromMap(Map<String, dynamic> map) {
    return OtpVerifyRemotePostModel(otp: map['otp'], tempId: map['temp_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
      'temp_id': tempId,
    };
  }
}