// This file defines the 'session_service.dart', which is part of the shared data service layer.
// The file includes necessary imports and sets up the groundwork for handling session-related data.
//
// The imports include various session models such as:
// - `session_area_radius_model.dart` for handling area radius related session data.
// - `session_language_model.dart` for managing session language settings.
// - `session_location_lat_lng_model.dart` for dealing with session location data.
// - `session_notification_settings_model.dart` for notification settings within the session context.
// - `session_premium_service_model.dart` for premium service-related session data.
//
// It also imports essential packages like:
// - `fpdart` for functional programming paradigms.
// - `hive` for local data storage capabilities.
//
// This file will likely contain classes or functions that interact with these models to perform
// operations such as saving, retrieving, or updating session information in a structured manner.

import 'package:app/core/utils/enums/sort_type.dart';
import 'package:app/shared/data/model/session_area_radius_model.dart';
import 'package:app/shared/data/model/session_language_model.dart';
import 'package:app/shared/data/model/session_location_lat_lng_model.dart';
import 'package:app/shared/data/model/session_notification_settings_model.dart';
import 'package:app/shared/data/model/session_premium_service_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_ce/hive.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../model/session_auth_model.dart';
import '../model/session_list_sort_type_model.dart';

abstract class ISessionService {
  /// [saveAuthSession] method is responsible for saving the authentication session information.
  /// It takes a [model] of type [SessionAuthModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveAuthSession(SessionAuthModel model);

  /// [getAuthSession] method is responsible for retrieving the authentication session information.
  /// It returns a [Either<HiveFailure, SessionAuthModel?>].
  Either<HiveFailure, SessionAuthModel?> getAuthSession();

  /// [clearAuthSession] method is responsible for clearing the authentication session information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearAuthSession();

  /// [saveRememberAuthInfo] method is responsible for saving the remember authentication information.
  /// It takes a [authInfo] of type [String] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveRememberAuthInfo(String authInfo);

  /// [getRememberAuthInfo] method is responsible for retrieving the remember authentication information.
  /// It returns a [Either<HiveFailure, String?>].
  Either<HiveFailure, String?> getRememberAuthInfo();

  /// [clearRememberAuthInfo] method is responsible for clearing the remember authentication information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearRememberAuthInfo();

  /// [saveDeviceFCMToken] method is responsible for saving the device FCM token.
  /// It takes a [token] of type [String] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveDeviceFCMToken(String token);

  /// [getDeviceFCMToken] method is responsible for retrieving the device FCM token.
  /// It returns a [Either<HiveFailure, String?>].
  Either<HiveFailure, String?> getDeviceFCMToken();

  /// [clearDeviceFCMToken] method is responsible for clearing the device FCM token.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearDeviceFCMToken();

