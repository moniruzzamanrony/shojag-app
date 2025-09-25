import 'package:app/feature/alert/data/model/incident_local_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/incident_list_remote_response_model.dart';

class IncidentFetchRemoteListUseCase
    implements UseCase<void, IncidentFetchRemoteListParam> {
  final AlertRepository repository;

  const IncidentFetchRemoteListUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      IncidentFetchRemoteListParam params) async {
    final response =
        await repository.getIncidentListRemote(token: params.token);
    return await response.fold(
      (l) => Left(l),
      (r) async {
        if (r.success == true) {
          final itemList = r.data ?? <Data>[];
          final localList = itemList
              .map(
                (e) => IncidentLocalModel(
                  id: e.id?.toInt(),
                  categoryId: e.categoryId ?? 0,
                  description: e.description ?? '',
                  isOnline: true,
                  titleEn: e.titleEn ?? '',
                  titleBn: e.titleBn ?? '',
                  tags: e.tags ?? '',
                ),
              )
              .toList();

          final localInsertResponse =
              await repository.addIncidentListLocal(modelList: localList);
          return localInsertResponse;
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class IncidentFetchRemoteListParam {
  final String token;

  const IncidentFetchRemoteListParam({required this.token});
}
