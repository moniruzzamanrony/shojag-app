import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';


/// This use case is responsible for clearing the list sort type,
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the list sort type.
class ListSortTypeClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const ListSortTypeClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearListType();
  }
}
