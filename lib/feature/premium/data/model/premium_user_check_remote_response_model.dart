class PremiumUserCheckRemoteResponseModel {
  PremiumUserCheckRemoteResponseModel({
    this.success,
    this.message,
    this.isPremium,
    this.premiumExpireAt,
  });

  PremiumUserCheckRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    isPremium = json['is_premium'];
    premiumExpireAt = json['premium_expire_at'];
  }

  bool? success;
  String? message;
  int? isPremium;
  String? premiumExpireAt;

  PremiumUserCheckRemoteResponseModel copyWith({
    bool? success,
    String? message,
    int? isPremium,
    String? premiumExpireAt,
  }) =>
      PremiumUserCheckRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        isPremium: isPremium ?? this.isPremium,
        premiumExpireAt: premiumExpireAt ?? this.premiumExpireAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['is_premium'] = isPremium;
    map['premium_expire_at'] = premiumExpireAt;
    return map;
  }
}
