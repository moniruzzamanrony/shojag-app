//
// dependency_injection.dart
// the file for dependency injection (get it)
// it contains all the dependency that are need to initialize before app start
//
//

import 'dart:io';

import 'package:app/core/error/error_reporing.dart';
import 'package:app/core/notification/firebase_notification_manager.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/core/utils/helper/timeago_helper.dart';
import 'package:app/core/utils/helper/work_manager_helper.dart';
import 'package:app/feature/alert/data/repository/alert_repository_impl.dart';
import 'package:app/feature/alert/data/service/alert_local_service.dart';
import 'package:app/feature/alert/data/service/alert_remote_service.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:app/feature/auth/data/service/auth_remote_service.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:app/feature/auth/domain/usecase/verify_phone_use_case.dart';
import 'package:app/feature/feedback/data/repository/feedback_repository_impl.dart';
import 'package:app/feature/feedback/data/service/feedback_remote_service.dart';
import 'package:app/feature/feedback/domain/repository/feedback_repository.dart';
import 'package:app/feature/feedback/domain/usecase/send_user_review_use_case.dart';
import 'package:app/feature/fnf/domain/usecase/add_fnf_address_use_case.dart';
import 'package:app/feature/fnf/domain/usecase/delete_fnf_address_use_case.dart';
import 'package:app/feature/premium/data/repository/premium_repository_impl.dart';
import 'package:app/feature/premium/data/source/premium_remote_service.dart';
import 'package:app/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:app/feature/profile/data/service/profile_remote_service.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:app/feature/settings/data/repository/settings_repository_impl.dart';
import 'package:app/feature/settings/data/service/settings_remote_service.dart';
import 'package:app/feature/settings/domain/repository/settings_repository.dart';
import 'package:app/feature/settings/domain/usecase/area_limit_update_remote_use_case.dart';
import 'package:app/shared/data/model/session_area_radius_model.dart';
import 'package:app/shared/data/model/session_language_model.dart';
import 'package:app/shared/data/model/session_list_sort_type_model.dart';
import 'package:app/shared/data/model/session_notification_settings_model.dart';
import 'package:app/shared/data/model/session_premium_service_model.dart';
import 'package:app/shared/data/repository/common_repository_impl.dart';
import 'package:app/shared/domain/repository/common_repository.dart';
import 'package:app/shared/domain/usecase/app_tour_view_status_clear_use_case.dart';
import 'package:app/shared/domain/usecase/app_tour_view_status_get_use_case.dart';
import 'package:app/shared/domain/usecase/app_tour_view_status_save_use_case.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_clear_use_case.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_get_use_case.dart';
import 'package:app/shared/domain/usecase/fcm_device_token_save_use_case.dart';
import 'package:app/shared/domain/usecase/list_sort_type_clear_use_case.dart';
import 'package:app/shared/domain/usecase/session_clear_use_case.dart';
import 'package:app/shared/domain/usecase/session_get_use_case.dart';
import 'package:app/shared/domain/usecase/session_save_use_case.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../feature/alert/domain/usecase/alert_add_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_delete_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_detail_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_get_active_all_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_get_active_list_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_get_closed_list_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_get_my_list_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_get_reponded_list_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_response_delete_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_response_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_status_close_remote_use_case.dart';
import '../../../feature/alert/domain/usecase/alert_update_use_case.dart';
import '../../../feature/alert/domain/usecase/incident_fetch_remote_list_use_case.dart';
import '../../../feature/alert/domain/usecase/incident_get_local_list_use_case.dart';
import '../../../feature/alert/domain/usecase/report_alert_use_case.dart';
import '../../../feature/auth/domain/usecase/authorize_user_use_case.dart';
import '../../../feature/auth/domain/usecase/forgot_password_otp_verify_use_case.dart';
import '../../../feature/auth/domain/usecase/forgot_password_send_otp_use_case.dart';
import '../../../feature/auth/domain/usecase/get_thana_list_use_case.dart';
import '../../../feature/auth/domain/usecase/login_use_case.dart';
import '../../../feature/auth/domain/usecase/registration_use_case.dart';
import '../../../feature/auth/domain/usecase/reset_password_use_case.dart';
import '../../../feature/auth/domain/usecase/verify_otp_use_case.dart';
import '../../../feature/dashboard/data/repository/dashboard_repository_impl.dart';
import '../../../feature/dashboard/data/service/dashboard_remote_service.dart';
import '../../../feature/dashboard/domain/repository/dashboard_repository.dart';
import '../../../feature/dashboard/domain/usecase/get_dashboard_data_use_case.dart';
import '../../../feature/fnf/data/repository/fnf_repository_impl.dart';
import '../../../feature/fnf/data/service/fnf_remote_service.dart';
import '../../../feature/fnf/domain/usecase/accept_request_use_case.dart';
import '../../../feature/fnf/domain/usecase/delete_fnf_use_case.dart';
import '../../../feature/fnf/domain/usecase/get_fnf_details_use_case.dart';
import '../../../feature/fnf/domain/usecase/get_fnf_list_use_case.dart';
import '../../../feature/fnf/domain/usecase/location_share_limit_use_case.dart';
import '../../../feature/fnf/domain/usecase/location_share_request_use_case.dart';
import '../../../feature/fnf/domain/usecase/search_fnf_use_case.dart';
import '../../../feature/fnf/domain/usecase/send_fnf_request_use_case.dart';
import '../../../feature/fnf/domain/usecase/update_fnf_message_use_case.dart';
import '../../../feature/premium/domain/usecse/premium_service_check_use_case.dart';
import '../../../feature/premium/domain/usecse/premium_service_clear_use_case.dart';
import '../../../feature/premium/domain/usecse/premium_service_get_use_case.dart';
import '../../../feature/premium/domain/usecse/premium_service_save_use_case.dart';
import '../../../feature/profile/domain/usecase/device_token_remote_update_use_case.dart';
import '../../../feature/profile/domain/usecase/logout_user_use_case.dart';
import '../../../feature/profile/domain/usecase/profile_pic_update_use_case.dart';
import '../../../feature/profile/domain/usecase/profile_update_use_case.dart';
import '../../../feature/profile/domain/usecase/user_location_update_use_case.dart';
import '../../../feature/settings/domain/usecase/delete_account_remote_use_case.dart';
import '../../../feature/settings/domain/usecase/update_password_remote_use_case.dart';
import '../../../shared/data/model/hive_types.dart';
import '../../../shared/data/model/session_auth_model.dart';
import '../../../shared/data/model/session_location_lat_lng_model.dart';
import '../../../shared/data/service/common_remote_service.dart';
import '../../../shared/data/service/session_service.dart';
import '../../../shared/domain/usecase/background_location_permission_clear_use_case.dart';
import '../../../shared/domain/usecase/background_location_permission_get_use_case.dart';
import '../../../shared/domain/usecase/background_location_permission_save_use_case.dart';
import '../../../shared/domain/usecase/language_clear_use_case.dart';
import '../../../shared/domain/usecase/language_get_use_case.dart';
import '../../../shared/domain/usecase/language_save_use_case.dart';
import '../../../shared/domain/usecase/last_location_clear_use_case.dart';
import '../../../shared/domain/usecase/last_location_get_use_case.dart';
import '../../../shared/domain/usecase/last_location_save_use_case.dart';
import '../../../shared/domain/usecase/list_sort_type_get_use_case.dart';
import '../../../shared/domain/usecase/list_sort_type_save_use_case.dart';
import '../../../shared/domain/usecase/location_consent_clear_use_case.dart';
import '../../../shared/domain/usecase/location_consent_get_use_case.dart';
import '../../../shared/domain/usecase/location_consent_save_use_case.dart';
import '../../../shared/domain/usecase/notification_settings_clear_use_case.dart';
import '../../../shared/domain/usecase/notification_settings_get_use_case.dart';
import '../../../shared/domain/usecase/notification_settings_save_use_case.dart';
import '../../../shared/domain/usecase/premium_popup_view_date_clear_use_case.dart';
import '../../../shared/domain/usecase/premium_popup_view_date_get_use_case.dart';
import '../../../shared/domain/usecase/premium_popup_view_date_save_use_case.dart';
import '../../../shared/domain/usecase/radius_clear_use_case.dart';
import '../../../shared/domain/usecase/radius_get_use_case.dart';
import '../../../shared/domain/usecase/radius_save_use_case.dart';
import '../../../shared/domain/usecase/remember_auth_info_clear_use_case.dart';
import '../../../shared/domain/usecase/remember_auth_info_get_use_case.dart';
import '../../../shared/domain/usecase/remember_auth_info_save_use_case.dart';
import '../../../shared/domain/usecase/tooltip_view_date_clear_use_case.dart';
import '../../../shared/domain/usecase/tooltip_view_date_get_use_case.dart';
import '../../../shared/domain/usecase/tooltip_view_date_save_use_case.dart';
import '../../database/app_database.dart';
import '../../network/base_api_service.dart';
import '../constants/app_constants.dart';
import '../constants/assets.dart';
import '../helper/background_location_helper.dart';
import '../helper/isolation_helper.dart';

