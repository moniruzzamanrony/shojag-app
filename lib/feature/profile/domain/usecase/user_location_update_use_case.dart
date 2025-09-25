import 'package:app/feature/profile/data/model/user_location_update_remote_post_model.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class UserLocationUpdateUseCase extends UseCase<bool, UserLocationUpdateParam> {
  final ProfileRepository repository;

  UserLocationUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UserLocationUpdateParam params) async {
    final response = await repository.updateUserLocationRemote(
        token: params.token,
        UserLocationUpdateRemotePostModel(
            userId: params.userId,
            longitude: params.longitude,
            latitude: params.latitude));
    return await response.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        if (r.success == true) {
          return  const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class UserLocationUpdateParam {
  String token;
  int userId;
  double latitude;
  double longitude;

  UserLocationUpdateParam({
    required this.token,
    required this.userId,
    required this.latitude,
    required this.longitude,
  });
}
