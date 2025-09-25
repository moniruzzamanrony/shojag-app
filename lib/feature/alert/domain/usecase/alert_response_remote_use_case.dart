import 'package:app/feature/alert/data/model/response/alert_response_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertResponseRemoteUseCase
    implements UseCase<bool, AlertResponseRemoteParam> {
  final AlertRepository repository;

  const AlertResponseRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AlertResponseRemoteParam params) async {
    final response = await repository.alertResponseRemote(
        token: params.token,
        model: AlertResponseRemotePostModel(
            responderUserId: params.responderUserId,
            alertId: params.alertId,
            message: params.message));
    return response.fold(
          (l) => Left(l),
      (r) => r.success == true
          ? const Right(true)
          : Left(ServerFailure(r.message ?? '')),
    );
  }
}

class AlertResponseRemoteParam {
  final String token;
  final int responderUserId;
  final int alertId;
  final String? message;

  const AlertResponseRemoteParam({
    required this.token,
    required this.responderUserId,
    required this.alertId,
    this.message,
  });
}
