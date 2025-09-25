import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the location consent,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the location consent.
class LocationConsentSaveUseCase
    implements UseCase<void, LocationConsentSaveParams> {
  final CommonRepository repository;

  const LocationConsentSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LocationConsentSaveParams params) async {
    return await repository.saveLocationConsent(params.consent);
  }
}

class LocationConsentSaveParams {
  final bool consent;

  const LocationConsentSaveParams({required this.consent});
}
