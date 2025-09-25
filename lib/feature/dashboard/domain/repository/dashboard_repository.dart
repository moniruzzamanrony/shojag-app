import 'package:app/feature/dashboard/data/service/dashboard_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/dashboard_data_remote_post_model.dart';
import '../../data/model/dashboard_data_remote_response_model.dart';

abstract class DashboardRepository {
  final IDashboardRemoteService remoteService;

  const DashboardRepository({required this.remoteService});

  Future<Either<Failure, DashboardDataRemoteResponseModel>> getDashboardData(
      {required String token, required DashboardDataRemotePostModel model});
}
