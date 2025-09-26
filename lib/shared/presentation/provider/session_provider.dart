import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_clear_use_case.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_get_use_case.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_save_use_case.dart';
import 'package:logger/logger.dart';

import '../../../../core/config/provider/base_provider.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enums/gender.dart';
import '../../../../core/utils/helper/datetime_helper.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../../core/notification/firebase_notification_manager.dart';
import '../../../feature/profile/domain/entity/profile_update_entity.dart';
import '../../domain/entity/session_auth_entity.dart';
import '../../domain/usecase/remember_auth_info_clear_use_case.dart';
import '../../domain/usecase/remember_auth_info_get_use_case.dart';
import '../../domain/usecase/remember_auth_info_save_use_case.dart';
import '../../domain/usecase/session_clear_use_case.dart';
import '../../domain/usecase/session_get_use_case.dart';
import '../../domain/usecase/session_save_use_case.dart';

/// Provides session related information
/// throughout the app
class SessionProvider extends BaseProvider {
  SessionAuthEntity? _session;

  bool get isLoggedIn => _session?.isLoggedIn ?? false;

  User? get getUser => _session?.user;

  int get userId => getUser?.userId ?? 0;

  String get firstName => getUser?.firstName ?? '';

  String get lastName => getUser?.lastName ?? '';

  String get phone => getUser?.phone ?? '';

  String? get photo => getUser?.photo;

  String? get email => getUser?.email;

  UserType? get userType => getUser?.userType;

  String get apiToken => getUser?.apiToken ?? '';

  bool get isEmailVerified => getUser?.isEmailVerified ?? false;

  Future<void> saveSessionInfo({
    required bool loginStatus,
    required int userId,
    required String apiToken,
    required String firstName,
    required String lastName,
    required String phone,
    required bool isEmailVerified,
    required bool isPhoneVerified,
    String? email,
    String? gender,
    String? dob,
    String? nid,
    String? address,
    String? photo,
    // String? thana,
    String? policeId,
    String? hospitalOrAgency,
    String? fireStation,
    required int userType,
  }) async {
    final saveSessionUseCase = getIt<SessionSaveUseCase>();
    final param = SessionSaveParams(
        loginStatus: loginStatus,
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        dob: dob,
        address: address,
        gender: gender,
        nid: nid,
        photo: photo,
        userType: userType,
        // thana: thana,
        policeId: policeId,
        hospitalOrAgency: hospitalOrAgency,
        fireStation: fireStation,
        isPhoneVerified: isPhoneVerified,
        isEmailVerified: isEmailVerified,
        apiToken: apiToken);
    await saveSessionUseCase(param);
    _populateSession();
  }

  Future<void> updateProfilePicSession({required String profilePhoto}) async {
    final previousSession = _session;
    if (previousSession == null) {
      return;
    }
    final previousUser = previousSession.user;
    SessionSaveParams updatedParam = SessionSaveParams(
        loginStatus: previousSession.isLoggedIn,
        userId: previousUser.userId,
        apiToken: previousUser.apiToken,
        firstName: previousUser.firstName,
        lastName: previousUser.lastName,
        phone: previousUser.phone,
        email: previousUser.email,
        isEmailVerified: previousUser.isEmailVerified,
        isPhoneVerified: previousUser.isPhoneVerified,
        photo: profilePhoto,
        userType: previousUser.userType.id);

    switch (previousUser.userType) {
      case UserType.none:
        break;
      case UserType.citizen:
        final previousCitizen = previousUser as UserCitizen;
        updatedParam = updatedParam.copyWith(
            dob: previousCitizen.dob?.formatDate(pattern: pattern_YYYYMMdd),
            address: previousCitizen.address,
            gender: previousCitizen.gender.titleEn,
            nid: previousCitizen.nid);
        break;
      case UserType.police:
        final previousPolice = previousUser as UserPolice;
        updatedParam = updatedParam.copyWith(
             policeId: previousPolice.policeId,); // thana: previousPolice.thana
        break;
      case UserType.fireService:
        final updatedFireService = previousUser as UserFireService;
        updatedParam =
            updatedParam.copyWith(fireStation: updatedFireService.fireStation);
        break;
      case UserType.ambulance:
        final updateAmbulance = previousUser as UserAmbulance;
        updatedParam = updatedParam.copyWith(
            hospitalOrAgency: updateAmbulance.hospitalOrAgency);
        break;
    }
    final saveSessionUseCase = getIt<SessionSaveUseCase>();
    await saveSessionUseCase(updatedParam);
    _populateSession();
  }

