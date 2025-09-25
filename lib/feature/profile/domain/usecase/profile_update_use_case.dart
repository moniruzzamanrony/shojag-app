import 'package:app/feature/profile/data/model/profile_update_remote_post_model.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/profile_update_entity.dart';

class ProfileUpdateUseCase
    implements UseCase<ProfileUpdateEntity, ProfileUpdateParam> {
  final ProfileRepository repository;

  const ProfileUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileUpdateEntity>> call(
      ProfileUpdateParam params) async {
    final response = await repository.updateProfileRemote(
        token: params.token,
        ProfileUpdateRemotePostModel(
            userId: params.userId,
            firstName: params.firstName,
            lastName: params.lastName,
            email: params.email,
            gender: params.gender,
            dob: params.dob,
            nid: params.nid,
            address: params.address,
            thanaId: params.thanaId));
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.success == true) {
          return Right(ProfileUpdateEntity(
            firstName: r.firstName ?? '',
            lastName: r.lastName ?? '',
            nid: r.nid,
            gender: r.gender,
            dob: r.dob,
            address: r.address,
            email: r.email,
            thana: r.thana,
          ));
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class ProfileUpdateParam {
  final String token;
  final int userId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? gender;
  final String? dob;
  final String? nid;
  final String? address;
  final int? thanaId;

  const ProfileUpdateParam({
    required this.token,
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.gender,
    this.dob,
    this.nid,
    this.address,
    this.thanaId,
  });
}
