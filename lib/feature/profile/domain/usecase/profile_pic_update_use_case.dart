import 'dart:io';

import 'package:app/feature/profile/data/model/profile_picture_update_remote_post_model.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/profile_pic_update_entity.dart';

class ProfilePicUpdateUseCase
    extends UseCase<ProfilePicUpdateEntity, ProfilePicUpdateParam> {
  final ProfileRepository repository;

  const ProfilePicUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, ProfilePicUpdateEntity>> call(
      ProfilePicUpdateParam params) async {
    try {
      final profilePic = await MultipartFile.fromFile(params.file.path);
      final response = await repository.updateProfilePicRemote(
          token: params.token,
          ProfilePictureUpdateRemotePostModel(
              userId: params.userId, profilePic: profilePic));
      return await response.fold(
        (l) {
          return Left(l);
        },
        (r) async {
          if (r.success == true) {
            return Right(ProfilePicUpdateEntity(
                status: r.success!, profilePicUrl: r.profilePic));
          }
          return Left(ServerFailure(r.message ?? ''));
        },
      );
    } on Exception catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }
}

class ProfilePicUpdateParam {
  String token;
  int userId;
  File file;

  ProfilePicUpdateParam({
    required this.token,
    required this.userId,
    required this.file,
  });
}
