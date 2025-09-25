import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../feature/premium/domain/repository/premium_repository.dart';

/// This use case is responsible for retrieving the premium popup view date,
/// typically used to determine if the premium popup should be shown.
///
/// Depends on [PremiumRepository], which provides the necessary methods to
/// retrieve the premium popup view date.
class PremiumPopupViewDateGetUseCase
    implements UseCaseWithOutFuture<DateTime, NoParams> {
  final PremiumRepository repository;

  const PremiumPopupViewDateGetUseCase(this.repository);

  @override
  Either<Failure, DateTime> call(NoParams params) {
    final session = repository.getPremiumPopupViewDate();
    return session.fold((l) => Left(l), (r) => Right(r));
  }
}
