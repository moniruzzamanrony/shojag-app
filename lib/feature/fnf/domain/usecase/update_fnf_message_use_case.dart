import 'package:app/feature/fnf/data/model/message/fnf_message_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateFnfMessageUseCase implements UseCase<bool, UpdateFnfMessageParam> {
  final FnfRepository repository;

  const UpdateFnfMessageUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateFnfMessageParam params) async {
    final response = await repository.updateFnfMessage(
        token: params.token,
        model: FnfMessageRemotePostModel(
          fnfId: params.fnfId,
          userId: params.userId,
          message: params.message,
        ));
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

class UpdateFnfMessageParam {
  final String token;
  final int fnfId;
  final int userId;
  final String message;

  const UpdateFnfMessageParam({
    required this.token,
    required this.fnfId,
    required this.userId,
    required this.message,
  });
}
