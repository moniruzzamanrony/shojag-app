import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the last location,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the last location.
class LastLocationClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const LastLocationClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearLastLocation();
  }
}
