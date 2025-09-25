import 'package:app/feature/profile/data/model/device_token_update_remote_post_model.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class DeviceTokenRemoteUpdateUseCase
    implements UseCase<bool, DeviceTokenUpdateParam> {
  final ProfileRepository repository;

  const DeviceTokenRemoteUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeviceTokenUpdateParam params) async {
    final response = await repository.updateDeviceTokenRemote(
        token: params.token,
        DeviceTokenUpdateRemotePostModel(
            userId: params.userId, deviceToken: params.deviceToken));

    return response.map<bool>((a) => a.success == true);
  }
}

class DeviceTokenUpdateParam {
  final String token;
  final String deviceToken;
  final int userId;

  const DeviceTokenUpdateParam({
    required this.token,
    required this.deviceToken,
    required this.userId,
  });
}