  /// [saveLastLocation] method is responsible for saving the last location information.
  /// It takes a [location] of type [SessionLocationLatLngModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveLastLocation(
      SessionLocationLatLngModel location);

  /// [getLastLocation] method is responsible for retrieving the last location information.
  /// It returns a [Either<HiveFailure, SessionLocationLatLngModel?>].
  Either<HiveFailure, SessionLocationLatLngModel?> getLastLocation();

  /// [clearLastLocation] method is responsible for clearing the last location information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearLastLocation();

  /// [saveLanguage] method is responsible for saving the language information.
  /// It takes a [model] of type [SessionLanguageModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveLanguage(SessionLanguageModel model);

  /// [getLanguage] method is responsible for retrieving the language information.
  /// It returns a [Either<HiveFailure, SessionLanguageModel>].
  Either<HiveFailure, SessionLanguageModel> getLanguage();

  /// [clearLanguage] method is responsible for clearing the language information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearLanguage();

  /// [saveRadius] method is responsible for saving the radius information.
  /// It takes a [model] of type [SessionAreaRadiusModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveRadius(SessionAreaRadiusModel model);

  /// [getRadius] method is responsible for retrieving the radius information.
  /// It returns a [Either<HiveFailure, SessionAreaRadiusModel>].
  Either<HiveFailure, SessionAreaRadiusModel> getRadius();

  /// [clearRadius] method is responsible for clearing the radius information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearRadius();

  /// [saveNotificationSettings] method is responsible for saving the notification settings information.
  /// It takes a [model] of type [SessionNotificationSettingsModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveNotificationSettings(
      SessionNotificationSettingsModel model);

  /// [getNotificationSettings] method is responsible for retrieving the notification settings information.
  /// It returns a [Either<HiveFailure, SessionNotificationSettingsModel>].
  Either<HiveFailure, SessionNotificationSettingsModel>
      getNotificationSettings();

  /// [clearNotificationSettings] method is responsible for clearing the notification settings information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearNotificationSettings();

  /// [saveListType] method is responsible for saving the list type information.
  /// It takes a [model] of type [SessionListTypeModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveListSortType(
      SessionListSortTypeModel model);

  /// [getListSortType] method is responsible for retrieving the list type information.
  /// It returns a [Either<HiveFailure, SessionListSortTypeModel>].
  Either<HiveFailure, SessionListSortTypeModel> getListSortType();

  /// [clearListSortType] method is responsible for clearing the list type information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearListSortType();

  /// [saveTooltipViewDate] method is responsible for saving the tooltip view date information.
  /// It takes a [model] of type [DateTime] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveTooltipViewDate(DateTime model);

  /// [getTooltipViewDate] method is responsible for retrieving the tooltip view date information.
  /// It returns a [Either<HiveFailure, DateTime>].
  Either<HiveFailure, DateTime> getTooltipViewDate();

  /// [clearTooltipViewDate] method is responsible for clearing the tooltip view date information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearTooltipViewDate();

  /// [savePremiumInfo] method is responsible for saving the premium information.
  /// It takes a [model] of type [SessionPremiumServiceModel] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> savePremiumInfo(
      SessionPremiumServiceModel model);

  /// [getPremiumInfo] method is responsible for retrieving the premium information.
  /// It returns a [Either<HiveFailure, SessionPremiumServiceModel>].
  Either<HiveFailure, SessionPremiumServiceModel> getPremiumInfo();

  /// [clearPremiumInfo] method is responsible for clearing the premium information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearPremiumInfo();

  /// [savePremiumPopupViewDate] method is responsible for saving the premium popup view date information.
  /// It takes a [model] of type [DateTime] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> savePremiumPopupViewDate(DateTime model);

  /// [getPremiumPopupViewDate] method is responsible for retrieving the premium popup view date information.
  /// It returns a [Either<HiveFailure, DateTime>].
  Either<HiveFailure, DateTime> getPremiumPopupViewDate();

  /// [clearPremiumPopupViewDate] method is responsible for clearing the premium popup view date information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearPremiumPopupViewDate();

  /// [saveAppTourViewStatus] method is responsible for saving the app tour view status information.
  /// It takes a [status] of type [bool] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveAppTourViewStatus(bool status);

  /// [getAppTourViewStatus] method is responsible for retrieving the app tour view status information.
  /// It returns a [Either<HiveFailure, bool>].
  Either<HiveFailure, bool> getAppTourViewStatus();

  /// [clearAppTourViewStatus] method is responsible for clearing the app tour view status information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearAppTourViewStatus();

  /// [saveLocationConsent] method is responsible for saving the location consent information.
  /// It takes a [model] of type [bool] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveLocationConsent(bool model);

  /// [getLocationConsent] method is responsible for retrieving the location consent information.
  /// It returns a [Either<HiveFailure, bool>].
  Either<HiveFailure, bool> getLocationConsent();

  /// [clearLocationConsent] method is responsible for clearing the location consent information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearLocationConsent();

  /// [saveBackgroundLocationPermission] method is responsible for saving the background location permission information.
  /// It takes a [permission] of type [bool] as a parameter and returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> saveBackgroundLocationPermission(
      bool permission);

  /// [getBackgroundLocationPermission] method is responsible for retrieving the background location permission information.
  /// It returns a [Either<HiveFailure, bool>].
  Either<HiveFailure, bool> getBackgroundLocationPermission();

  /// [clearBackgroundLocationPermission] method is responsible for clearing the background location permission information.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> clearBackgroundLocationPermission();
}

