import 'package:app/feature/profile/data/service/profile_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/device_token_update_remote_post_model.dart';
import '../../data/model/device_token_update_remote_response_model.dart';
import '../../data/model/logout_user_remote_response_model.dart';
import '../../data/model/profile_picture_update_remote_post_model.dart';
import '../../data/model/profile_picture_update_remote_response_model.dart';
import '../../data/model/profile_update_remote_post_model.dart';
import '../../data/model/profile_update_remote_response_model.dart';
import '../../data/model/user_location_update_remote_post_model.dart';
import '../../data/model/user_location_update_remote_response_model.dart';

abstract class ProfileRepository {
  final IProfileRemoteService remoteService;

  ProfileRepository({required this.remoteService});

  Future<Either<Failure, ProfileUpdateRemoteResponseModel>> updateProfileRemote(
      ProfileUpdateRemotePostModel model,
      {required String token});

  Future<Either<Failure, ProfilePictureUpdateRemoteResponseModel>>
      updateProfilePicRemote(ProfilePictureUpdateRemotePostModel model,
          {required String token});

  Future<Either<Failure, DeviceTokenUpdateRemoteResponseModel>>
      updateDeviceTokenRemote(DeviceTokenUpdateRemotePostModel model,
          {required String token});

  Future<Either<Failure, UserLocationUpdateRemoteResponseModel>>
      updateUserLocationRemote(UserLocationUpdateRemotePostModel model,
          {required String token});

  Future<Either<Failure, LogoutUserRemoteResponseModel>> logoutUserRemote(
      {required String token});
}
