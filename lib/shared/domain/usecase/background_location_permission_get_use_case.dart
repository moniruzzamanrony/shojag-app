import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the background location permission,
/// typically used to determine if the user has granted location access.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the background location permission.
class BackgroundLocationPermissionGetUseCase
    implements UseCaseWithOutFuture<bool, NoParams> {
  final CommonRepository repository;

  const BackgroundLocationPermissionGetUseCase(this.repository);

  @override
  Either<Failure, bool> call(NoParams params) {
    return repository.getBackgroundLocationPermission();
  }
}
