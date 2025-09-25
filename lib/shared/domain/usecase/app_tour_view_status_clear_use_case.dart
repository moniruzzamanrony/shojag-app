import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the app tour view status,
/// typically used after the user has completed the onboarding or tour.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the app tour view status.
class AppTourViewStatusClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const AppTourViewStatusClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearAppTourViewStatus();
  }
}
