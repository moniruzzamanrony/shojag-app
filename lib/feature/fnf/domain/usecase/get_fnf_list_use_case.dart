import 'package:app/core/utils/enums/fnf_status.dart';
import 'package:app/core/utils/enums/location_sharing_time_type.dart';
import 'package:app/core/utils/extension/string_extension.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/list/fnf_list_remote_post_model.dart';
import '../entity/fnf_list_entity.dart';

class GetFnfListUseCase
    implements UseCase<List<FnfListEntity>, GetFnfListParam> {
  final FnfRepository repository;

  const GetFnfListUseCase(this.repository);

  @override
  Future<Either<Failure, List<FnfListEntity>>> call(
      GetFnfListParam params) async {
    final response = await repository.fnfListRemote(
        token: params.token,
        model: FnfListRemotePostModel(userId: params.userId));
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        final List<FnfListEntity> list = [];
        if (r.success == true) {
          if (r.data != null) {
            for (final element in r.data!) {
              list.add(
                FnfListEntity(
                    id: element.id?.toInt() ?? 0,
                    userId: element.userId?.toInt() ?? 0,
                    userName: element.userName ?? '',
                    userPhone: element.userPhone ?? '',
                    image: element.image,
                    premiumStatus: element.premiumStatus ?? false,
                    selfLocationSharingTimeType:
                        LocationSharingTimeType.fromString(
                            element.selfShareStatus ?? ''),
                    selfLocationPermissionExpireAt:
                        element.selfTimeLimit?.toDateTime,
                    friendLocationSharingTimeType:
                        LocationSharingTimeType.fromString(
                            element.friendShareStatus ?? ''),
                    friendLocationPermissionExpireAt:
                        element.friendTimeLimit?.toDateTime,
                    latitude: element.latitude?.toDouble(),
                    longitude: element.longitude?.toDouble(),
                    locationLastUpdateTime:
                        element.locationUpdateTime.toDateTime,
                    type: element.type ?? '',
                    locations: element.locations
                            ?.map(
                              (loc) => FnfLocationsEntity(
                                  id: loc.id?.toInt() ?? 0,
                                  fnfId: loc.friendId?.toInt() ?? 0,
                                  label: loc.label ?? '',
                                  latitude: loc.latitude?.toDouble() ?? 0.0,
                                  longitude: loc.longitude?.toDouble() ?? 0.0),
                            )
                            .toList() ??
                        [],
                    status: FnfStatus.fromId(element.status?.toInt() ?? 0),
                    message: element.message != null
                        ? FnfMessageEntity(
                            message: element.message,
                            time: element.messageTime.toDateTime)
                        : null),
              );
            }
          }
          return Right(list);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class GetFnfListParam {
  final String token;
  final int userId;

  const GetFnfListParam({
    required this.token,
    required this.userId,
  });
}
