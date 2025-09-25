import 'package:app/feature/alert/data/model/delete/alert_delete_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertDeleteRemoteUseCase
    implements UseCase<bool, AlertDeleteRemoteParam> {
  final AlertRepository repository;

  const AlertDeleteRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AlertDeleteRemoteParam params) async {
    final response = await repository.alertDeleteRemote(
        token: params.token,
        model: AlertDeleteRemotePostModel(
            userId: params.userId, alertId: params.alertId));
    return response.fold(
          (l) => Left(l),
      (r) {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class AlertDeleteRemoteParam {
  final String token;
  final int userId;
  final int alertId;

  const AlertDeleteRemoteParam({
    required this.token,
    required this.userId,
    required this.alertId,
  });
}
