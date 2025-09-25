class UserAuthorizationRemoteResponseModel {
  UserAuthorizationRemoteResponseModel({
    this.message,
    this.userId,
    this.isPremium,
    this.premiumExpireAt,
    this.fcmToken,
    this.tokenExpire,
  });

  UserAuthorizationRemoteResponseModel.fromJson(dynamic json) {
    message = json['message'];
    userId = json['user_id'];
    isPremium = json['is_premium'];
    premiumExpireAt = json['premium_expire_at'];
    fcmToken = json['fcm_device_id'];
    tokenExpire = json['token_expire'];
  }

  String? message;
  num? userId;
  bool? isPremium;
  String? premiumExpireAt;
  String? fcmToken;
  bool? tokenExpire;

  UserAuthorizationRemoteResponseModel copyWith({
    String? message,
    num? userId,
    bool? isPremium,
    String? premiumExpireAt,
    String? fcmToken,
    bool? tokenExpire,
  }) =>
      UserAuthorizationRemoteResponseModel(
        message: message ?? this.message,
        userId: userId ?? this.userId,
        isPremium: isPremium ?? this.isPremium,
        premiumExpireAt: premiumExpireAt ?? this.premiumExpireAt,
        fcmToken: fcmToken ?? this.fcmToken,
        tokenExpire: tokenExpire ?? this.tokenExpire,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['user_id'] = userId;
    map['is_premium'] = isPremium;
    map['premium_expire_at'] = premiumExpireAt;
    map['fcm_device_id'] = fcmToken;
    map['token_expire'] = tokenExpire;
    return map;
  }
}
