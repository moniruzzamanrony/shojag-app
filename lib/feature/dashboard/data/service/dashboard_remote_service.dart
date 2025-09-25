import 'package:app/core/network/base_api_service.dart';
import 'package:app/feature/dashboard/data/model/dashboard_data_remote_post_model.dart';
import 'package:app/feature/dashboard/data/model/dashboard_data_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/utils/constants/api_constants.dart';

abstract class IDashboardRemoteService {
  final BaseApiService apiService;

  const IDashboardRemoteService(this.apiService);

  Future<Either<Failure, DashboardDataRemoteResponseModel>> getDashboardData({
    required String token,
    required DashboardDataRemotePostModel model,
  });
}

class DashboardRemoteService extends IDashboardRemoteService {
  const DashboardRemoteService(super.apiService);

  @override
  Future<Either<Failure, DashboardDataRemoteResponseModel>> getDashboardData({
    required String token,
    required DashboardDataRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.dashboardAlertEndPoint,
      data: model.toMap(),
      fromJson: DashboardDataRemoteResponseModel.fromJson,
    );
  }
}
