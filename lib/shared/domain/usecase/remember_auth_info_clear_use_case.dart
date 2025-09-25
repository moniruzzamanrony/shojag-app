import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the remember auth info,
///  typically used when the user choose to clear remember auth info.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the remember auth info.
class RememberAuthInfoClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const RememberAuthInfoClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearRememberAuthInfo();
  }
}
