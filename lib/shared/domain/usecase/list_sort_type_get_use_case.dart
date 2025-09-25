import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../core/utils/enums/sort_type.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the list sort type,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the list sort type.
class ListSortTypeGetUseCase
    implements UseCaseWithOutFuture<SortType?, NoParams> {
  final CommonRepository repository;

  ListSortTypeGetUseCase(this.repository);

  @override
  Either<Failure, SortType?> call(NoParams params) {
    final session = repository.getListSortType();
    return session.fold(
      (l) => Left(l),
      (r) {
        return Right(r.type);
      },
    );
  }
}
