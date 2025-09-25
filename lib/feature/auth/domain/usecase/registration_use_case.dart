import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/string_extension.dart';
import 'package:app/feature/auth/data/model/registration/registration_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enums/gender.dart';
import '../../../premium/domain/entity/premium_entity.dart';
import '../entity/user_info_entity.dart';
import '../repository/auth_repository.dart';

class RegistrationUseCase
    implements UseCase<UserInfoEntity, RegistrationParams> {
  final AuthRepository repository;

  const RegistrationUseCase(this.repository);

  @override
  Future<Either<Failure, UserInfoEntity>> call(
      RegistrationParams params) async {
    try {
      final remoteResponseModel =
          await repository.registrationRemote(RegistrationRemotePostModel(
        tempId: params.tempId,
        token: params.token,
        typeId: params.typeId,
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        gender: params.gender,
        password: params.password,
        thanaId: params.thanaId,
        policeId: params.policeId,
        fireStation: params.fireStation,
        hospitalOrAgency: params.hospitalOrAgency,
        latitude: params.latitude,
        longitude: params.longitude,
        deviceToken: params.deviceToken,
      ));
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

class RegistrationParams {
  final int tempId;
  final String token;
  final int typeId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? gender;
  final String password;
  final int? thanaId;
  final String? policeId;
  final String? fireStation;
  final String? hospitalOrAgency;
  final double? latitude;
  final double? longitude;
  final String? deviceToken;

  const RegistrationParams({
    required this.tempId,
    required this.token,
    required this.typeId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.gender,
    required this.password,
    this.thanaId,
    this.policeId,
    this.fireStation,
    this.hospitalOrAgency,
    this.latitude,
    this.longitude,
    this.deviceToken,
  });
}
