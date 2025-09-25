// this file [update_location_helper.dart] is for the update location helper
// it contains the function to update the location

import 'package:app/core/usecase/usecase.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:app/shared/domain/usecase/last_location_save_use_case.dart';
import 'package:latlong2/latlong.dart';

import '../../../feature/profile/domain/usecase/user_location_update_use_case.dart';
import '../../../shared/domain/usecase/session_get_use_case.dart';
import '../resource/dependency_injection.dart';

Future<bool> updateLocation(LatLng loc) async {
  SessionAuthEntity? sessionInfo;
  try {
    sessionInfo = _getSessionInfo();
  } catch (_) {}
  if (sessionInfo == null) {
    return false;
  }
  if (sessionInfo.isLoggedIn == false) {
    return false;
  }
  final userId = sessionInfo.user.userId;
  final apiToken = sessionInfo.user.apiToken;
  final param = UserLocationUpdateParam(
      token: apiToken,
      userId: userId,
      latitude: loc.latitude,
      longitude: loc.longitude);
  try {
    final updateUserLocationUseCase = getIt<UserLocationUpdateUseCase>();
    final updateRemoteResult = await updateUserLocationUseCase(param);

    final isRemoteUpdated = updateRemoteResult.fold((l) => false, (r) => r);

    if (isRemoteUpdated) {
      final param = LastLocationSaveParams(
          latitude: loc.latitude, longitude: loc.longitude);
      final saveLastLocationUseCase = getIt<LastLocationSaveUseCase>();
      final saveLocalResult = await saveLastLocationUseCase(param);
      final isLocalUpdated = saveLocalResult.fold((l) => false, (r) => r);

      return isRemoteUpdated && isLocalUpdated;
    }
    return false;
  } catch (e) {
    return false;
  }
}

SessionAuthEntity? _getSessionInfo() {
  try {
    final sessionInfoUseCase = getIt<SessionGetUseCase>();
    final response = sessionInfoUseCase.call(NoParams());
    return response.fold((l) => null, (r) => r);
  } catch (e) {
    return null;
  }
}
