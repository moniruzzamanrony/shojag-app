import 'package:app/feature/settings/data/model/update_password_remote_post_model.dart';
import 'package:app/feature/settings/domain/repository/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class UpdatePasswordRemoteUseCase
    implements UseCase<bool, UpdatePasswordRemoteParam> {
  final SettingsRepository repository;

  const UpdatePasswordRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdatePasswordRemoteParam params) async {
    final response = await repository.updatePasswordRemote(
        token: params.token,
        model: UpdatePasswordRemotePostModel(
            userId: params.userId,
            oldPassword: params.oldPassword,
            newPassword: params.newPassword));
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

class UpdatePasswordRemoteParam {
  final String token;
  final int userId;
  final String oldPassword;
  final String newPassword;

  const UpdatePasswordRemoteParam({
    required this.token,
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
  });
}