/// [SessionKey] enum is responsible for storing the session key values.
///
enum SessionKey {
  auth('session_auth_key'),
  authInfo('session_auth_info_key'),
  deviceFCMToken('session_device_fcm_token_key'),
  lastLocation('session_last_location_key'),
  language('session_language_key'),
  radius('session_area_radius_key'),
  notificationSettings('session_notification_settings_key'),
  listSortType('session_list_type_key'),
  tooltipViewDate('session_tooltip_view_date_key'),
  premiumService('session_premium_service_key'),
  premiumPopupViewDate('session_premium_popup_view_date_key'),
  appTourViewStatus('session_app_tour_view_status_key'),
  locationConsent('session_location_permission_consent_key'),
  backgroundLocationPermission('session_background_location_permission_key');

  final String value;

  const SessionKey(this.value);
}

/// [SessionService] class is responsible for saving and retrieving session information.
/// It implements the [ISessionService] interface.
///
class SessionService extends ISessionService {
  final _box = Hive.box('${AppConstants.appName.toLowerCase()}_session');

  /// [_save] method is responsible for saving session information.
  /// It's a generic method that takes a [key] of type [SessionKey] and a [model] of type [T] as parameters.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> _save<T>(SessionKey key, T model) async {
    try {
      return Right(await _box.put(key.value, model));
    } on Exception catch (e) {
      return Left(HiveFailure(e.toString()));
    }
  }

  /// [_get] method is responsible for retrieving session information.
  /// It's a generic method that takes a [key] of type [SessionKey] and a [defaultValue] of type [T] as parameters.
  /// It returns a [Either<HiveFailure, T>].
  Either<HiveFailure, T> _get<T>(SessionKey key, T defaultValue) {
    try {
      return Right(_box.get(key.value, defaultValue: defaultValue));
    } on Exception catch (e) {
      return Left(HiveFailure(e.toString()));
    }
  }

  /// [_clear] method is responsible for clearing session information.
  /// It's a generic method that takes a [key] of type [SessionKey] as a parameter.
  /// It returns a [Future<Either<HiveFailure, void>>].
  Future<Either<HiveFailure, void>> _clear(SessionKey key) async {
    try {
      return Right(await _box.delete(key.value));
    } on Exception catch (e) {
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, void>> saveAuthSession(SessionAuthModel model) =>
      _save(SessionKey.auth, model);

  @override
  Either<HiveFailure, SessionAuthModel?> getAuthSession() =>
      _get<SessionAuthModel?>(SessionKey.auth, null);

  @override
  Future<Either<HiveFailure, void>> clearAuthSession() =>
      _clear(SessionKey.auth);

  @override
  Future<Either<HiveFailure, void>> saveRememberAuthInfo(String authInfo) =>
      _save(SessionKey.authInfo, authInfo);

  @override
  Either<HiveFailure, String?> getRememberAuthInfo() =>
      _get<String?>(SessionKey.authInfo, null);

  @override
  Future<Either<HiveFailure, void>> clearRememberAuthInfo() =>
      _clear(SessionKey.authInfo);

  @override
  Future<Either<HiveFailure, void>> saveDeviceFCMToken(String token) =>
      _save(SessionKey.deviceFCMToken, token);

  @override
  Either<HiveFailure, String?> getDeviceFCMToken() =>
      _get(SessionKey.deviceFCMToken, null);

  @override
  Future<Either<HiveFailure, void>> clearDeviceFCMToken() =>
      _clear(SessionKey.deviceFCMToken);

  @override
  Future<Either<HiveFailure, void>> saveLastLocation(
          SessionLocationLatLngModel location) =>
      _save(SessionKey.lastLocation, location);

  @override
  Either<HiveFailure, SessionLocationLatLngModel?> getLastLocation() => _get(
      SessionKey.lastLocation,
      SessionLocationLatLngModel.fromLatLng(AppConstants.dhakaLatLng));

  @override
  Future<Either<HiveFailure, void>> clearLastLocation() =>
      _clear(SessionKey.lastLocation);

  @override
  Future<Either<HiveFailure, void>> saveLanguage(SessionLanguageModel model) =>
      _save(SessionKey.language, model);

  @override
  Either<HiveFailure, SessionLanguageModel> getLanguage() =>
      _get(SessionKey.language, SessionLanguageModel.defaultLanguage());

  @override
  Future<Either<HiveFailure, void>> clearLanguage() =>
      _clear(SessionKey.language);

  @override
  Future<Either<HiveFailure, void>> saveRadius(SessionAreaRadiusModel model) =>
      _save(SessionKey.radius, model);

  @override
  Either<HiveFailure, SessionAreaRadiusModel> getRadius() => _get(
      SessionKey.radius,
      const SessionAreaRadiusModel(radius: AppConstants.maxAreaRadius));

  @override
  Future<Either<HiveFailure, void>> clearRadius() => _clear(SessionKey.radius);

  @override
  Future<Either<HiveFailure, void>> saveNotificationSettings(
          SessionNotificationSettingsModel model) =>
      _save(SessionKey.notificationSettings, model);

  @override
  Either<HiveFailure, SessionNotificationSettingsModel>
      getNotificationSettings() => _get(SessionKey.notificationSettings,
          const SessionNotificationSettingsModel(isOn: true));

  @override
  Future<Either<HiveFailure, void>> clearNotificationSettings() =>
      _clear(SessionKey.notificationSettings);

  @override
  Future<Either<HiveFailure, void>> saveListSortType(
          SessionListSortTypeModel model) =>
      _save(SessionKey.listSortType, model);

  @override
  Either<HiveFailure, SessionListSortTypeModel> getListSortType() => _get(
      SessionKey.listSortType,
      const SessionListSortTypeModel(type: SortType.distance));

  @override
  Future<Either<HiveFailure, void>> clearListSortType() =>
      _clear(SessionKey.listSortType);

  @override
  Future<Either<HiveFailure, void>> saveTooltipViewDate(DateTime model) =>
      _save(SessionKey.tooltipViewDate, model);

  @override
  Either<HiveFailure, DateTime> getTooltipViewDate() =>
      _get(SessionKey.tooltipViewDate, DateTime(1970));

  @override
  Future<Either<HiveFailure, void>> clearTooltipViewDate() =>
      _clear(SessionKey.tooltipViewDate);

  @override
  Future<Either<HiveFailure, void>> savePremiumInfo(
          SessionPremiumServiceModel model) =>
      _save(SessionKey.premiumService, model);

  @override
  Either<HiveFailure, SessionPremiumServiceModel> getPremiumInfo() =>
      _get(SessionKey.premiumService, SessionPremiumServiceModel.initial());

  @override
  Future<Either<HiveFailure, void>> clearPremiumInfo() =>
      _clear(SessionKey.premiumService);

  @override
  Future<Either<HiveFailure, void>> savePremiumPopupViewDate(DateTime model) =>
      _save(SessionKey.premiumPopupViewDate, model);

  @override
  Either<HiveFailure, DateTime> getPremiumPopupViewDate() =>
      _get(SessionKey.premiumPopupViewDate, DateTime(1970));

  @override
  Future<Either<HiveFailure, void>> clearPremiumPopupViewDate() =>
      _clear(SessionKey.premiumPopupViewDate);

  @override
  Future<Either<HiveFailure, void>> saveLocationConsent(bool model) =>
      _save(SessionKey.locationConsent, model);

  @override
  Either<HiveFailure, bool> getLocationConsent() =>
      _get(SessionKey.locationConsent, false);

  @override
  Future<Either<HiveFailure, void>> clearLocationConsent() =>
      _clear(SessionKey.locationConsent);

  @override
  Future<Either<HiveFailure, void>> saveBackgroundLocationPermission(
          bool permission) =>
      _save(SessionKey.backgroundLocationPermission, permission);

  @override
  Either<HiveFailure, bool> getBackgroundLocationPermission() =>
      _get(SessionKey.backgroundLocationPermission, false);

  @override
  Future<Either<HiveFailure, void>> clearBackgroundLocationPermission() =>
      _clear(SessionKey.backgroundLocationPermission);

  @override
  Future<Either<HiveFailure, void>> saveAppTourViewStatus(bool status) =>
      _save(SessionKey.appTourViewStatus, status);

  @override
  Either<HiveFailure, bool> getAppTourViewStatus() =>
      _get(SessionKey.appTourViewStatus, false);

  @override
  Future<Either<HiveFailure, void>> clearAppTourViewStatus() =>
      _clear(SessionKey.appTourViewStatus);
}