final getIt = GetIt.instance;

/// This function will be called from main.dart
/// this should called before [runApp] function
Future<void> setup() async {
  await Future.wait([
    _deviceOrientation(),
    _registerHive(),
    _initNotification(),
    _initBackgroundLocator(),
    _initDirectory(),
    _initMapbox(),
    _svgLoader(),
  ]);
  registeredRepositoryAndServices();
  await _initLocationUpdateOnBackground();

  _initErrorReporting();
  _initTimeAgoLocale();
}

Future<void> _initBackgroundLocator() async {
  await registerBackgroundLocator();
}

Future<void> _initLocationUpdateOnBackground() async {
  await initWorkManager();
  final hasBackgroundPermission =
      getIt<BackgroundLocationPermissionGetUseCase>()
          .call(NoParams())
          .fold((l) => false, (r) => r);
  await togglePeriodicUpdateLocationWorker(hasBackgroundPermission);
  registerLocationIsolate();
}

Future<void> _initMapbox() async {
  String accessToken =
      const String.fromEnvironment(AppConstants.mapboxAccessTokenEnvKey);
  MapboxOptions.setAccessToken(accessToken);
}

void _initTimeAgoLocale() {
  timeago.setLocaleMessages('bn', CustomTimeAgoBn());
  timeago.setLocaleMessages('en', CustomTimeAgoEn());
}

