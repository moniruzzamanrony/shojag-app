import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the FCM device token,
/// typically used when the user logs in or signs in.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the FCM device token.
class FcmDeviceTokenSaveUseCase implements UseCase<void, FcmDeviceTokenSaveParams> {
  final CommonRepository repository;

  const FcmDeviceTokenSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(FcmDeviceTokenSaveParams params) async {
    return await repository
        .saveDeviceFCMToken(params.fcmToken);
  }
}

class FcmDeviceTokenSaveParams {
  final String fcmToken;

  const FcmDeviceTokenSaveParams({required this.fcmToken});
}
