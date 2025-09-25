import 'package:app/feature/auth/data/model/forgot_password/forgot_password_email_phone_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/otp_verify_entity.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordSendOtpUseCase
    implements UseCase<OtpVerifyEntity, ForgotPasswordSendOtpParams> {
   final AuthRepository repository;

  const ForgotPasswordSendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, OtpVerifyEntity>> call(
      ForgotPasswordSendOtpParams params) async {
    try {
      final remoteResponseModel =
          await repository.forgotPasswordEmailOrPhoneRemote(
              ForgotPasswordEmailPhoneRemotePostModel(
        emailOrPhone: params.emailOrPhone,
      ));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final entity = OtpVerifyEntity(id: model.userId ?? 0);
          return Right(entity);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class ForgotPasswordSendOtpParams {
  final String emailOrPhone;

  const ForgotPasswordSendOtpParams({required this.emailOrPhone});
}
