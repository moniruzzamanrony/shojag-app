import 'package:app/core/error/data_state.dart';
import 'package:app/feature/alert/data/model/create/alert_add_remote_post_model.dart';
import 'package:app/feature/alert/data/model/create/alert_add_remote_response_model.dart';
import 'package:app/feature/alert/data/model/delete/alert_delete_remote_post_model.dart';
import 'package:app/feature/alert/data/model/delete/alert_delete_remote_response_model.dart';
import 'package:app/feature/alert/data/model/details/alert_details_remote_post_model.dart';
import 'package:app/feature/alert/data/model/details/alert_details_remote_response_model.dart';
import 'package:app/feature/alert/data/model/incident_list_remote_response_model.dart';
import 'package:app/feature/alert/data/model/incident_local_model.dart';
import 'package:app/feature/alert/data/model/list/alert_active_all_remote_post_model.dart';
import 'package:app/feature/alert/data/model/list/alert_active_all_remote_response_model.dart';
import 'package:app/feature/alert/data/model/list/alert_list_remote_post_model.dart';
import 'package:app/feature/alert/data/model/list/alert_list_remote_response_model.dart';
import 'package:app/feature/alert/data/model/report/alert_report_remote_post_model.dart';
import 'package:app/feature/alert/data/model/report/alert_report_remote_response_model.dart';
import 'package:app/feature/alert/data/model/response/alert_response_remote_post_model.dart';
import 'package:app/feature/alert/data/model/response/alert_response_remote_response_model.dart';
import 'package:app/feature/alert/data/model/update/alert_status_close_remote_post_model.dart';
import 'package:app/feature/alert/data/model/update/alert_status_close_remote_response_model.dart';
import 'package:app/feature/alert/data/model/update/alert_update_remote_post_model.dart';
import 'package:app/feature/alert/data/model/update/alert_update_remote_response_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../model/response/alert_response_delete_remote_post_model.dart';
import '../model/response/alert_response_delete_remote_response_model.dart';

class AlertRepositoryImpl extends AlertRepository {
  AlertRepositoryImpl(
      {required super.remoteService, required super.localService});

  @override
  Future<Either<Failure, void>> addIncidentListLocal(
      {required List<IncidentLocalModel> modelList}) {
    return localService.addIncidentList(modelList: modelList);
  }

  @override
  Future<Either<Failure, List<IncidentLocalModel>>> getIncidentListLocal(
      {required int? id,
      required int? categoryId,
      required bool? isOnline,
      required int? limit,
      required int? offset}) {
    return localService.getIncidentList(
        id: id,
        categoryId: categoryId,
        isOnline: isOnline,
        limit: limit,
        offset: offset);
  }

  @override
  Future<Either<Failure, IncidentListRemoteResponseModel>>
      getIncidentListRemote({required String token}) {
    return remoteService.getIncidentList(token: token);
  }

  @override
  Future<Either<Failure, AlertAddRemoteResponseModel>> addAlertRemote(
      {required String token, required AlertAddRemotePostModel model}) {
    return remoteService.addAlert(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertDeleteRemoteResponseModel>> alertDeleteRemote(
      {required String token, required AlertDeleteRemotePostModel model}) {
    return remoteService.alertDelete(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertStatusCloseRemoteResponseModel>>
      alertStatusCloseRemote(
          {required String token,
          required AlertStatusCloseRemotePostModel model}) {
    return remoteService.alertStatusClose(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertResponseRemoteResponseModel>> alertResponseRemote(
      {required String token, required AlertResponseRemotePostModel model}) {
    return remoteService.alertResponse(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertResponseDeleteRemoteResponseModel>>
      alertResponseDeleteRemote(
          {required String token,
          required AlertResponseDeleteRemotePostModel model}) {
    return remoteService.alertResponseDelete(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertDetailsRemoteResponseModel>> alertDetailRemote(
      {required String token, required AlertDetailsRemotePostModel model}) {
    return remoteService.alertDetail(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>>
      getActiveAlertListRemote(
          {required String token, required AlertListRemotePostModel model}) {
    return remoteService.getActiveAlertList(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>>
      getClosedAlertListRemote(
          {required String token, required AlertListRemotePostModel model}) {
    return remoteService.getClosedAlertList(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>> getMyAlertListRemote(
      {required String token, required AlertListRemotePostModel model}) {
    return remoteService.getMyAlertList(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>>
      getRespondedAlertListRemote(
          {required String token, required AlertListRemotePostModel model}) {
    return remoteService.getRespondedAlertList(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertActiveAllRemoteResponseModel>>
      getAllActiveAlertListRemote(
          {required String token,
          required AlertActiveAllRemotePostModel model}) {
    return remoteService.getAllActiveAlertList(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertUpdateRemoteResponseModel>> updateAlertRemote(
      {required String token, required AlertUpdateRemotePostModel model}) {
    return remoteService.updateAlert(token: token, model: model);
  }

  @override
  Future<Either<Failure, AlertReportRemoteResponseModel>> reportAlertRemote(
      {required String token, required AlertReportRemotePostModel model}) {
    return remoteService.reportAlert(token: token, model: model);
  }
}
