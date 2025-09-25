import 'package:app/shared/data/model/session_area_radius_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the radius,
/// typically used when the user choose to get notifications by radius.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the radius.
class RadiusSaveUseCase implements UseCase<void, RadiusSaveParams> {
  final CommonRepository repository;

  const RadiusSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RadiusSaveParams params) async {
    return await repository
        .saveRadius(SessionAreaRadiusModel(radius: params.radius));
  }
}

class RadiusSaveParams {
  final num radius;

  const RadiusSaveParams({required this.radius});
}
