import 'package:app/shared/data/model/session_list_sort_type_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../core/utils/enums/sort_type.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the list sort type,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the list sort type.
class ListSortTypeSaveUseCase implements UseCase<void, ListSortTypeSaveParam> {
  final CommonRepository repository;

  const ListSortTypeSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ListSortTypeSaveParam params) async {
    return await repository
        .saveListSortType(SessionListSortTypeModel(type: params.type));
  }
}

class ListSortTypeSaveParam {
  SortType type;

  ListSortTypeSaveParam({required this.type});
}
