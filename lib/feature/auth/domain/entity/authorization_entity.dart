import 'package:app/core/utils/extension/string_extension.dart';

import '../../data/model/user_authorization/user_authorization_remote_response_model.dart';

class AuthorizationEntity {
  final int userId;
  final bool? isPremium;
  final DateTime? premiumExpireAt;
  final bool isTokenExpired;
  final String? fcmToken;

  const AuthorizationEntity({
    required this.userId,
    this.isPremium,
    this.premiumExpireAt,
    required this.fcmToken,
    required this.isTokenExpired,
  });

  factory AuthorizationEntity.fromModel(
      UserAuthorizationRemoteResponseModel model) {
    return AuthorizationEntity(
      userId: model.userId?.toInt() ?? 0,
      isPremium: model.isPremium,
      premiumExpireAt: model.premiumExpireAt?.toDateTime,
      fcmToken: model.fcmToken,
      isTokenExpired: model.tokenExpire ?? false,
    );
  }
}
