import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the tooltip view date,
///  typically used when the user choose to show the tooltip.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the tooltip view date.
class TooltipViewDateSaveUseCase
    implements UseCase<void, TooltipViewDateSaveParams> {
  final CommonRepository repository;

  const TooltipViewDateSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TooltipViewDateSaveParams params) async {
    return await repository.saveTooltipViewDate(params.dateTime);
  }
}

class TooltipViewDateSaveParams {
  final DateTime dateTime;

  const TooltipViewDateSaveParams({required this.dateTime});
}
