import 'package:app/feature/alert/data/model/list/alert_list_remote_response_model.dart';
import 'package:app/feature/alert/data/service/alert_local_service.dart';
import 'package:app/feature/alert/data/service/alert_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/create/alert_add_remote_post_model.dart';
import '../../data/model/create/alert_add_remote_response_model.dart';
import '../../data/model/delete/alert_delete_remote_post_model.dart';
import '../../data/model/delete/alert_delete_remote_response_model.dart';
import '../../data/model/details/alert_details_remote_post_model.dart';
import '../../data/model/details/alert_details_remote_response_model.dart';
import '../../data/model/incident_list_remote_response_model.dart';
import '../../data/model/incident_local_model.dart';
import '../../data/model/list/alert_active_all_remote_post_model.dart';
import '../../data/model/list/alert_active_all_remote_response_model.dart';
import '../../data/model/list/alert_list_remote_post_model.dart';
import '../../data/model/report/alert_report_remote_post_model.dart';
import '../../data/model/report/alert_report_remote_response_model.dart';
import '../../data/model/response/alert_response_delete_remote_post_model.dart';
import '../../data/model/response/alert_response_delete_remote_response_model.dart';
import '../../data/model/response/alert_response_remote_post_model.dart';
import '../../data/model/response/alert_response_remote_response_model.dart';
import '../../data/model/update/alert_status_close_remote_post_model.dart';
import '../../data/model/update/alert_status_close_remote_response_model.dart';
import '../../data/model/update/alert_update_remote_post_model.dart';
import '../../data/model/update/alert_update_remote_response_model.dart';

abstract class AlertRepository {
  final IAlertRemoteService remoteService;
  final IAlertLocalService localService;

  AlertRepository({required this.remoteService, required this.localService});

  Future<Either<Failure, IncidentListRemoteResponseModel>>
      getIncidentListRemote({required String token});

  Future<Either<Failure, void>> addIncidentListLocal(
      {required List<IncidentLocalModel> modelList});

  Future<Either<Failure, List<IncidentLocalModel>>> getIncidentListLocal(
      {required int? id,
      required int? categoryId,
      required bool? isOnline,
      required int? limit,
      required int? offset});

  Future<Either<Failure, AlertAddRemoteResponseModel>> addAlertRemote(
      {required String token, required AlertAddRemotePostModel model});

  Future<Either<Failure, AlertDeleteRemoteResponseModel>> alertDeleteRemote(
      {required String token, required AlertDeleteRemotePostModel model});

  Future<Either<Failure, AlertStatusCloseRemoteResponseModel>>
      alertStatusCloseRemote(
          {required String token,
          required AlertStatusCloseRemotePostModel model});

  Future<Either<Failure, AlertResponseRemoteResponseModel>> alertResponseRemote(
      {required String token, required AlertResponseRemotePostModel model});

  Future<Either<Failure, AlertResponseDeleteRemoteResponseModel>> alertResponseDeleteRemote(
      {required String token, required AlertResponseDeleteRemotePostModel model});

  Future<Either<Failure, AlertDetailsRemoteResponseModel>> alertDetailRemote(
      {required String token, required AlertDetailsRemotePostModel model});

  Future<Either<Failure, AlertListRemoteResponseModel>> getActiveAlertListRemote(
      {required String token, required AlertListRemotePostModel model});

  Future<Either<Failure, AlertListRemoteResponseModel>> getClosedAlertListRemote(
      {required String token, required AlertListRemotePostModel model});

  Future<Either<Failure, AlertListRemoteResponseModel>> getMyAlertListRemote(
      {required String token, required AlertListRemotePostModel model});

  Future<Either<Failure, AlertListRemoteResponseModel>> getRespondedAlertListRemote(
      {required String token, required AlertListRemotePostModel model});

  Future<Either<Failure, AlertActiveAllRemoteResponseModel>> getAllActiveAlertListRemote(
      {required String token, required AlertActiveAllRemotePostModel model});

  Future<Either<Failure, AlertUpdateRemoteResponseModel>> updateAlertRemote(
      {required String token,
        required AlertUpdateRemotePostModel model});

  Future<Either<Failure, AlertReportRemoteResponseModel>> reportAlertRemote(
      {required String token,
        required AlertReportRemotePostModel model});


}
