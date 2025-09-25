import 'package:app/feature/auth/data/model/registration/verify_phone_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/otp_verify_entity.dart';
import '../repository/auth_repository.dart';

class VerifyPhoneUseCase
    implements UseCase<OtpVerifyEntity, VerifyPhoneParams> {
  final AuthRepository repository;

  const VerifyPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, OtpVerifyEntity>> call(
      VerifyPhoneParams params) async {
    try {
      final remoteResponseModel = await repository
          .verifyPhoneRemote(VerifyPhonePostModel(phone: params.phone));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final entity = OtpVerifyEntity(id: model.tempId ?? 0);
          return Right(entity);
        }
        return Left(ApiFailure(model.message ?? 'Api Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class VerifyPhoneParams {
  final String phone;

  const VerifyPhoneParams({required this.phone});
}
