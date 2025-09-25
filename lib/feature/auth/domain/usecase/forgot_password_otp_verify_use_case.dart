import 'package:app/feature/auth/data/model/forgot_password/forgot_password_otp_verify_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_id_with_token_entity.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordOtpVerifyUseCase
    implements UseCase<UserIdWithTokenEntity, ForgotPasswordOtpVerifyParams> {
  final AuthRepository repository;

  const ForgotPasswordOtpVerifyUseCase(this.repository);

  @override
  Future<Either<Failure, UserIdWithTokenEntity>> call(
      ForgotPasswordOtpVerifyParams params) async {
    try {
      final remoteResponseModel = await repository
          .forgotPasswordOtpVerifyRemote(ForgotPasswordOtpVerifyRemotePostModel(
        userId: params.userId,
        otp: params.otp,
        phone: params.phone,
      ));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final entity = UserIdWithTokenEntity(
              userId: model.userId ?? 0, token: model.token ?? '');
          return Right(entity);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class ForgotPasswordOtpVerifyParams {
  final int userId;
  final String otp;
  final String phone;

  const ForgotPasswordOtpVerifyParams(
      {required this.otp, required this.userId, required this.phone});
}
