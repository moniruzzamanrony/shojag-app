import 'package:app/core/network/base_api_service.dart';
import 'package:app/feature/profile/data/model/device_token_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/device_token_update_remote_response_model.dart';
import 'package:app/feature/profile/data/model/user_location_update_remote_post_model.dart';
import 'package:app/feature/profile/data/model/user_location_update_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../model/logout_user_remote_response_model.dart';
import '../model/profile_picture_update_remote_post_model.dart';
import '../model/profile_picture_update_remote_response_model.dart';
import '../model/profile_update_remote_post_model.dart';
import '../model/profile_update_remote_response_model.dart';

abstract class IProfileRemoteService {
  final BaseApiService apiService;

  IProfileRemoteService(this.apiService);

  Future<Either<Failure, ProfileUpdateRemoteResponseModel>> updateProfile(
    ProfileUpdateRemotePostModel model, {
    required String token,
  });

  Future<Either<Failure, ProfilePictureUpdateRemoteResponseModel>> updateProfilePic(
    ProfilePictureUpdateRemotePostModel model, {
    required String token,
  });

  Future<Either<Failure, DeviceTokenUpdateRemoteResponseModel>> updateDeviceToken(
    DeviceTokenUpdateRemotePostModel model, {
    required String token,
  });

  Future<Either<Failure, UserLocationUpdateRemoteResponseModel>> updateUserLocation(
    UserLocationUpdateRemotePostModel model, {
    required String token,
  });

  Future<Either<Failure, LogoutUserRemoteResponseModel>> logoutUser({required String token});
}

class ProfileRemoteService extends IProfileRemoteService {
  ProfileRemoteService(super.apiService);

  @override
  Future<Either<Failure, ProfileUpdateRemoteResponseModel>> updateProfile(
    ProfileUpdateRemotePostModel model, {
    required String token,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.updateProfileEndPoint,
      data: model.toMap(),
      fromJson: ProfileUpdateRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, ProfilePictureUpdateRemoteResponseModel>> updateProfilePic(
    ProfilePictureUpdateRemotePostModel model, {
    required String token,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.updateProfilePicEndPoint,
      data: model.toMap(),
      fromJson: ProfilePictureUpdateRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, DeviceTokenUpdateRemoteResponseModel>> updateDeviceToken(
    DeviceTokenUpdateRemotePostModel model, {
    required String token,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.updateDeviceTokenEndPoint,
      data: model.toMap(),
      fromJson: DeviceTokenUpdateRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, UserLocationUpdateRemoteResponseModel>> updateUserLocation(
    UserLocationUpdateRemotePostModel model, {
    required String token,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.updateUserLocationEndPoint,
      data: model.toMap(),
      fromJson: UserLocationUpdateRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, LogoutUserRemoteResponseModel>> logoutUser({required String token}) {
    return apiService.post(
      token: token,
      data: {},
      endPoint: ApiConstants.logoutUserEndPoint,
      fromJson: LogoutUserRemoteResponseModel.fromJson,
    );
  }
}
