import 'package:app/feature/premium/domain/repository/premium_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

/// This use case is responsible for saving the premium popup view date,
/// typically used when the user dismisses the premium popup.
///
/// Depends on [PremiumRepository], which provides the necessary methods to
/// save the premium popup view date.
class PremiumPopupViewDateSaveUseCase
    implements UseCase<void, PremiumPopupViewDateSaveParams> {
  final PremiumRepository repository;

  const PremiumPopupViewDateSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      PremiumPopupViewDateSaveParams params) async {
    return await repository.savePremiumPopupViewDate(params.dateTime);
  }
}

class PremiumPopupViewDateSaveParams {
  final DateTime dateTime;

  const PremiumPopupViewDateSaveParams({required this.dateTime});
}
