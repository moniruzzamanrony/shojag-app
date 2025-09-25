import 'package:app/feature/auth/data/model/registration/otp_verify_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/otp_verify_id_and_token_entity.dart';
import '../repository/auth_repository.dart';

class VerifyOtpUseCase
    implements UseCase<OtpVerifyIdAndTokenEntity, VerifyOtpParams> {
  final AuthRepository repository;

  const VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, OtpVerifyIdAndTokenEntity>> call(
      VerifyOtpParams params) async {
    try {
      final remoteResponseModel = await repository.verifyOtpRemote(
          OtpVerifyRemotePostModel(tempId: params.tempId, otp: params.otp));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final entity = OtpVerifyIdAndTokenEntity(
              id: model.tempId ?? 0, token: model.token ?? '');
          return Right(entity);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class VerifyOtpParams {
  final String otp;
  final int tempId;

  const VerifyOtpParams({required this.otp, required this.tempId});
}
