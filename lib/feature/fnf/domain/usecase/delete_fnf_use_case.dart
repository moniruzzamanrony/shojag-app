import 'package:app/feature/fnf/data/model/delete/delete_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteFnfUseCase implements UseCase<bool, DeleteFnfParam> {
  final FnfRepository repository;

  const DeleteFnfUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteFnfParam params) async {
    final response = await repository.deleteFnfRemote(
        token: params.token,
        model: DeleteFnfRemotePostModel(
            friendId: params.fnfId, userId: params.userId));
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

class DeleteFnfParam {
  final String token;
  final int userId;
  final int fnfId;

  const DeleteFnfParam({
    required this.token,
    required this.userId,
    required this.fnfId,
  });
}
