import 'package:app/feature/alert/domain/entity/incident_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/alert_repository.dart';

class IncidentGetLocalListUseCase
    implements UseCase<List<IncidentEntity>, IncidentGetLocalListParam> {
  final AlertRepository repository;

  const IncidentGetLocalListUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentEntity>>> call(
      IncidentGetLocalListParam params) async {
    final result = await repository.getIncidentListLocal(
        id: params.id,
        limit: params.limit,
        offset: params.offset,
        categoryId: params.categoryId,
        isOnline: params.isOnline);

    return result.fold(
      (l) => Left(l),
      (r) {
        final list = r.map((e) => e.toEntity()).toList();
        return Right(list);
      },
    );
  }
}

class IncidentGetLocalListParam {
  final int? id;
  final int? limit;
  final int? offset;
  final int? categoryId;
  final bool? isOnline;

  const IncidentGetLocalListParam({
    this.id,
    this.limit,
    this.offset,
    this.categoryId,
    this.isOnline,
  });
}
