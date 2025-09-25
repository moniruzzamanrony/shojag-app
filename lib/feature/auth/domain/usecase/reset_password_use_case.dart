import 'package:app/feature/auth/data/model/forgot_password/reset_password_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<bool, UpdatePasswordParams> {
  final AuthRepository repository;

  const ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdatePasswordParams params) async {
    try {
      final remoteResponseModel = await repository.resetPasswordRemote(
          ResetPasswordRemotePostModel(
              userId: params.userId,
              token: params.token,
              password: params.password));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          return const Right(true);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class UpdatePasswordParams {
  final int userId;
  final String password;
  final String token;

  const UpdatePasswordParams(
      {required this.userId, required this.password, required this.token});
}
