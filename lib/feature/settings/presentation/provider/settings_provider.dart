import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/feature/settings/domain/usecase/area_limit_update_remote_use_case.dart';
import 'package:app/feature/settings/domain/usecase/delete_account_remote_use_case.dart';
import 'package:app/shared/domain/entity/language_entity.dart';
import 'package:app/shared/domain/usecase/notification_settings_get_use_case.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../../../shared/domain/usecase/language_get_use_case.dart';
import '../../../../shared/domain/usecase/language_save_use_case.dart';
import '../../../../shared/domain/usecase/notification_settings_save_use_case.dart';
import '../../../../shared/domain/usecase/radius_get_use_case.dart';
import '../../../../shared/domain/usecase/radius_save_use_case.dart';

class SettingsProvider extends BaseProvider {
  bool isNotificationOn = true;

  void populateNotifications() {
    final getNotificationsUseCase = getIt<NotificationSettingsGetUseCase>();
    final result = getNotificationsUseCase(NoParams());
    isNotificationOn = result.fold((l) => false, (r) => r);
  }

  Future<void> toggleNotification() async {
    final saveNotificationsUseCase = getIt<NotificationSettingsSaveUseCase>();
    final param = NotificationSettingsSaveParams(status: !isNotificationOn);
    await saveNotificationsUseCase(param);
    populateNotifications();
    notify();
  }

  num radiusInMeter = 0;

  void populateRadius() {
    final getRadiusUseCase = getIt<RadiusGetUseCase>();
    final result = getRadiusUseCase(NoParams());
    radiusInMeter = result.fold((l) => 0, (r) => r);
  }

  Future<void> saveRadius(num radius) async {
    final saveRadiusUseCase = getIt<RadiusSaveUseCase>();
    final param = RadiusSaveParams(radius: radius);
    await saveRadiusUseCase(param);
    populateRadius();
    notify();
  }

  LanguageEntity language = const LanguageEntity(
      locale: AppConstants.defaultLanguageLocale,
      name: AppConstants.defaultLanguageName);

  Locale get locale => Locale(language.locale);

  void populateLanguage() {
    final getLanguageUseCase = getIt<LanguageGetUseCase>();
    final result = getLanguageUseCase(NoParams());
    language = result.fold(
        (l) => const LanguageEntity(
            locale: AppConstants.defaultLanguageLocale,
            name: AppConstants.defaultLanguageName),
        (r) => LanguageEntity(locale: r.locale, name: r.name));
    timeago.setDefaultLocale(locale.languageCode);
  }

  Future<void> saveLanguage(String locale) async {
    final saveLanguageUseCase = getIt<LanguageSaveUseCase>();
    final param = LanguageSaveParams(language: locale);
    await saveLanguageUseCase(param);
    populateLanguage();
    notify();
  }

  bool isRadiusUpdating = false;

  Future<bool> updateAreaLimit(
      {required String token,
      required int userId,
      required num areaLimit}) async {
    final updateAreaLimitUseCase = getIt<AreaLimitUpdateRemoteUseCase>();
    final param = AreaLimitUpdateRemoteParam(
        token: token, userId: userId, areaLimit: areaLimit);
    isRadiusUpdating = true;
    notify();
    final response = await updateAreaLimitUseCase(param);
    isRadiusUpdating = false;
    notify();
    return response.fold((l) => false, (r) => r);
  }

  Future<bool> deleteAccount(
      {required String token,
      required int userId,
      required String password}) async {
    final deleteAccountUseCase = getIt<DeleteAccountRemoteUseCase>();
    final param = DeleteAccountRemoteParam(
        token: token, userId: userId, password: password);
    final response = await deleteAccountUseCase(param);
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    // TODO: implement resetAll
  }

  SettingsProvider() {
    populateNotifications();
    populateRadius();
    populateLanguage();
  }
}
