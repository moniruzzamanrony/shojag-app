import 'package:app/feature/alert/domain/entity/alert_list_response_entity.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/list/alert_list_remote_post_model.dart';
import 'alert_get_list_remote_param.dart';

class AlertGetActiveListRemoteUseCase
    implements UseCase<AlertListResponseEntity, AlertGetListRemoteParam> {
  final AlertRepository repository;

  const AlertGetActiveListRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, AlertListResponseEntity>> call(
      AlertGetListRemoteParam params) async {
    final response = await repository.getActiveAlertListRemote(
        token: params.token,
        model: AlertListRemotePostModel(
          userId: params.userId,
          page: params.page,
          sortBy: params.sortBy.name,
        ));
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.success == true) {
          final entityList = r.data?.map((e) => e.toEntity()).toList() ?? [];

          final entity = AlertListResponseEntity(
            alerts: entityList,
            currentPage: r.pagination?.currentPage ?? 0,
            lastPage: r.pagination?.lastPage ?? 0,
            perPage: r.pagination?.perPage ?? 0,
            total: r.pagination?.total ?? 0,
          );

          return Right(entity);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}
