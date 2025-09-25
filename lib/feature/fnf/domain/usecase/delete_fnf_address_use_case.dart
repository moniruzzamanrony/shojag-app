import 'package:app/feature/fnf/data/model/address/fnf_location_delete_remote_post_model.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteFnfAddressUseCase implements UseCase<bool, DeleteFnfAddressParam> {
  final FnfRepository repository;

  const DeleteFnfAddressUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteFnfAddressParam params) async {
    final response = await repository.deleteFnfAddressRemote(
        token: params.token,
        model: FnfLocationDeleteRemotePostModel(
            fnfLocationId: params.fnfLocationId));
    return await response.fold(
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

class DeleteFnfAddressParam {
  final String token;
  final int fnfLocationId;

  const DeleteFnfAddressParam({required this.token, required this.fnfLocationId});
}
