class VerifyPhonePostModel {
  String phone;

  VerifyPhonePostModel({required this.phone});

  factory VerifyPhonePostModel.fromMap(Map<String, dynamic> map) {
    return VerifyPhonePostModel(phone: map['phone']);
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
    };
  }
}