  Future<void> updateProfileInfoSession(
      {required ProfileUpdateEntity entity}) async {
    final previousSession = _session;
    if (previousSession == null) {
      return;
    }
    final previousUser = previousSession.user;

    SessionSaveParams updatedParam = SessionSaveParams(
      loginStatus: previousSession.isLoggedIn,
      userType: previousUser.userType.id,
      photo: previousUser.photo,
      userId: previousUser.userId,
      phone: previousUser.phone,
      isEmailVerified: previousUser.isEmailVerified,
      isPhoneVerified: previousUser.isPhoneVerified,
      apiToken: previousUser.apiToken,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      // thana: entity.thana,
    );

    switch (previousUser.userType) {
      case UserType.none:
        break;
      case UserType.citizen:
        final previousCitizen = previousUser as UserCitizen;
        updatedParam = updatedParam.copyWith(
            dob:
                (getDateTimeFromString(date: entity.dob) ?? previousCitizen.dob)
                    ?.formatDate(pattern: pattern_YYYYMMdd),
            address: (entity.address) ?? previousCitizen.address,
            gender: (entity.gender == null
                        ? null
                        : Gender.fromTitle(entity.gender!))
                    ?.titleEn ??
                previousCitizen.gender.titleEn,
            nid: entity.nid ?? previousCitizen.nid);
        break;
      case UserType.police:
        final previousPolice = previousUser as UserPolice;
        updatedParam = updatedParam.copyWith(policeId: previousPolice.policeId);
        break;
      case UserType.fireService:
        final updatedFireService = previousUser as UserFireService;
        updatedParam = updatedParam.copyWith(
            fireStation: entity.fireStation ?? updatedFireService.fireStation);
        break;
      case UserType.ambulance:
        final updateAmbulance = previousUser as UserAmbulance;
        updatedParam = updatedParam.copyWith(
            hospitalOrAgency:
                entity.hospitalOrAgency ?? updateAmbulance.hospitalOrAgency);
        break;
    }

    final saveSessionUseCase = getIt<SessionSaveUseCase>();
    await saveSessionUseCase(updatedParam);
    _populateSession();
  }

  void _populateSession() {
    final getSessionInfoUseCase = getIt<SessionGetUseCase>();
    _session = getSessionInfoUseCase(NoParams())
        .fold((l) => null, (r) => _session = r);
  }

  Future<void> clearSessionInfo() async {
    final clearSessionInfoUseCase = getIt<SessionClearUseCase>();

    await clearSessionInfoUseCase(NoParams());
    _populateSession();
  }

  Future<void> saveRememberAuthInfo({required String phoneOrEmail}) async {
    final saveRememberAuthInfoUseCase = getIt<RememberAuthInfoSaveUseCase>();
    final param = RememberAuthInfoSaveParams(authInfo: phoneOrEmail);
    await saveRememberAuthInfoUseCase(param);
  }

  String? getRememberAuthInfo() {
    final getRememberAuthInfoUseCase = getIt<RememberAuthInfoGetUseCase>();
    return getRememberAuthInfoUseCase(NoParams()).fold((l) => null, (r) => r);
  }

  Future<void> clearRememberAuthInfo() async {
    final clearAuthInfoUseCase = getIt<RememberAuthInfoClearUseCase>();
    await clearAuthInfoUseCase(NoParams());
  }

  Future<void> deleteNotificationToken() async {
    try {
      return await FirebaseNotificationManager.instance.deleteToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> saveFcmToken(String fcmToken) async {
    final saveFcmTokenUseCase = getIt<FcmDeviceTokenSaveUseCase>();
    final param = FcmDeviceTokenSaveParams(fcmToken: fcmToken);
    await saveFcmTokenUseCase(param);
  }

  String? getFcmToken() {
    final getFcmTokenUseCase = getIt<FcmDeviceTokenGetUseCase>();
    return getFcmTokenUseCase(NoParams()).fold((l) => null, (r) => r);
  }

  Future<void> clearFcmToken() async {
    final clearFcmTokenUseCase = getIt<FcmDeviceTokenClearUseCase>();
    await clearFcmTokenUseCase(NoParams());
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  SessionProvider() {
    _populateSession();
  }
}
