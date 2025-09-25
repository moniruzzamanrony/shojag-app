import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/helper/network_helper.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/alert/domain/usecase/incident_fetch_remote_list_use_case.dart';
import 'package:app/feature/profile/domain/usecase/device_token_remote_update_use_case.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends BaseProvider {
  int _currentIndex = 0;
  PageController pageController = PageController();

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notify();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
  }

  void animateToPage(int index) {
    _currentIndex = index;
    pageController.jumpToPage(index);
    notify();
  }

  Future<void> fetchIncidentList({required String token}) async {
    if (!(await isNetworkAvailable)) {
      return;
    }
    final fetchIncidentUseCase = getIt<IncidentFetchRemoteListUseCase>();
    final param = IncidentFetchRemoteListParam(token: token);
    await fetchIncidentUseCase(param);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  Future<bool> updateDeviceToken(int userId, String apiToken,
      {required String deviceToken}) async {
    final updateDeviceToken = getIt<DeviceTokenRemoteUpdateUseCase>();
    final param = DeviceTokenUpdateParam(
        token: apiToken, deviceToken: deviceToken, userId: userId);

    final result = await updateDeviceToken(param);
    return result.fold((l) => false, (r) => r);
  }
}
