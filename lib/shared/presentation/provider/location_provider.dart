import 'dart:async';

import 'package:app/core/config/provider/base_provider.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../../core/utils/helper/location_helper.dart';
import '../../../feature/profile/domain/usecase/user_location_update_use_case.dart';
import '../../domain/usecase/background_location_permission_clear_use_case.dart';
import '../../domain/usecase/background_location_permission_get_use_case.dart';
import '../../domain/usecase/background_location_permission_save_use_case.dart';
import '../../domain/usecase/last_location_clear_use_case.dart';
import '../../domain/usecase/last_location_get_use_case.dart';
import '../../domain/usecase/last_location_save_use_case.dart';
import '../../domain/usecase/location_consent_clear_use_case.dart';
import '../../domain/usecase/location_consent_get_use_case.dart';
import '../../domain/usecase/location_consent_save_use_case.dart';

/// [LocationProvider]
/// goal to provide location related information
/// throughout the app
class LocationProvider extends BaseProvider {
  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    _lastLocationEntity = null;
  }

  Stream<LatLng>? _locatingStream;

  Stream<LatLng>? get locationStream => _locatingStream;

  /// [_populateLocationStream] populate location stream
  void _populateLocationStream() {
    _locatingStream = LocationHelper.getLocationStream(
            isBackground: false, customDistanceFilter: 10)
        .map((event) => LatLng(event.latitude, event.longitude));
  }

  /// return current location
  Future<LatLng?> get getCurrentLatLng async {
    final location = await LocationHelper.getCurrentPosition();
    if (location == null) return null;
    return LatLng(location.latitude, location.longitude);
  }

  /// update user location to the server and return status
  Future<bool> updateUserLocation({
    required int userId,
    required String apiToken,
    required double latitude,
    required double longitude,
  }) async {
    final updateUserLocationUseCase = getIt<UserLocationUpdateUseCase>();

    final param = UserLocationUpdateParam(
        token: apiToken,
        userId: userId,
        latitude: latitude,
        longitude: longitude);
    try {
      final result = await updateUserLocationUseCase(param);
      return result.fold((l) => false, (r) => r);
    } catch (e) {
      return false;
    }
  }

  /// save last location to the session and return status
  Future<bool> saveLastLocation(
      {required double latitude, required double longitude}) async {
    final saveLastLocationUseCase = getIt<LastLocationSaveUseCase>();

    final param =
        LastLocationSaveParams(latitude: latitude, longitude: longitude);
    try {
      final result = await saveLastLocationUseCase(param);
      return result.fold((l) => false, (r) => r);
    } catch (e) {
      return false;
    } finally {
      _populateLastLocation();
    }
  }

  LatLng? _lastLocationEntity;

  LatLng get lastSavedLocationLatLng => LatLng(
      _lastLocationEntity?.latitude ?? 0.0,
      _lastLocationEntity?.longitude ?? 0.0);

  /// populate last location
  void _populateLastLocation() {
    final getLastLocationUseCase = getIt<LastLocationGetUseCase>();

    final result = getLastLocationUseCase(NoParams());
    _lastLocationEntity = result.fold((l) => null, (r) => r);
  }

  /// clear last location
  Future<void> clearLastLocation() async {
    final clearLastLocationUseCase = getIt<LastLocationClearUseCase>();

    await clearLastLocationUseCase(NoParams());
    _populateLastLocation();
  }

  bool locationConsent = false;

  /// update location consent
  Future<void> updateLocationConsent({required bool consent}) async {
    final saveLocationConsentUseCase = getIt<LocationConsentSaveUseCase>();

    final param = LocationConsentSaveParams(consent: consent);
    await saveLocationConsentUseCase(param);
    _getLocationConsent();
    notify();
  }

  /// get location consent
  void _getLocationConsent() {
    final getLocationConsentUseCase = getIt<LocationConsentGetUseCase>();

    locationConsent =
        getLocationConsentUseCase(NoParams()).fold((l) => false, (r) => r);
  }

  /// clear location consent
  Future<void> clearLocationConsent() async {
    final clearLocationConsentUseCase = getIt<LocationConsentClearUseCase>();

    await clearLocationConsentUseCase(NoParams());
    _getLocationConsent();
  }

  bool hasBackgroundLocationPermission = false;

  /// update background location permission
  Future<void> updateBackgroundLocationPermission(
      {required bool permission}) async {
    final saveBackgroundLocationPermissionUseCase =
        getIt<BackgroundLocationPermissionSaveUseCase>();
    final param =
        BackgroundLocationPermissionSaveParams(permission: permission);
    await saveBackgroundLocationPermissionUseCase(param);
    _getBackgroundLocationPermission();
    notify();
  }

  /// get background location permission
  void _getBackgroundLocationPermission() {
    final getBackgroundLocationPermissionUseCase =
        getIt<BackgroundLocationPermissionGetUseCase>();
    hasBackgroundLocationPermission =
        getBackgroundLocationPermissionUseCase(NoParams())
            .fold((l) => false, (r) => r);
  }

  /// clear background location permission
  Future<void> clearBackgroundLocationPermission() async {
    final clearBackgroundLocationPermissionUseCase =
        getIt<BackgroundLocationPermissionClearUseCase>();

    await clearBackgroundLocationPermissionUseCase(NoParams());
    _getBackgroundLocationPermission();
  }

  /// initialize data when provider is created
  LocationProvider() {
    _populateLastLocation();
    _populateLocationStream();
    _getLocationConsent();
    _getBackgroundLocationPermission();
  }
}
