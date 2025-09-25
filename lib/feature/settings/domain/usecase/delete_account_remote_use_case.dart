import 'package:app/feature/settings/data/model/delete_account_remote_post_model.dart';
import 'package:app/feature/settings/domain/repository/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteAccountRemoteUseCase
    implements UseCase<bool, DeleteAccountRemoteParam> {
  final SettingsRepository repository;

  const DeleteAccountRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteAccountRemoteParam params) async {
    final response = await repository.deleteAccountRemote(
        token: params.token,
        model: DeleteAccountRemotePostModel(
            userId: params.userId, password: params.password));
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

class DeleteAccountRemoteParam {
  final String token;
  final int userId;
  final String password;

  const DeleteAccountRemoteParam({
    required this.token,
    required this.userId,
    required this.password,
  });
}
