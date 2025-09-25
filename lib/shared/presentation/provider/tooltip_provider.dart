import 'package:app/shared/domain/usecase/tooltip_view_date_clear_use_case.dart';
import 'package:app/shared/domain/usecase/tooltip_view_date_get_use_case.dart';
import 'package:app/shared/domain/usecase/tooltip_view_date_save_use_case.dart';

import '../../../core/usecase/usecase.dart';
import '../../../core/utils/resource/dependency_injection.dart';

/// Provider function to handle tooltip view date
/// save and get tooltip view date and clear if needed
class TooltipProvider {
  final _saveTooltipUseCase = getIt<TooltipViewDateSaveUseCase>();
  final _getTooltipUseCase = getIt<TooltipViewDateGetUseCase>();
  final _clearTooltipUseCase = getIt<TooltipViewDateClearUseCase>();

  Future<void> saveTooltipViewDate({required DateTime dateTime}) async {
    await _saveTooltipUseCase
        .call(TooltipViewDateSaveParams(dateTime: dateTime));
  }

  DateTime? getTooltipViewDate() {
    final response = _getTooltipUseCase.call(NoParams());
    return response.fold((l) => null, (r) => r);
  }

  Future<void> clearTooltipViewDate() async {
    await _clearTooltipUseCase.call(NoParams());
  }
}
