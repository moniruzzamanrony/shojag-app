import 'package:app/core/error/data_state.dart';
import 'package:app/feature/settings/data/model/area_limit_remote_post_model.dart';
import 'package:app/feature/settings/data/model/area_limit_remote_response_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_post_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_response_model.dart';
import 'package:app/feature/settings/data/model/update_password_remote_post_model.dart';
import 'package:app/feature/settings/data/model/update_password_remote_response_model.dart';
import 'package:app/feature/settings/domain/repository/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  const SettingsRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, AreaLimitRemoteResponseModel>> areaLimitUpdateRemote(
      {required String token, required AreaLimitRemotePostModel model}) async {
    return await remoteService.areaLimitUpdate(token: token, model: model);
  }

  @override
  Future<Either<Failure, UpdatePasswordRemoteResponseModel>>
      updatePasswordRemote(
          {required String token,
          required UpdatePasswordRemotePostModel model})  {
    return  remoteService.updatePassword(token: token, model: model);
  }

  @override
  Future<Either<Failure, DeleteAccountRemoteResponseModel>> deleteAccountRemote(
      {required String token,
      required DeleteAccountRemotePostModel model})  {
    return  remoteService.deleteAccount(token: token, model: model);
  }
}
