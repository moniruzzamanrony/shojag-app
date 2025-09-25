import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the FCM device token,
/// typically used when the user logs out or signs out.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the FCM device token.
class FcmDeviceTokenClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const FcmDeviceTokenClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearDeviceFCMToken();
  }
}
