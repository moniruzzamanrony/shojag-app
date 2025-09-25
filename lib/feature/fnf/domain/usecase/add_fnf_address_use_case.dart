import 'package:app/feature/fnf/data/model/address/fnf_location_add_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AddFnfAddressUseCase implements UseCase<bool, AddFnfAddressParam> {
  final FnfRepository repository;

  const AddFnfAddressUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddFnfAddressParam params) async {
    final response = await repository.addFnfAddressRemote(
        token: params.token,
        model: FnfLocationAddRemotePostModel(
            fnfId: params.fnfId,
            userId: params.userId,
            label: params.label,
            latitude: params.latitude,
            longitude: params.longitude));
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message));
      },
    );
  }
}

class AddFnfAddressParam {
  final String token;
  final int fnfId;
  final int userId;
  final String label;
  final double latitude;
  final double longitude;

  const AddFnfAddressParam({
    required this.token,
    required this.fnfId,
    required this.userId,
    required this.label,
    required this.latitude,
    required this.longitude,
  });
}
