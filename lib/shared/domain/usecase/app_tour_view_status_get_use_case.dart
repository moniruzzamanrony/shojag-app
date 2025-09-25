import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the app tour view status,
/// typically used to determine if the user has already seen the app tour.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the app tour view status.
class AppTourViewStatusGetUseCase
    implements UseCaseWithOutFuture<bool, NoParams> {
  final CommonRepository repository;

  const AppTourViewStatusGetUseCase(this.repository);

  @override
  Either<Failure, bool> call(NoParams params) {
    final session = repository.getAppTourViewStatus();
    return session.fold((l) => Left(l), (r) => Right(r));
  }
}