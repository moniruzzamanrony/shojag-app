import 'package:app/feature/fnf/data/model/location/location_share_request_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LocationShareRequestUseCase
    implements UseCase<bool, LocationShareRequestParam> {
  final FnfRepository repository;

  const LocationShareRequestUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LocationShareRequestParam params) async {
    final response = await repository.locationShareRequestRemote(
        token: params.token,
        model: LocationShareRequestRemotePostModel(fnfId: params.fnfId));
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

class LocationShareRequestParam {
  final String token;
  final int fnfId;

  const LocationShareRequestParam({
    required this.token,
    required this.fnfId,
  });
}
