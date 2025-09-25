import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the tooltip view date,
/// typically used when the user clear the tooltip.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the tooltip view date.
class TooltipViewDateClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const TooltipViewDateClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearTooltipViewDate();
  }
}
