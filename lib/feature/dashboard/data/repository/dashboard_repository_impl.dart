import 'package:app/core/error/data_state.dart';
import 'package:app/feature/dashboard/data/model/dashboard_data_remote_post_model.dart';
import 'package:app/feature/dashboard/data/model/dashboard_data_remote_response_model.dart';
import 'package:app/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  const DashboardRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, DashboardDataRemoteResponseModel>> getDashboardData(
      {required String token,
      required DashboardDataRemotePostModel model})  {
    return remoteService.getDashboardData(token: token, model: model);
  }
}
