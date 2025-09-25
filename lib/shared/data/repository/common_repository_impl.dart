import 'package:app/shared/data/model/session_area_radius_model.dart';
import 'package:app/shared/data/model/session_language_model.dart';
import 'package:app/shared/data/model/session_list_sort_type_model.dart';
import 'package:app/shared/data/model/session_location_lat_lng_model.dart';
import 'package:app/shared/data/model/session_notification_settings_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../domain/repository/common_repository.dart';
import '../model/session_auth_model.dart';

/// [CommonRepositoryImpl] is an implementation of the [CommonRepository] interface.
/// It contains methods for saving, getting, and clearing common session information.
/// The repository is responsible for storing and retrieving session information,
/// such as authentication, language, and location.
class CommonRepositoryImpl extends CommonRepository {
  const CommonRepositoryImpl(
      {required super.remoteService, required super.sessionService});

  @override
  Future<Either<HiveFailure, void>> clearAuthSession() async {
    return sessionService.clearAuthSession();
  }

  @override
  Either<HiveFailure, SessionAuthModel?> getAuthSession() {
    return sessionService.getAuthSession();
  }

  @override
  Future<Either<HiveFailure, void>> saveAuthSession(
      SessionAuthModel model) async {
    return sessionService.saveAuthSession(model);
  }

  @override
  Future<Either<HiveFailure, void>> clearRememberAuthInfo() async {
    return await sessionService.clearRememberAuthInfo();
  }

  @override
  Either<HiveFailure, String?> getRememberAuthInfo() {
    return sessionService.getRememberAuthInfo();
  }

  @override
  Future<Either<HiveFailure, void>> saveRememberAuthInfo(
      String authInfo) async {
    return await sessionService.saveRememberAuthInfo(authInfo);
  }

  @override
  Future<Either<HiveFailure, void>> clearDeviceFCMToken() {
    return sessionService.clearDeviceFCMToken();
  }

  @override
  Either<HiveFailure, String?> getDeviceFCMToken() {
    return sessionService.getDeviceFCMToken();
  }

  @override
  Future<Either<HiveFailure, void>> saveDeviceFCMToken(String token) {
    return sessionService.saveDeviceFCMToken(token);
  }

  @override
  Future<Either<HiveFailure, void>> clearLastLocation() async {
    return await sessionService.clearLastLocation();
  }

  @override
  Either<HiveFailure, SessionLocationLatLngModel?> getLastLocation() {
    return sessionService.getLastLocation();
  }

  @override
  Future<Either<HiveFailure, void>> saveLastLocation(
      SessionLocationLatLngModel location) async {
    return await sessionService.saveLastLocation(location);
  }

  @override
  Future<Either<HiveFailure, void>> clearListType() async {
    return await sessionService.clearListSortType();
  }

  @override
  Either<HiveFailure, SessionListSortTypeModel> getListSortType() {
    return sessionService.getListSortType();
  }

  @override
  Future<Either<HiveFailure, void>> saveListSortType(
      SessionListSortTypeModel model) async {
    return await sessionService.saveListSortType(model);
  }

  @override
  Future<Either<HiveFailure, void>> clearLanguage() async {
    return await sessionService.clearLanguage();
  }

  @override
  Future<Either<HiveFailure, void>> saveLanguage(
      SessionLanguageModel model) async {
    return await sessionService.saveLanguage(model);
  }

  @override
  Either<HiveFailure, SessionLanguageModel> getLanguage() {
    return sessionService.getLanguage();
  }

  @override
  Future<Either<HiveFailure, void>> clearNotificationSettings() async {
    return await sessionService.clearNotificationSettings();
  }

  @override
  Either<HiveFailure, SessionNotificationSettingsModel>
      getNotificationSettings() {
    return sessionService.getNotificationSettings();
  }

  @override
  Future<Either<HiveFailure, void>> saveNotificationSettings(
      SessionNotificationSettingsModel model) async {
    return await sessionService.saveNotificationSettings(model);
  }

  @override
  Either<HiveFailure, SessionAreaRadiusModel> getRadius() {
    return sessionService.getRadius();
  }

  @override
  Future<Either<HiveFailure, void>> clearRadius() async {
    return await sessionService.clearRadius();
  }

  @override
  Future<Either<HiveFailure, void>> saveRadius(
      SessionAreaRadiusModel model) async {
    return await sessionService.saveRadius(model);
  }

  @override
  Future<Either<HiveFailure, void>> clearTooltipViewDate() async {
    return await sessionService.clearTooltipViewDate();
  }

  @override
  Either<HiveFailure, DateTime> getTooltipViewDate() {
    return sessionService.getTooltipViewDate();
  }

  @override
  Future<Either<HiveFailure, void>> saveTooltipViewDate(DateTime model) async {
    return await sessionService.saveTooltipViewDate(model);
  }

  @override
  Future<Either<HiveFailure, void>> clearLocationConsent() async {
    return await sessionService.clearLocationConsent();
  }

  @override
  Either<HiveFailure, bool> getLocationConsent() {
    return sessionService.getLocationConsent();
  }

  @override
  Future<Either<HiveFailure, void>> saveLocationConsent(bool model) async {
    return await sessionService.saveLocationConsent(model);
  }

  @override
  Future<Either<HiveFailure, void>> clearBackgroundLocationPermission() async {
    return await sessionService.clearBackgroundLocationPermission();
  }

  @override
  Either<HiveFailure, bool> getBackgroundLocationPermission() {
    return sessionService.getBackgroundLocationPermission();
  }

  @override
  Future<Either<HiveFailure, void>> saveBackgroundLocationPermission(
      bool permission) async {
    return await sessionService.saveBackgroundLocationPermission(permission);
  }

  @override
  Future<Either<HiveFailure, void>> clearAppTourViewStatus() async {
    return await sessionService.clearAppTourViewStatus();
  }

  @override
  Either<HiveFailure, bool> getAppTourViewStatus() {
    return sessionService.getAppTourViewStatus();
  }

  @override
  Future<Either<HiveFailure, void>> saveAppTourViewStatus(bool status) async {
    return await sessionService.saveAppTourViewStatus(status);
  }
}
