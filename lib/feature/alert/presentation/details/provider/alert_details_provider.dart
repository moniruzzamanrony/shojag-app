/*
* provider : alert details provider
*/

import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/feature/alert/domain/usecase/alert_delete_remote_use_case.dart';

import '../../../../../../core/utils/resource/dependency_injection.dart';
import '../../../domain/entity/alert_entity.dart';
import '../../../domain/entity/alert_response_entity.dart';
import '../../../domain/usecase/alert_detail_remote_use_case.dart';
import '../../../domain/usecase/alert_response_delete_remote_use_case.dart';
import '../../../domain/usecase/alert_response_remote_use_case.dart';
import '../../../domain/usecase/alert_status_close_remote_use_case.dart';
import '../../../domain/usecase/report_alert_use_case.dart';

class AlertDetailsProvider extends BaseProvider {
  late AlertEntity? currentAlert;

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  bool isAlertClosing = false;

  Future<bool> closeAlert(
      int userId, String apiToken, AlertEntity alertModel) async {
    isAlertClosing = true;
    notify();
    final closeAlertUseCase = getIt<AlertStatusCloseRemoteUseCase>();
    final param = AlertStatusCloseRemoteParam(
        token: apiToken, userId: userId, alertId: alertModel.id);

    final response = await closeAlertUseCase(param);
    isAlertClosing = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  bool isAlertDeleting = false;

  Future<bool> deleteAlert(
      int userId, String apiToken, AlertEntity alertModel) async {
    isAlertDeleting = true;
    notify();
    final deleteAlertUseCase = getIt<AlertDeleteRemoteUseCase>();
    final param = AlertDeleteRemoteParam(
        token: apiToken, userId: userId, alertId: alertModel.id);
    final response = await deleteAlertUseCase(param);
    isAlertDeleting = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  bool isAlertResponding = false;

  Future<bool> responseAlert(
      {required int userId,
      required String apiToken,
      required int alertId,
      String? message}) async {
    isAlertResponding = true;
    notify();
    final alertResponseUseCase = getIt<AlertResponseRemoteUseCase>();
    final param = AlertResponseRemoteParam(
        token: apiToken,
        responderUserId: userId,
        alertId: alertId,
        message: message);
    final response = await alertResponseUseCase(param);
    isAlertResponding = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  bool isAlertResponseDeleting = false;

  Future<bool> responseAlertDelete(
      {required int userId,
      required String apiToken,
      required int alertId}) async {
    isAlertResponseDeleting = true;
    notify();
    final alertResponseDeleteUseCase =
        getIt<AlertResponseDeleteRemoteUseCase>();
    final param = AlertResponseDeleteRemoteParam(
        token: apiToken, responderUserId: userId, alertId: alertId);
    final response = await alertResponseDeleteUseCase(param);
    isAlertResponseDeleting = false;
    notify();
    return response.fold((l) => throw Future.error(l.message), (r) => r);
  }

  bool isAlertResponsesLoading = false;
  bool hasAlertResponsesLoadingError = false;
  Map<int, AlertResponseEntity> responseMapList = {};

  //
  bool isResponded(int userId) => responseMapList.containsKey(userId);

  bool hasAlreadyRespondedByGroup(UserType type) =>
      responseMapList.values.any((element) => element.userType == type);

  //
  Future<void> loadAlertResponses(
      {required int userId,
      required String apiToken,
      required int alertId}) async {
    isAlertResponsesLoading = true;
    hasAlertResponsesLoadingError = false;
    final alertDetailUseCase = getIt<AlertDetailRemoteUseCase>();

    final param = AlertDetailRemoteParam(
        token: apiToken, alertId: alertId, userId: userId);
    final response = await alertDetailUseCase(param);
    isAlertResponsesLoading = false;

    responseMapList = response.fold(
      (l) {
        hasAlertResponsesLoadingError = true;
        return responseMapList;
      },
      (r) => {for (var e in r.responseList) e.userId: e},
    );
  }

  bool isAlertDetailsLoading = false;
  bool hasAlertDetailsLoadingError = false;

  Future<void> loadAlertDetailsWithResponses(
      {required int userId,
      required String apiToken,
      required int alertId,
      bool refresh = false}) async {
    responseMapList = {};
    //currentAlert = null;
    isAlertDetailsLoading = true;
    hasAlertDetailsLoadingError = false;

    final alertDetailUseCase = getIt<AlertDetailRemoteUseCase>();
    final param = AlertDetailRemoteParam(
        token: apiToken, alertId: alertId, userId: userId);
    final response = await alertDetailUseCase(param);
    isAlertDetailsLoading = false;

    return response.fold(
      (l) {
        hasAlertDetailsLoadingError = true;
        responseMapList = {};
        if (refresh) notify();
        return Future.error(l.message);
      },
      (r) {
        currentAlert = r.alert;
        for (var e in r.responseList) {
          responseMapList[e.userId] = e;
        }
        if (refresh) notify();
        return;
      },
    );
  }

  bool isAlertReportLoading = false;

  Future<bool> reportAlert(
      int userId, String apiToken, int alertId, String comment) async {
    isAlertReportLoading = true;
    notify();
    final alertReportUseCase = getIt<ReportAlertUseCase>();

    final param = ReportAlertParams(
        token: apiToken, userId: userId, alertId: alertId, comment: comment);
    final response = await alertReportUseCase(param);
    isAlertReportLoading = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }
}
