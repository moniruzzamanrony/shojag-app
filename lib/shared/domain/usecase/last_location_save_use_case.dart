import 'package:app/shared/data/model/session_location_lat_lng_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the last location,
/// typically used when the user logs in or signs in.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the last location.
class LastLocationSaveUseCase implements UseCase<bool, LastLocationSaveParams> {
  final CommonRepository repository;

  const LastLocationSaveUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LastLocationSaveParams params) async {
    try {
      await repository.saveLastLocation(SessionLocationLatLngModel(
          latitude: params.latitude, longitude: params.longitude));
      return const Right(true);
    } catch (e) {
      return Left(DriftFailure(e.toString()));
    }
  }
}

class LastLocationSaveParams {
  final double latitude;
  final double longitude;

 const LastLocationSaveParams({
    required this.latitude,
    required this.longitude,
  });
}
