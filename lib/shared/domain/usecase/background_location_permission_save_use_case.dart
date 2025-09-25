import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the background location permission,
/// typically used after the user has granted permission to use background location.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the background location permission.
class BackgroundLocationPermissionSaveUseCase
    implements UseCase<bool, BackgroundLocationPermissionSaveParams> {
  final CommonRepository repository;

  const BackgroundLocationPermissionSaveUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      BackgroundLocationPermissionSaveParams params) async {
    try {
      await repository.saveBackgroundLocationPermission(params.permission);
      return const Right(true);
    } catch (e) {
      return Left(DriftFailure(e.toString()));
    }
  }
}

class BackgroundLocationPermissionSaveParams {
  final bool permission;

  const BackgroundLocationPermissionSaveParams({required this.permission});
}
