import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/session_area_radius_model.dart';
import '../../data/model/session_auth_model.dart';
import '../../data/model/session_language_model.dart';
import '../../data/model/session_list_sort_type_model.dart';
import '../../data/model/session_location_lat_lng_model.dart';
import '../../data/model/session_notification_settings_model.dart';
import '../../data/service/common_remote_service.dart';
import '../../data/service/session_service.dart';

/// The CommonRepository is an abstract class that defines the interface for a common repository.
/// It contains methods for saving, getting, and clearing common session information.
/// The repository is responsible for storing and retrieving session information,
/// such as authentication, language, and location.
abstract class CommonRepository {
  /// The remoteService is an instance of the ICommonRemoteService interface,
  /// which is used to interact with the remote data source.
  /// The remote data source is responsible for fetching and saving data from the remote server.
  final ICommonRemoteService remoteService;

  /// The sessionService is an instance of the ISessionService interface,
  /// which is used to interact with the session data source.
  /// The session data source is responsible for storing and retrieving session information.
  final ISessionService sessionService;

  const CommonRepository({
    required this.remoteService,
    required this.sessionService,
  });

  /// [saveAuthSession] is responsible for saving the auth session,
  /// typically used when the user logs in or signs in.
  Future<Either<HiveFailure, void>> saveAuthSession(SessionAuthModel model);

  /// [getAuthSession] is responsible for getting the auth session,
  /// typically used when the user logs in or signs in.
  Either<HiveFailure, SessionAuthModel?> getAuthSession();

  /// [clearAuthSession] is responsible for clearing the auth session,
  /// typically used when the user logs out or signs out.
  Future<Either<HiveFailure, void>> clearAuthSession();

  /// [saveRememberAuthInfo] is responsible for saving the remember auth info,
  /// typically used when the user logs in or signs in.
  Future<Either<HiveFailure, void>> saveRememberAuthInfo(String authInfo);

  /// [getRememberAuthInfo] is responsible for getting the remember auth info,
  /// typically used when the user tried to logs in or signs in.
  Either<HiveFailure, String?> getRememberAuthInfo();

  /// [clearRememberAuthInfo] is responsible for clearing the remember auth info,
  /// typically used when the user choose to clear remember auth info.
  Future<Either<HiveFailure, void>> clearRememberAuthInfo();

  /// [saveDeviceFCMToken] is responsible for saving the device FCM token,
  /// typically used when the user logs in or signs in or device token is changed.
  Future<Either<HiveFailure, void>> saveDeviceFCMToken(String token);

  /// [getDeviceFCMToken] is responsible for getting the device FCM token,
  /// typically used when the user logs in or signs in.
  Either<HiveFailure, String?> getDeviceFCMToken();

  /// [clearDeviceFCMToken] is responsible for clearing the device FCM token,
  /// typically used when the user logs out or signs out.
  Future<Either<HiveFailure, void>> clearDeviceFCMToken();

  /// [saveLastLocation] is responsible for saving the user last location,
  Future<Either<HiveFailure, void>> saveLastLocation(
      SessionLocationLatLngModel location);

  /// [getLastLocation] is responsible for getting the user last location,
  Either<HiveFailure, SessionLocationLatLngModel?> getLastLocation();

  /// [clearLastLocation] is responsible for clearing the user last location,
  Future<Either<HiveFailure, void>> clearLastLocation();

  /// [saveNotificationSettings] is responsible for saving the user notification settings,
  Future<Either<HiveFailure, void>> saveNotificationSettings(
      SessionNotificationSettingsModel model);

  /// [getNotificationSettings] is responsible for getting the user notification settings,
  Either<HiveFailure, SessionNotificationSettingsModel>
      getNotificationSettings();

  /// [clearNotificationSettings] is responsible for clearing the user notification settings,
  Future<Either<HiveFailure, void>> clearNotificationSettings();

  /// [saveListSortType] is responsible for saving the user list sort type,
  Future<Either<HiveFailure, void>> saveListSortType(
      SessionListSortTypeModel model);

  /// [getListSortType] is responsible for getting the user list sort type,
  Either<HiveFailure, SessionListSortTypeModel> getListSortType();

  /// [clearListType] is responsible for clearing the user list sort type,
  Future<Either<HiveFailure, void>> clearListType();

  /// [saveRadius] is responsible for saving the user radius,
  Future<Either<HiveFailure, void>> saveRadius(SessionAreaRadiusModel model);

  /// [getRadius] is responsible for getting the user radius,
  Either<HiveFailure, SessionAreaRadiusModel> getRadius();

  /// [clearRadius] is responsible for clearing the user radius,
  Future<Either<HiveFailure, void>> clearRadius();

  /// [saveLanguage] is responsible for saving the user language,
  Future<Either<HiveFailure, void>> saveLanguage(SessionLanguageModel model);

  /// [getLanguage] is responsible for getting the user language,
  Either<HiveFailure, SessionLanguageModel> getLanguage();

  /// [clearLanguage] is responsible for clearing the user language,
  Future<Either<HiveFailure, void>> clearLanguage();

  /// [saveTooltipViewDate] is responsible for saving the user tooltip view date,
  Future<Either<HiveFailure, void>> saveTooltipViewDate(DateTime model);

  /// [getTooltipViewDate] is responsible for getting the user tooltip view date,
  Either<HiveFailure, DateTime> getTooltipViewDate();

  /// [clearTooltipViewDate] is responsible for clearing the user tooltip view date,
  Future<Either<HiveFailure, void>> clearTooltipViewDate();

  /// [saveAppTourViewStatus] is responsible for saving the user app tour view status,
  Future<Either<HiveFailure, void>> saveAppTourViewStatus(bool status);

  /// [getAppTourViewStatus] is responsible for getting the user app tour view status,
  Either<HiveFailure, bool> getAppTourViewStatus();

  /// [clearAppTourViewStatus] is responsible for clearing the user app tour view status,
  Future<Either<HiveFailure, void>> clearAppTourViewStatus();

  /// [saveLocationConsent] is responsible for saving the user location consent,
  Future<Either<HiveFailure, void>> saveLocationConsent(bool model);

  /// [getLocationConsent] is responsible for getting the user location consent,
  Either<HiveFailure, bool> getLocationConsent();

  /// [clearLocationConsent] is responsible for clearing the user location consent,
  Future<Either<HiveFailure, void>> clearLocationConsent();

  /// [saveBackgroundLocationPermission] is responsible for saving the user background location permission,
  Future<Either<HiveFailure, void>> saveBackgroundLocationPermission(
      bool permission);

  /// [getBackgroundLocationPermission] is responsible for getting the user background location permission,
  Either<HiveFailure, bool> getBackgroundLocationPermission();

  /// [clearBackgroundLocationPermission] is responsible for clearing the user background location permission,
  Future<Either<HiveFailure, void>> clearBackgroundLocationPermission();
}
