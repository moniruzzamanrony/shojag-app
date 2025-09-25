import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the tooltip view date,
/// typically used to determine if the tooltip should be shown.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the tooltip view date.
class TooltipViewDateGetUseCase
    implements UseCaseWithOutFuture<DateTime, NoParams> {
  final CommonRepository repository;

  const TooltipViewDateGetUseCase(this.repository);

  @override
  Either<Failure, DateTime> call(NoParams params) {
    final session = repository.getTooltipViewDate();
    return session.fold((l) => Left(l), (r) => Right(r));
  }
}