void _initErrorReporting() {
  ErrorReporting.handleCrashAndErrorReports();
}

Future<void> _svgLoader() async {
  const loader = SvgAssetLoader(Assets.backgroundButtonBackgroundRed);
  await svg.cache.putIfAbsent(
      loader.cacheKey(null), () async => await loader.loadBytes(null));
}

String appDirectoryPath = '';

Future<void> _initDirectory() async {
  final directory = await getApplicationSupportDirectory();
  appDirectoryPath = directory.path;
}

Future<void> _deviceOrientation() async {
  if (Platform.isIOS) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
  }

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

Future<void> _registerHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(sessionAuthModelTypeId)) {
    Hive.registerAdapter(SessionAuthModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionLocationLatLngTypeId)) {
    Hive.registerAdapter(SessionLocationLatLngModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionLanguageTypeId)) {
    Hive.registerAdapter(SessionLanguageModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionNotificationTypeId)) {
    Hive.registerAdapter(SessionNotificationSettingsModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionAreaRadiusTypeId)) {
    Hive.registerAdapter(SessionAreaRadiusModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionPremiumServiceTypeId)) {
    Hive.registerAdapter(SessionPremiumServiceModelAdapter());
  }

  if (!Hive.isAdapterRegistered(sessionListSortTypeId)) {
    Hive.registerAdapter(SessionListSortTypeModelAdapter());
  }

  await Hive.openBox('${AppConstants.appName.toLowerCase()}_session');
}

