import 'package:app/core/error/data_state.dart';
import 'package:app/feature/dashboard/data/model/dashboard_data_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../entity/dashboard_data_entity.dart';
import '../repository/dashboard_repository.dart';

class GetDashboardDataUseCase
    implements UseCase<DashboardDataEntity, GetDashboardDataParam> {
  final DashboardRepository dashboardRepository;

  const GetDashboardDataUseCase(this.dashboardRepository);

  @override
  Future<Either<Failure, DashboardDataEntity>> call(
      GetDashboardDataParam params) async {
    final result = await dashboardRepository.getDashboardData(
        token: params.token,
        model: DashboardDataRemotePostModel(
            userId: params.userId, sortBy: params.sortBy));

    return result.fold((l) => Left(l), (r) {
      if (r.success == true) {
        final activeList =
            r.activeList?.map((e) => e.toEntity()).toList() ?? [];
        final closeList = r.closeList?.map((e) => e.toEntity()).toList() ?? [];
        final respondedList =
            r.respondedList?.map((e) => e.toEntity()).toList() ?? [];
        final myList = r.myList?.map((e) => e.toEntity()).toList() ?? [];

        return Right(DashboardDataEntity(
            activeList: activeList,
            closeList: closeList,
            respondedList: respondedList,
            myList: myList));
      }

      return Left(ServerFailure(r.message ?? ''));
    });
  }
}

class GetDashboardDataParam {
  final String token;
  final int userId;
  final String sortBy;

  const GetDashboardDataParam(
      {required this.token, required this.userId, required this.sortBy});
}
