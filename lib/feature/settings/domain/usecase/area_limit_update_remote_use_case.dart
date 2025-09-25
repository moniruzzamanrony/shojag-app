import 'package:app/feature/settings/data/model/area_limit_remote_post_model.dart';
import 'package:app/feature/settings/domain/repository/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AreaLimitUpdateRemoteUseCase
    implements UseCase<bool, AreaLimitUpdateRemoteParam> {
  final SettingsRepository repository;

  const AreaLimitUpdateRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AreaLimitUpdateRemoteParam params) async {
    final response = await repository.areaLimitUpdateRemote(
        token: params.token,
        model: AreaLimitRemotePostModel(
            userId: params.userId, areaLimit: params.areaLimit));
    return await response.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class AreaLimitUpdateRemoteParam {
  final String token;
  final int userId;
  final num areaLimit;

  const AreaLimitUpdateRemoteParam({
    required this.token,
    required this.userId,
    required this.areaLimit,
  });
}
