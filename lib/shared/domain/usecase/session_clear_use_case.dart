import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the session,
/// typically used when the user choose to logout.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the session.
class SessionClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const SessionClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearAuthSession();
  }
}
