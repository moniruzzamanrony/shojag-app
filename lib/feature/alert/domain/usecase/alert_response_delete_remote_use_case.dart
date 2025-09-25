import 'package:app/feature/alert/data/model/response/alert_response_delete_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertResponseDeleteRemoteUseCase
    implements UseCase<bool, AlertResponseDeleteRemoteParam> {
  final AlertRepository repository;

  const AlertResponseDeleteRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      AlertResponseDeleteRemoteParam params) async {
    final response = await repository.alertResponseDeleteRemote(
        token: params.token,
        model: AlertResponseDeleteRemotePostModel(
          responderId: params.responderUserId,
          alertId: params.alertId,
        ));
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

class AlertResponseDeleteRemoteParam {
  final String token;
  final int responderUserId;
  final int alertId;

  const AlertResponseDeleteRemoteParam({
    required this.token,
    required this.responderUserId,
    required this.alertId,
  });
}
