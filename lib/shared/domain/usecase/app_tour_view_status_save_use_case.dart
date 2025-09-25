import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the app tour view status,
/// typically used after the user has completed the onboarding or tour.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the app tour view status.
class AppTourViewStatusSaveUseCase
    implements UseCase<void, AppTourViewStatusSaveParams> {
  final CommonRepository repository;

  const AppTourViewStatusSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AppTourViewStatusSaveParams params) async {
    return await repository.saveAppTourViewStatus(params.status);
  }
}

class AppTourViewStatusSaveParams {
  final bool status;

  const AppTourViewStatusSaveParams({required this.status});
}
