import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the remember auth info,
/// like email/phone or any other info that the user choose to remember.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the remember auth info.
class RememberAuthInfoGetUseCase implements UseCaseWithOutFuture<String?, NoParams> {
  final CommonRepository repository;

  RememberAuthInfoGetUseCase(this.repository);

  @override
  Either<Failure, String?> call(NoParams params) {
    final session = repository.getRememberAuthInfo();
    return session.fold(
      (l) => Left(l),
      (r) {
        return Right(r);
      },
    );
  }
}
