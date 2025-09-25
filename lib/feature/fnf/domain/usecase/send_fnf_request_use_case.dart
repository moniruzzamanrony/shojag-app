import 'package:app/feature/fnf/data/model/request/send_request_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class SendFnfRequestUseCase implements UseCase<bool, SendFnfRequestParam> {
  final FnfRepository repository;

  const SendFnfRequestUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendFnfRequestParam params) async {
    final response = await repository.sendFnfRequestRemote(
        token: params.token,
        model: SendRequestRemotePostModel(
            senderId: params.senderId, receiverId: params.receiverId));
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

class SendFnfRequestParam {
  final String token;
  final int senderId;
  final int receiverId;

  const SendFnfRequestParam({
    required this.token,
    required this.senderId,
    required this.receiverId,
  });
}
