import 'package:app/core/error/data_state.dart';
import 'package:app/feature/profile/data/model/device_token_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/device_token_update_remote_response_model.dart';
import 'package:app/feature/profile/data/model/logout_user_remote_response_model.dart';
import 'package:app/feature/profile/data/model/profile_picture_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/profile_picture_update_remote_response_model.dart';
import 'package:app/feature/profile/data/model/profile_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/profile_update_remote_response_model.dart';
import 'package:app/feature/profile/data/model/user_location_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/user_location_update_remote_response_model.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, ProfileUpdateRemoteResponseModel>> updateProfileRemote(
      ProfileUpdateRemotePostModel model,
      {required String token}) {
    return remoteService.updateProfile(model, token: token);
  }

  @override
  Future<Either<Failure, ProfilePictureUpdateRemoteResponseModel>>
      updateProfilePicRemote(ProfilePictureUpdateRemotePostModel model,
          {required String token}) {
    return remoteService.updateProfilePic(model, token: token);
  }

  @override
  Future<Either<Failure, DeviceTokenUpdateRemoteResponseModel>>
      updateDeviceTokenRemote(DeviceTokenUpdateRemotePostModel model,
          {required String token}) {
    return remoteService.updateDeviceToken(model, token: token);
  }

  @override
  Future<Either<Failure, UserLocationUpdateRemoteResponseModel>>
      updateUserLocationRemote(UserLocationUpdateRemotePostModel model,
          {required String token}) {
    return remoteService.updateUserLocation(model, token: token);
  }

  @override
  Future<Either<Failure, LogoutUserRemoteResponseModel>> logoutUserRemote(
      {required String token}) {
    return remoteService.logoutUser(token: token);
  }
}
