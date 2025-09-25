import 'package:app/feature/alert/data/model/incident_local_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/data_state.dart';

abstract class IAlertLocalService {
  final AppDatabase database;

  const IAlertLocalService(this.database);

  Future<Either<Failure, void>> addIncidentList(
      {required List<IncidentLocalModel> modelList});

  Future<Either<Failure, List<IncidentLocalModel>>> getIncidentList(
      {required int? id,
      required int? categoryId,
      required bool? isOnline,
      required int? limit,
      required int? offset});
}

class AlertLocalService extends IAlertLocalService {
  const AlertLocalService(super.database);

  @override
  Future<Either<Failure, void>> addIncidentList(
      {required List<IncidentLocalModel> modelList}) async {
    try {
      final result = await database.batch((batch) async {
        batch.deleteWhere(database.tableIncident, (tbl) => tbl.isOnline);

        return batch.insertAll(database.tableIncident,
            modelList.map((e) => e.toDriftCompanion()).toList());
      });

      return Right(result);
    } on Exception catch (e) {
      return Left(DriftFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncidentLocalModel>>> getIncidentList(
      {required int? id,
      required int? categoryId,
      required bool? isOnline,
      required int? limit,
      required int? offset}) async {
    try {
      final query = database.select(database.tableIncident);

      if (id != null) {
        query.where((tbl) => tbl.id.equals(id));
      }

      if (categoryId != null) {
        query.where((tbl) => tbl.categoryId.equals(categoryId));
      }
      if (isOnline != null) {
        query.where((tbl) => tbl.isOnline.equals(isOnline));
      }

      if (limit != null) {
        query.limit(limit, offset: offset);
      }

      // query.orderBy([
      //   (tbl) =>
      //       OrderingTerm(expression: tbl.titleBn.upper()),
      //   (tbl) =>
      //       OrderingTerm(expression: tbl.titleBn.lower()),
      // ]);

      final result = await query.get();

      final list = result
          .map((e) => IncidentLocalModel.fromDriftRow(e.toCompanion(true)))
          .toList();

      return Right(list);
    } on Exception catch (e) {
      return Left(DriftFailure(e.toString()));
    }
  }
}