Future<void> _initNotification() async {
  await FirebaseNotificationManager.instance.initialize();
}

T _registerIfNot<T extends Object>(T instance) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerSingleton<T>(instance);
  }
  return getIt<T>();
}

void _registerLazyIfNot<T extends Object>(T Function() create) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerLazySingleton<T>(create);
  }
}

Future<void> registerUpdateLocationRepositoryAndServices() async {
  await _registerHive();
  final sessionService = _registerIfNot<SessionService>(SessionService());

  final baseApiService = _registerIfNot<BaseApiService>(BaseApiService());
  final commonRemoteService =
      _registerIfNot<CommonRemoteService>(CommonRemoteService(baseApiService));
  final profileRemoteService = _registerIfNot<ProfileRemoteService>(
      ProfileRemoteService(baseApiService));

  final commonRepository = _registerIfNot<CommonRepository>(
      CommonRepositoryImpl(
          remoteService: commonRemoteService, sessionService: sessionService));
  final profileRepository = _registerIfNot<ProfileRepository>(
      ProfileRepositoryImpl(remoteService: profileRemoteService));

  _registerLazyIfNot(() => SessionGetUseCase(commonRepository));
  _registerLazyIfNot(() => LastLocationSaveUseCase(commonRepository));
  _registerLazyIfNot(() => UserLocationUpdateUseCase(profileRepository));
}

