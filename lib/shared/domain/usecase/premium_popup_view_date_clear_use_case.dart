import 'package:app/feature/premium/domain/repository/premium_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

/// This use case is responsible for clearing the premium popup view date,
/// typically used when the user dismisses the premium popup.
///
/// Depends on [PremiumRepository], which provides the necessary methods to
/// clear the premium popup view date.
class PremiumPopupViewDateClearUseCase implements UseCase<void, NoParams> {
  final PremiumRepository repository;

  const PremiumPopupViewDateClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearPremiumPopupViewDate();
  }
}
