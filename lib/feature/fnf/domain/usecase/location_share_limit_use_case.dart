
import 'package:app/feature/fnf/data/model/location/location_share_limit_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LocationShareLimitUseCase
    implements UseCase<bool, LocationShareLimitParam> {
  final FnfRepository repository;

  const LocationShareLimitUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LocationShareLimitParam params) async {
    final response = await repository.locationShareTimeLimitRemote(
        token: params.token,
        model: LocationShareLimitRemotePostModel(
            fnfId: params.fnfId,
            shareStatus: params.shareStatus,
            timeLimit: params.timeLimit));
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class LocationShareLimitParam {
  final String token;
  final int fnfId;
  final String shareStatus;
  final String? timeLimit;

  const LocationShareLimitParam(
      {required this.token,
      required this.fnfId,
      required this.shareStatus,
      required this.timeLimit});
}
