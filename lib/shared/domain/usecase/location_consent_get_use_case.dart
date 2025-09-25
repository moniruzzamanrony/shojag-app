import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the location consent,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// get the location consent.
class LocationConsentGetUseCase
    implements UseCaseWithOutFuture<bool, NoParams> {
  final CommonRepository repository;

  const LocationConsentGetUseCase(this.repository);

  @override
  Either<Failure, bool> call(NoParams params) {
    final session = repository.getLocationConsent();
    return session.fold((l) => Left(l), (r) => Right(r));
  }
}
