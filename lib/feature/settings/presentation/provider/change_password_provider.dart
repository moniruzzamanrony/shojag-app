import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/settings/domain/usecase/update_password_remote_use_case.dart';

import '../../../../core/config/provider/base_provider.dart';

class ChangePasswordProvider extends BaseProvider {

  bool passwordObscureText = true;

  void togglePasswordObscure() {
    passwordObscureText = !passwordObscureText;
    notify();
  }

  Future<bool> updatePassword(
      {required String token,
      required int userId,
      required String oldPassword,
      required String newPassword}) async {
    final updatePassword = getIt<UpdatePasswordRemoteUseCase>();

    final param = UpdatePasswordRemoteParam(
        token: token,
        userId: userId,
        oldPassword: oldPassword,
        newPassword: newPassword);
    final response = await updatePassword(param);
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    passwordObscureText = true;
  }
}
