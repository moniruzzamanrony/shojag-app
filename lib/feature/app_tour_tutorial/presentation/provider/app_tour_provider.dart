import 'package:app/shared/domain/usecase/app_tour_view_status_save_use_case.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../../../shared/domain/usecase/app_tour_view_status_clear_use_case.dart';
import '../../../../shared/domain/usecase/app_tour_view_status_get_use_case.dart';

class AppTourProvider {

  Future<void> saveAppTourViewStatus({required bool status}) async {
    final saveAppTourUseCase = getIt<AppTourViewStatusSaveUseCase>();
    await saveAppTourUseCase.call(AppTourViewStatusSaveParams(status: status));
    _getAppTourViewStatus();
  }

  bool isAppTourCompleted = false;

  void _getAppTourViewStatus() {
    final getAppTourUseCase = getIt<AppTourViewStatusGetUseCase>();
    final response = getAppTourUseCase.call(NoParams());
    isAppTourCompleted = response.fold((l) => false, (r) => r);
  }

  Future<void> clearAppTourViewStatus() async {
    final clearAppTourUseCase = getIt<AppTourViewStatusClearUseCase>();
    await clearAppTourUseCase.call(NoParams());
    _getAppTourViewStatus();
  }

  AppTourProvider() {
    _getAppTourViewStatus();
  }
}
