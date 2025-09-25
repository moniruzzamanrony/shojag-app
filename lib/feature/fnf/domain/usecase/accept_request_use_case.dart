import 'package:app/feature/fnf/data/model/request/accept_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AcceptRequestUseCase implements UseCase<bool, AcceptRequestParam> {
  final FnfRepository repository;

  const AcceptRequestUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AcceptRequestParam params) async {
    final response = await repository.acceptFnfRequestRemote(
        token: params.token,
        model: AcceptFnfRemotePostModel(friendId: params.fnfId));
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

class AcceptRequestParam {
  final String token;
  final int fnfId;

  const AcceptRequestParam({
    required this.token,
    required this.fnfId,
  });
}
