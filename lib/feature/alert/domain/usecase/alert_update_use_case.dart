import 'package:app/feature/alert/data/model/update/alert_update_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertUpdateUseCase implements UseCase<bool, AlertUpdateParam> {
  final AlertRepository repository;

  const AlertUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AlertUpdateParam params) async {
    final response = await repository.updateAlertRemote(
        token: params.token,
        model: AlertUpdateRemotePostModel(
          alertId: params.alertId,
          userId: params.userId,
          description: params.description,
          latitude: params.latitude,
          longitude: params.longitude,
          address: params.detailAddress,
          geoAddress: params.geoAddress,
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

class AlertUpdateParam {
  final String token;
  final int userId;
  final int alertId;
  final double latitude;
  final double longitude;
  final String description;
  final String? geoAddress;
  final String? detailAddress;

  const AlertUpdateParam({
    required this.token,
    required this.userId,
    required this.alertId,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.geoAddress,
    this.detailAddress,
  });
}
