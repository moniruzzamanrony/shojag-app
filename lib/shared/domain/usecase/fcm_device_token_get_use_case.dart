import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the FCM device token,
/// typically used to send notifications to the user.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the FCM device token.
class FcmDeviceTokenGetUseCase implements UseCaseWithOutFuture<String?, NoParams> {
  final CommonRepository repository;

  const FcmDeviceTokenGetUseCase(this.repository);

  @override
  Either<Failure, String?> call(NoParams params) {
    return repository.getDeviceFCMToken();
  }
}
