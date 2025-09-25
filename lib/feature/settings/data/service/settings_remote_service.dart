import 'package:app/core/network/base_api_service.dart';
import 'package:app/core/utils/constants/api_constants.dart';
import 'package:app/feature/settings/data/model/area_limit_remote_response_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_post_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_response_model.dart';
import 'package:app/feature/settings/data/model/update_password_remote_post_model.dart';
import 'package:app/feature/settings/data/model/update_password_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../model/area_limit_remote_post_model.dart';

abstract class ISettingsRemoteService {
  final BaseApiService apiService;

  ISettingsRemoteService(this.apiService);

  Future<Either<Failure, AreaLimitRemoteResponseModel>> areaLimitUpdate(
      {required String token, required AreaLimitRemotePostModel model});

  Future<Either<Failure, UpdatePasswordRemoteResponseModel>> updatePassword(
      {required String token, required UpdatePasswordRemotePostModel model});

  Future<Either<Failure, DeleteAccountRemoteResponseModel>> deleteAccount(
      {required String token, required DeleteAccountRemotePostModel model});
}

class SettingsRemoteService extends ISettingsRemoteService {
  SettingsRemoteService(super.apiService);

  @override
  Future<Either<Failure, AreaLimitRemoteResponseModel>> areaLimitUpdate(
      {required String token, required AreaLimitRemotePostModel model}) {
    return apiService.post(
        token: token,
        endPoint: ApiConstants.areaLimitUpdateEndPoint,
        data: model.toMap(),
        fromJson: AreaLimitRemoteResponseModel.fromJson);
  }

  @override
  Future<Either<Failure, UpdatePasswordRemoteResponseModel>> updatePassword(
      {required String token, required UpdatePasswordRemotePostModel model}) {
    return apiService.post(
        token: token,
        endPoint: ApiConstants.updatePasswordEndPoint,
        data: model.toMap(),
        fromJson: UpdatePasswordRemoteResponseModel.fromJson);
  }

  @override
  Future<Either<Failure, DeleteAccountRemoteResponseModel>> deleteAccount(
      {required String token, required DeleteAccountRemotePostModel model}) {
    return apiService.post(
        token: token,
        endPoint: ApiConstants.deleteAccountEndPoint,
        data: model.toMap(),
        fromJson: DeleteAccountRemoteResponseModel.fromJson);
  }
}
