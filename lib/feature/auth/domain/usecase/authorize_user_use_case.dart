import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/authorization_entity.dart';
import '../repository/auth_repository.dart';

class AuthorizeUserUseCase
    implements UseCase<AuthorizationEntity, AuthorizeUserParams> {
  final AuthRepository repository;

  const AuthorizeUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthorizationEntity>> call(
      AuthorizeUserParams params) async {
    try {
      final response = await repository.authorizeUserRemote(params.token);
      return response.map<AuthorizationEntity>(AuthorizationEntity.fromModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class AuthorizeUserParams {
  final String token;

  const AuthorizeUserParams({required this.token});
}
