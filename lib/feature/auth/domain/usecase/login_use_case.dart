import 'package:app/core/utils/enums/gender.dart';
import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/string_extension.dart';
import 'package:app/feature/auth/data/model/login/login_remote_post_model.dart';
import 'package:app/feature/premium/domain/entity/premium_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_info_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserInfoEntity, LoginParams> {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserInfoEntity>> call(LoginParams params) async {
    try {
      final remoteResponseModel = await repository.loginRemote(
          LoginRemotePostModel(
              emailOrPhone: params.email, password: params.password));
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final entity = UserInfoEntity(
            userId: model.user?.id ?? 0,
            phone: model.user?.phone,
            email: model.user?.email,
            isEmailVerified: model.user?.isEmailVerified ?? false,
            isPhoneVerified: model.user?.isPhoneVerified ?? false,
            userType: UserType.fromId(model.user?.typeId ?? 0),
            firstName: model.user?.firstName ?? '',
            lastName: model.user?.lastName ?? '',
            photo: model.user?.profilePic,
            gender: Gender.fromTitle(model.user?.gender ?? ''),
            dob: model.user?.dob?.toDateTime,
            nid: model.user?.nid,
            address: model.user?.address,
            fireStation: model.user?.fireStation,
            hospitalOrAgency: model.user?.hospitalAgency,
            policeId: model.user?.policeId,
            thana: model.user?.thana,
            areaLimit: model.user?.areaLimit,
            apiToken: model.token,
            premiumInfo: PremiumEntity(
                isPremium: model.user?.premiumInfo?.isPremium == 1,
                expireDate:
                    model.user?.premiumInfo?.premiumExpireAt?.toDateTime ??
                        DateTime(1970),
                currentPackage: '' // TODO: current package update in future
                ),
          );
          return Right(entity);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}
