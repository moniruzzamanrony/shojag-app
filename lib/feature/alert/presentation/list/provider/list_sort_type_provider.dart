import 'package:app/core/config/provider/base_provider.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../core/utils/enums/sort_type.dart';
import '../../../../../core/utils/resource/dependency_injection.dart';
import '../../../../../shared/domain/usecase/list_sort_type_get_use_case.dart';
import '../../../../../shared/domain/usecase/list_sort_type_save_use_case.dart';

class ListSortTypeProvider extends BaseProvider {
  SortType sortType = SortType.distance;

  void updateSortType(SortType type) {
    if (sortType == type) return;
    sortType = type;
    notify();
  }

  void _populateSortType() {
    final sortTypeGetUseCase = getIt<ListSortTypeGetUseCase>();

    final result = sortTypeGetUseCase.call(NoParams());
    result.fold((l) => null, (r) => sortType = r ?? SortType.distance);
  }

  Future<void> saveSortType(SortType type) async {
    final sortTypeSaveUseCase = getIt<ListSortTypeSaveUseCase>();

    await sortTypeSaveUseCase.call(ListSortTypeSaveParam(type: type));
    _populateSortType();
    notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    sortType = SortType.distance;
  }

  ListSortTypeProvider() {
    _populateSortType();
  }
}
