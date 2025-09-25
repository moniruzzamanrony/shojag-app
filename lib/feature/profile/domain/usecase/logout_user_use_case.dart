import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class LogoutUserUseCase extends UseCase<bool, LogoutUserParam> {
  final ProfileRepository repository;

  LogoutUserUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LogoutUserParam params) async {
    final response = await repository.logoutUserRemote(token: params.token);
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

class LogoutUserParam {
  String token;

  LogoutUserParam({
    required this.token,
  });
}
