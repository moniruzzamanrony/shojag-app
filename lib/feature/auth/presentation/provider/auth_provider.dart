import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/auth/domain/entity/authorization_entity.dart';
import 'package:app/feature/auth/domain/usecase/authorize_user_use_case.dart';

class AuthProvider extends BaseProvider {

  Future<AuthorizationEntity?> authorizeUser(String token) async {
    final authorizationUseCase = getIt<AuthorizeUserUseCase>();
    final param = AuthorizeUserParams(token: token);
    final result = await authorizationUseCase.call(param);
    return result.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}
}
