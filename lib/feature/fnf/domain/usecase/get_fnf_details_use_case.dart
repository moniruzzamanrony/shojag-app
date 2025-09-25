import 'package:app/core/utils/enums/location_sharing_time_type.dart';
import 'package:app/core/utils/extension/string_extension.dart';
import 'package:app/feature/fnf/data/model/detail/fnf_details_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enums/fnf_status.dart';
import '../entity/fnf_list_entity.dart';

class GetFnfDetailsUseCase
    implements UseCase<FnfListEntity, GetFnfDetailsParam> {
  final FnfRepository repository;

  const GetFnfDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, FnfListEntity>> call(GetFnfDetailsParam params) async {
    final response = await repository.fnfDetailsRemote(
        token: params.token,
        model: FnfDetailsRemotePostModel(friendId: params.fnfId));
    return response.fold((l) {
      return Left(l);
    }, (r) {
      if (r.success == true) {
        final element = r.data;
        if (element != null) {
          final model = FnfListEntity(
              id: element.id?.toInt() ?? 0,
              userId: element.userId?.toInt() ?? 0,
              userName: element.userName ?? '',
              userPhone: element.userPhone ?? '',
              image: element.image,
              premiumStatus: element.premiumStatus ?? false,
              selfLocationSharingTimeType: LocationSharingTimeType.fromString(
                  element.selfShareStatus ?? ''),
              selfLocationPermissionExpireAt: element.selfTimeLimit?.toDateTime,
              friendLocationSharingTimeType: LocationSharingTimeType.fromString(
                  element.friendShareStatus ?? ''),
              friendLocationPermissionExpireAt:
                  element.friendTimeLimit?.toDateTime,
              latitude: element.latitude?.toDouble(),
              longitude: element.longitude?.toDouble(),
              locationLastUpdateTime: element.locationUpdateTime.toDateTime,
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
                  : null);
          return Right(model);
        }
      }
      return Left(ServerFailure(r.message ?? ''));
    });
  }
}

class GetFnfDetailsParam {
  final String token;
  final int fnfId;

  const GetFnfDetailsParam({
    required this.token,
    required this.fnfId,
  });
}
