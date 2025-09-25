import 'package:app/feature/alert/data/model/delete/alert_delete_remote_response_model.dart';
import 'package:app/feature/alert/data/model/details/alert_details_remote_response_model.dart';
import 'package:app/feature/alert/data/model/incident_list_remote_response_model.dart';
import 'package:app/feature/alert/data/model/response/alert_response_remote_post_model.dart';
import 'package:app/feature/alert/data/model/response/alert_response_remote_response_model.dart';
import 'package:app/feature/alert/data/model/update/alert_status_close_remote_post_model.dart';
import 'package:app/feature/alert/data/model/update/alert_status_close_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../model/create/alert_add_remote_post_model.dart';
import '../model/create/alert_add_remote_response_model.dart';
import '../model/delete/alert_delete_remote_post_model.dart';
import '../model/details/alert_details_remote_post_model.dart';
import '../model/list/alert_active_all_remote_post_model.dart';
import '../model/list/alert_active_all_remote_response_model.dart';
import '../model/list/alert_list_remote_post_model.dart';
import '../model/list/alert_list_remote_response_model.dart';
import '../model/report/alert_report_remote_post_model.dart';
import '../model/report/alert_report_remote_response_model.dart';
import '../model/response/alert_response_delete_remote_post_model.dart';
import '../model/response/alert_response_delete_remote_response_model.dart';
import '../model/update/alert_update_remote_post_model.dart';
import '../model/update/alert_update_remote_response_model.dart';

abstract class IAlertRemoteService {
  final BaseApiService apiService;

  const IAlertRemoteService(this.apiService);

  Future<Either<Failure, IncidentListRemoteResponseModel>> getIncidentList({required String token});

  Future<Either<Failure, AlertListRemoteResponseModel>> getActiveAlertList({
    required String token,
    required AlertListRemotePostModel model,
  });

  Future<Either<Failure, AlertListRemoteResponseModel>> getClosedAlertList({
    required String token,
    required AlertListRemotePostModel model,
  });

  Future<Either<Failure, AlertListRemoteResponseModel>> getMyAlertList({
    required String token,
    required AlertListRemotePostModel model,
  });

  Future<Either<Failure, AlertListRemoteResponseModel>> getRespondedAlertList({
    required String token,
    required AlertListRemotePostModel model,
  });

  Future<Either<Failure, AlertActiveAllRemoteResponseModel>> getAllActiveAlertList({
    required String token,
    required AlertActiveAllRemotePostModel model,
  });

  Future<Either<Failure, AlertAddRemoteResponseModel>> addAlert({
    required String token,
    required AlertAddRemotePostModel model,
  });

  Future<Either<Failure, AlertDeleteRemoteResponseModel>> alertDelete({
    required String token,
    required AlertDeleteRemotePostModel model,
  });

  Future<Either<Failure, AlertStatusCloseRemoteResponseModel>> alertStatusClose({
    required String token,
    required AlertStatusCloseRemotePostModel model,
  });

  Future<Either<Failure, AlertResponseRemoteResponseModel>> alertResponse({
    required String token,
    required AlertResponseRemotePostModel model,
  });

  Future<Either<Failure, AlertResponseDeleteRemoteResponseModel>> alertResponseDelete({
    required String token,
    required AlertResponseDeleteRemotePostModel model,
  });

  Future<Either<Failure, AlertDetailsRemoteResponseModel>> alertDetail({
    required String token,
    required AlertDetailsRemotePostModel model,
  });

  Future<Either<Failure, AlertUpdateRemoteResponseModel>> updateAlert({
    required String token,
    required AlertUpdateRemotePostModel model,
  });

  Future<Either<Failure, AlertReportRemoteResponseModel>> reportAlert({
    required String token,
    required AlertReportRemotePostModel model,
  });
}

class AlertRemoteService extends IAlertRemoteService {
  const AlertRemoteService(super.apiService);

  @override
  Future<Either<Failure, IncidentListRemoteResponseModel>> getIncidentList({required String token}) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.incidentListEndPoint,
      fromJson: IncidentListRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertAddRemoteResponseModel>> addAlert({
    required String token,
    required AlertAddRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertAddEndPoint,
      data: model.toMap(),
      fromJson: AlertAddRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertDeleteRemoteResponseModel>> alertDelete({
    required String token,
    required AlertDeleteRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertDeleteEndPoint,
      data: model.toMap(),
      fromJson: AlertDeleteRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertStatusCloseRemoteResponseModel>> alertStatusClose({
    required String token,
    required AlertStatusCloseRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertStatusUpdateEndPoint,
      data: model.toMap(),
      fromJson: AlertStatusCloseRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertResponseRemoteResponseModel>> alertResponse({
    required String token,
    required AlertResponseRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertResponseEndPoint,
      data: model.toMap(),
      fromJson: AlertResponseRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertResponseDeleteRemoteResponseModel>> alertResponseDelete({
    required String token,
    required AlertResponseDeleteRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertResponseDeleteEndPoint,
      data: model.toMap(),
      fromJson: AlertResponseDeleteRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertDetailsRemoteResponseModel>> alertDetail({
    required String token,
    required AlertDetailsRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.alertDetailEndPoint,
      data: model.toMap(),
      fromJson: AlertDetailsRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>> getActiveAlertList({
    required String token,
    required AlertListRemotePostModel model,
  }) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.activeAlertListEndPoint,
      fromJson: AlertListRemoteResponseModel.fromJson,
      query: model.toMap(),
    );
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>> getClosedAlertList({
    required String token,
    required AlertListRemotePostModel model,
  }) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.closedAlertListEndPoint,
      fromJson: AlertListRemoteResponseModel.fromJson,
      query: model.toMap(),
    );
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>> getMyAlertList({
    required String token,
    required AlertListRemotePostModel model,
  }) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.myAlertListEndPoint,
      fromJson: AlertListRemoteResponseModel.fromJson,
      query: model.toMap(),
    );
  }

  @override
  Future<Either<Failure, AlertListRemoteResponseModel>> getRespondedAlertList({
    required String token,
    required AlertListRemotePostModel model,
  }) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.respondedAlertListEndPoint,
      fromJson: AlertListRemoteResponseModel.fromJson,
      query: model.toMap(),
    );
  }

  @override
  Future<Either<Failure, AlertActiveAllRemoteResponseModel>> getAllActiveAlertList({
    required String token,
    required AlertActiveAllRemotePostModel model,
  }) async {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.allActiveAlertListEndPoint,
      fromJson: AlertActiveAllRemoteResponseModel.fromJson,
      query: model.toMap(),
    );
  }

  @override
  Future<Either<Failure, AlertUpdateRemoteResponseModel>> updateAlert({
    required String token,
    required AlertUpdateRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.updateAlertEndPoint,
      data: model.toMap(),
      fromJson: AlertUpdateRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AlertReportRemoteResponseModel>> reportAlert({
    required String token,
    required AlertReportRemotePostModel model,
  }) async {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.reportAlertEndPoint,
      data: model.toMap(),
      fromJson: AlertReportRemoteResponseModel.fromJson,
    );
  }
}
