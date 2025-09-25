import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the radius,
///  typically used to determine the radius of user choice.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// get the radius.
class RadiusGetUseCase implements UseCaseWithOutFuture<num, NoParams> {
  final CommonRepository repository;

  const RadiusGetUseCase(this.repository);

  @override
  Either<Failure, num> call(NoParams params) {
    final session = repository.getRadius();
    return session.fold((l) => Left(l), (r) => Right(r.radius));
  }
}
