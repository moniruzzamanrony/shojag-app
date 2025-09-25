import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/helper/datetime_helper.dart';
import 'package:app/feature/alert/data/model/details/alert_details_remote_post_model.dart';
import 'package:app/feature/alert/domain/entity/alert_details_entity.dart';
import 'package:app/feature/alert/domain/entity/alert_entity.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/enums/alert_status.dart';
import '../../../../core/utils/enums/alert_type.dart';
import '../entity/alert_response_entity.dart';

class AlertDetailRemoteUseCase
    implements UseCase<AlertDetailsEntity, AlertDetailRemoteParam> {
  final AlertRepository repository;

  const AlertDetailRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, AlertDetailsEntity>> call(
      AlertDetailRemoteParam params) async {
    final response = await repository.alertDetailRemote(
        token: params.token,
        model: AlertDetailsRemotePostModel(
            alertId: params.alertId, requestUserId: params.userId));
    return response.fold(
          (l) => Left(l),
      (r) {
        if (r.success == true) {
          List<AlertResponseEntity> responseEntityList = [];
          responseEntityList = r.responseList
                  ?.map(
                    (element) => AlertResponseEntity(
                      userId: element.responderId!.toInt(),
                      userType: UserType.fromId(element.responderType!.toInt()),
                      name: element.userName!,
                      latitude: element.responderLat!.toDouble(),
                      longitude: element.responderLong!.toDouble(),
                      locationUpdatedAt: getDateTimeFromString(
                          date: element.locationUpdatedAt),
                      message: element.responseMessage,
                      image: element.profileImage,
                      createdAt: getDateTimeFromString(date: element.createdAt),
                      updatedAt: getDateTimeFromString(date: element.updatedAt),
                    ),
                  )
                  .toList() ??
              <AlertResponseEntity>[];

          final e = r.alert;
          final alert = AlertEntity(
            id: e?.id?.toInt() ?? 0,
            userId: e?.userId?.toInt() ?? 0,
            userName: e?.userName ?? '',
            userPhone: e?.userPhone,
            alertCategories: e?.categoryIds
                    ?.split(AppConstants.arraySplitter)
                    .map(
                      (el) => AlertType.fromId(int.tryParse(el) ?? 0),
                    )
                    .where(
                      (t) => t != AlertType.none,
                    )
                    .toList() ??
                [],
            incidentTitle: e?.incidentTitle ?? '',
            description: e?.description,
            address: e?.address,
            geoAddress: e?.geoAddress,
            image: e?.image,
            status: AlertStatus.fromId(e?.status?.toInt() ?? 0),
            latitude: e?.latitude?.toDouble() ?? 0,
            longitude: e?.longitude?.toDouble() ?? 0,
            distance: e?.distance?.toDouble() ?? 0,
            createdAt: getDateTimeFromString(date: e?.createdAt),
          );

          return Right(AlertDetailsEntity(
              responseList: responseEntityList, alert: alert));
        } else {
          return Left(ServerFailure(r.message ?? ''));
        }
      },
    );
  }
}

class AlertDetailRemoteParam {
  final String token;
  final int alertId;
  final int userId;

  const AlertDetailRemoteParam({
    required this.token,
    required this.alertId,
    required this.userId,
  });
}
