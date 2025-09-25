import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the background location permission,
/// typically used after the user has granted permission to use background location.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the background location permission.
class BackgroundLocationPermissionClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const BackgroundLocationPermissionClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearBackgroundLocationPermission();
  }
}
