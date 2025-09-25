import 'package:app/core/utils/enums/alert_status.dart';
import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/helper/datetime_helper.dart';
import 'package:app/feature/alert/data/model/list/alert_active_all_remote_post_model.dart';
import 'package:app/feature/alert/domain/entity/alert_all_entity.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/alert_entity.dart';

class AlertGetActiveAllRemoteUseCase
    implements UseCase<AlertAllEntity, AlertGetActiveAllRemoteParam> {
  final AlertRepository repository;

  const AlertGetActiveAllRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, AlertAllEntity>> call(
      AlertGetActiveAllRemoteParam params) async {
    final response = await repository.getAllActiveAlertListRemote(
        token: params.token,
        model: AlertActiveAllRemotePostModel(userId: params.userId));
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.success == true) {
          final entityList = r.data
                  ?.map(
                    (e) => AlertEntity(
                      id: e.id?.toInt() ?? 0,
                      userId: e.userId?.toInt() ?? 0,
                      userName: e.userName ?? '',
                      userPhone: e.userPhone,
                      alertCategories: e.categoryIds
                              ?.split(',')
                              .map(
                                (el) => AlertType.fromId(int.tryParse(el) ?? 0),
                              )
                              .where(
                                (t) => t != AlertType.none,
                              )
                              .toList() ??
                          [],
                      incidentTitle: e.incidentTitle ?? '',
                      incidentCategoryName: e.incidentCategoryName,
                      description: e.description,
                      address: e.address,
                      geoAddress: e.geoAddress,
                      image: e.image,
                      status: AlertStatus.fromId(e.status?.toInt() ?? 0),
                      latitude: e.latitude?.toDouble() ?? 0,
                      longitude: e.longitude?.toDouble() ?? 0,
                      distance: e.distance?.toDouble() ?? 0,
                      createdAt: getDateTimeFromString(date: e.createdAt),
                      updatedAt: getDateTimeFromString(date: e.updatedAt),
                    ),
                  )
                  .toList() ??
              [];

          final entity = AlertAllEntity(
              alerts: entityList,
              latitude: r.userLatitude?.toDouble() ?? 0,
              longitude: r.userLongitude?.toDouble() ?? 0);

          return Right(entity);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class AlertGetActiveAllRemoteParam {
  final String token;
  final int userId;

  const AlertGetActiveAllRemoteParam({
    required this.token,
    required this.userId,
  });
}