void registeredRepositoryAndServices() {
  //base local service - start
  final baseLocalDatabase = _registerIfNot<AppDatabase>(AppDatabase());
  //base local service - end

  //base api - start
  final baseApiService = _registerIfNot<BaseApiService>(BaseApiService());
  //base api - end

  /// service
  //session service (hive) - start
  final sessionService = _registerIfNot<SessionService>(SessionService());

  //session service (hive) - end

  //local database service (drift) - start

  final alertLocalService =
      _registerIfNot<AlertLocalService>(AlertLocalService(baseLocalDatabase));

  //local database service (drift) - end

  //api service (dio) - start

  final authRemoteService =
      _registerIfNot<IAuthRemoteService>(AuthRemoteService(baseApiService));

  final alertRemoteService =
      _registerIfNot<AlertRemoteService>(AlertRemoteService(baseApiService));

  final profileRemoteService = _registerIfNot<ProfileRemoteService>(
      ProfileRemoteService(baseApiService));

  final settingsRemoteService = _registerIfNot<SettingsRemoteService>(
      SettingsRemoteService(baseApiService));

  // final fnfOldRemoteService =
  //     _registerIfNot<fo.FnfRemoteService>(fo.FnfRemoteService(baseApiService));

  final fnfRemoteService =
      _registerIfNot<FnfRemoteService>(FnfRemoteService(baseApiService));

  final premiumRemoteService = _registerIfNot<PremiumRemoteService>(
      PremiumRemoteService(baseApiService));

  final feedbackRemoteService = _registerIfNot<FeedbackRemoteService>(
      FeedbackRemoteService(baseApiService));

  final dashboardRemoteService = _registerIfNot<DashboardRemoteService>(
      DashboardRemoteService(baseApiService));

  final commonRemoteService =
      _registerIfNot<CommonRemoteService>(CommonRemoteService(baseApiService));

  //api service (dio) - end

  ///repositories

  final authRepository = _registerIfNot<AuthRepository>(AuthRepositoryImpl(
    remoteService: authRemoteService,
  ));

  final alertRepository = _registerIfNot<AlertRepository>(AlertRepositoryImpl(
      remoteService: alertRemoteService, localService: alertLocalService));

  final profileRepository = _registerIfNot<ProfileRepository>(
      ProfileRepositoryImpl(remoteService: profileRemoteService));

  final settingsRepository = _registerIfNot<SettingsRepository>(
      SettingsRepositoryImpl(remoteService: settingsRemoteService));

  // final fnfOldRepository = _registerIfNot<fo.FnfRepositoryImpl>(
  //     fo.FnfRepositoryImpl(remoteService: fnfOldRemoteService));

  final fnfRepository = _registerIfNot<FnfRepositoryImpl>(
      FnfRepositoryImpl(remoteService: fnfRemoteService));

  final premiumRepository = _registerIfNot<PremiumRepositoryImpl>(
      PremiumRepositoryImpl(
          remoteService: premiumRemoteService, sessionService: sessionService));

  final feedbackRepository = _registerIfNot<FeedbackRepository>(
      FeedbackRepositoryImpl(remoteService: feedbackRemoteService));

  final dashboardRepository = _registerIfNot<DashboardRepository>(
      DashboardRepositoryImpl(remoteService: dashboardRemoteService));

  final commonRepository = _registerIfNot<CommonRepository>(
      CommonRepositoryImpl(
          remoteService: commonRemoteService, sessionService: sessionService));

  //register auth use case
  _registerLazyIfNot(() => GetThanaListUseCase(authRepository));
  _registerLazyIfNot(() => VerifyPhoneUseCase(authRepository));
  _registerLazyIfNot(() => VerifyOtpUseCase(authRepository));
  _registerLazyIfNot(() => LoginUseCase(authRepository));
  _registerLazyIfNot(() => RegistrationUseCase(authRepository));

  _registerLazyIfNot(() => ForgotPasswordSendOtpUseCase(authRepository));
  _registerLazyIfNot(() => ForgotPasswordOtpVerifyUseCase(authRepository));
  _registerLazyIfNot(() => ResetPasswordUseCase(authRepository));
  _registerLazyIfNot(() => AuthorizeUserUseCase(authRepository));

  // register session use case
  _registerLazyIfNot(() => SessionSaveUseCase(commonRepository));
  _registerLazyIfNot(() => SessionGetUseCase(commonRepository));
  _registerLazyIfNot(() => SessionClearUseCase(commonRepository));
  _registerLazyIfNot(() => RememberAuthInfoSaveUseCase(commonRepository));
  _registerLazyIfNot(() => RememberAuthInfoGetUseCase(commonRepository));
  _registerLazyIfNot(() => RememberAuthInfoClearUseCase(commonRepository));

  _registerLazyIfNot(() => FcmDeviceTokenSaveUseCase(commonRepository));
  _registerLazyIfNot(() => FcmDeviceTokenGetUseCase(commonRepository));
  _registerLazyIfNot(() => FcmDeviceTokenClearUseCase(commonRepository));

  _registerLazyIfNot(() => LastLocationSaveUseCase(commonRepository));
  _registerLazyIfNot(() => LastLocationGetUseCase(commonRepository));
  _registerLazyIfNot(() => LastLocationClearUseCase(commonRepository));

  _registerLazyIfNot(() => LanguageSaveUseCase(commonRepository));
  _registerLazyIfNot(() => LanguageGetUseCase(commonRepository));
  _registerLazyIfNot(() => LanguageClearUseCase(commonRepository));

  _registerLazyIfNot(() => NotificationSettingsSaveUseCase(commonRepository));
  _registerLazyIfNot(() => NotificationSettingsGetUseCase(commonRepository));
  _registerLazyIfNot(() => NotificationSettingsClearUseCase(commonRepository));

  _registerLazyIfNot(() => RadiusSaveUseCase(commonRepository));
  _registerLazyIfNot(() => RadiusGetUseCase(commonRepository));
  _registerLazyIfNot(() => RadiusClearUseCase(commonRepository));

  _registerLazyIfNot(() => TooltipViewDateSaveUseCase(commonRepository));
  _registerLazyIfNot(() => TooltipViewDateGetUseCase(commonRepository));
  _registerLazyIfNot(() => TooltipViewDateClearUseCase(commonRepository));

  _registerLazyIfNot(() => AppTourViewStatusSaveUseCase(commonRepository));
  _registerLazyIfNot(() => AppTourViewStatusGetUseCase(commonRepository));
  _registerLazyIfNot(() => AppTourViewStatusClearUseCase(commonRepository));

  _registerLazyIfNot(() => ListSortTypeSaveUseCase(commonRepository));
  _registerLazyIfNot(() => ListSortTypeGetUseCase(commonRepository));
  _registerLazyIfNot(() => ListSortTypeClearUseCase(commonRepository));

  _registerLazyIfNot(() => LocationConsentClearUseCase(commonRepository));
  _registerLazyIfNot(() => LocationConsentGetUseCase(commonRepository));
  _registerLazyIfNot(() => LocationConsentSaveUseCase(commonRepository));

  _registerLazyIfNot(
      () => BackgroundLocationPermissionClearUseCase(commonRepository));
  _registerLazyIfNot(
      () => BackgroundLocationPermissionGetUseCase(commonRepository));
  _registerLazyIfNot(
      () => BackgroundLocationPermissionSaveUseCase(commonRepository));

  _registerLazyIfNot(() => PremiumServiceSaveUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumServiceGetUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumServiceClearUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumPopupViewDateClearUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumPopupViewDateGetUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumPopupViewDateSaveUseCase(premiumRepository));
  _registerLazyIfNot(() => PremiumServiceCheckUseCase(premiumRepository));

  // register feedback use case
  _registerLazyIfNot(() => SendUserReviewUseCase(feedbackRepository));

  //register alert use case
  _registerLazyIfNot(() => IncidentGetLocalListUseCase(alertRepository));
  _registerLazyIfNot(() => IncidentFetchRemoteListUseCase(alertRepository));
  _registerLazyIfNot(() => AlertGetActiveListRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertGetClosedListRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertGetMyListRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertGetRespondedListRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertGetActiveAllRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertAddRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertDeleteRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertStatusCloseRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertResponseRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertResponseDeleteRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertDetailRemoteUseCase(alertRepository));
  _registerLazyIfNot(() => AlertUpdateUseCase(alertRepository));
  _registerLazyIfNot(() => ReportAlertUseCase(alertRepository));

  //register profile use case
  _registerLazyIfNot(() => ProfilePicUpdateUseCase(profileRepository));
  _registerLazyIfNot(() => ProfileUpdateUseCase(profileRepository));
  _registerLazyIfNot(() => DeviceTokenRemoteUpdateUseCase(profileRepository));
  _registerLazyIfNot(() => UserLocationUpdateUseCase(profileRepository));
  _registerLazyIfNot(() => LogoutUserUseCase(profileRepository));

  //register settings use case
  _registerLazyIfNot(() => AreaLimitUpdateRemoteUseCase(settingsRepository));
  _registerLazyIfNot(() => UpdatePasswordRemoteUseCase(settingsRepository));
  _registerLazyIfNot(() => DeleteAccountRemoteUseCase(settingsRepository));

  //register dashboard use case
  _registerLazyIfNot(() => GetDashboardDataUseCase(dashboardRepository));

  _registerLazyIfNot(() => SearchFnfUseCase(fnfRepository));
  _registerLazyIfNot(() => SendFnfRequestUseCase(fnfRepository));
  _registerLazyIfNot(() => AcceptRequestUseCase(fnfRepository));
  _registerLazyIfNot(() => DeleteFnfUseCase(fnfRepository));
  _registerLazyIfNot(() => GetFnfListUseCase(fnfRepository));
  _registerLazyIfNot(() => GetFnfDetailsUseCase(fnfRepository));
  _registerLazyIfNot(() => LocationShareLimitUseCase(fnfRepository));
  _registerLazyIfNot(() => LocationShareRequestUseCase(fnfRepository));
  _registerLazyIfNot(() => AddFnfAddressUseCase(fnfRepository));
  _registerLazyIfNot(() => DeleteFnfAddressUseCase(fnfRepository));
  _registerLazyIfNot(() => UpdateFnfMessageUseCase(fnfRepository));
}
