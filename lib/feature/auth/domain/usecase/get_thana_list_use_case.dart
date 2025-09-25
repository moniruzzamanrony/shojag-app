import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/thana_entity.dart';
import '../repository/auth_repository.dart';

class GetThanaListUseCase implements UseCase<List<ThanaEntity>, NoParams> {
  final AuthRepository repository;

  const GetThanaListUseCase(this.repository);

  @override
  Future<Either<Failure, List<ThanaEntity>>> call(NoParams params) async {
    try {
      final remoteResponseModel = await repository.getThanaList();
      return remoteResponseModel.fold((l) => Left(l), (model) {
        if (model.success == true) {
          final thanaList = model.thana
                  ?.map((e) =>
                      ThanaEntity(id: e.id?.toInt() ?? 0, name: e.name ?? ''))
                  .toList() ??
              <ThanaEntity>[];
          return Right(thanaList);
        }
        return Left(ApiFailure(model.message ?? 'Server Failure'));
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
