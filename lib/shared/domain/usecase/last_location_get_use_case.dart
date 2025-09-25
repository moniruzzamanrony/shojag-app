import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the last location,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the last location.
class LastLocationGetUseCase
    implements UseCaseWithOutFuture<LatLng?, NoParams> {
  final CommonRepository repository;

  const LastLocationGetUseCase(this.repository);

  @override
  Either<Failure, LatLng?> call(NoParams params) {
    final session = repository.getLastLocation();
    return session.fold(
      (l) => Left(l),
      (r) {
        if (r == null) {
          return const Right(null);
        }

        return Right(LatLng(r.latitude, r.longitude));
      },
    );
  }
}
