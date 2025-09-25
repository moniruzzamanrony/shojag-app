import 'package:app/core/utils/enums/fnf_status.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/domain/entity/search_fnf_result_entity.dart';
import 'package:app/feature/fnf/domain/repository/fnf_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class SearchFnfUseCase
    implements UseCase<SearchFnfResultEntity, SearchFnfParam> {
  final FnfRepository repository;

  const SearchFnfUseCase(this.repository);

  @override
  Future<Either<Failure, SearchFnfResultEntity>> call(
      SearchFnfParam params) async {
    final response = await repository.searchFnfRemote(
        token: params.token,
        model: SearchFnfRemotePostModel(
            phoneNumber: params.phoneNumber));
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        if (r.success == true) {
          return Right(SearchFnfResultEntity(
              userId: r.userId?.toInt() ?? 0,
              userName: r.name ?? '',
              userPhone: r.phone ?? '',
              userImage: r.profilePic,
              fnfStatus: FnfStatus.fromId(r.status?.toInt() ?? 0)));
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class SearchFnfParam {
  final String token;
  final String phoneNumber;

  const SearchFnfParam({
    required this.token,
    required this.phoneNumber,
  });
}
