import 'package:app/feature/alert/data/model/update/alert_status_close_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertStatusCloseRemoteUseCase
    implements UseCase<bool, AlertStatusCloseRemoteParam> {
  final AlertRepository repository;

  const AlertStatusCloseRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AlertStatusCloseRemoteParam params) async {
    final response = await repository.alertStatusCloseRemote(
        token: params.token,
        model: AlertStatusCloseRemotePostModel(
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

class AlertStatusCloseRemoteParam {
  final String token;
  final int userId;
  final int alertId;

  const AlertStatusCloseRemoteParam({
    required this.token,
    required this.userId,
    required this.alertId,
  });
}
