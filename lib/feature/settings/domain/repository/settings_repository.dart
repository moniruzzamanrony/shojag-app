import 'package:app/feature/settings/data/model/area_limit_remote_response_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_post_model.dart';
import 'package:app/feature/settings/data/model/delete_account_remote_response_model.dart';
import 'package:app/feature/settings/data/service/settings_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/area_limit_remote_post_model.dart';
import '../../data/model/update_password_remote_post_model.dart';
import '../../data/model/update_password_remote_response_model.dart';

abstract class SettingsRepository {
  final ISettingsRemoteService remoteService;

  const SettingsRepository({required this.remoteService});

  Future<Either<Failure, AreaLimitRemoteResponseModel>> areaLimitUpdateRemote(
      {required String token, required AreaLimitRemotePostModel model});

  Future<Either<Failure, UpdatePasswordRemoteResponseModel>>
      updatePasswordRemote(
          {required String token,
          required UpdatePasswordRemotePostModel model});

  Future<Either<Failure, DeleteAccountRemoteResponseModel>> deleteAccountRemote(
      {required String token, required DeleteAccountRemotePostModel model});
}
