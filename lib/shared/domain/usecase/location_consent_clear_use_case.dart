import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the location consent,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the location consent.
class LocationConsentClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const LocationConsentClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearLocationConsent();
  }
}
