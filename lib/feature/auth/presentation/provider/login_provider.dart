/*
* provider : login
*/

import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/auth/domain/usecase/login_use_case.dart';

import '../../domain/entity/user_info_entity.dart';

class LoginProvider extends BaseProvider {

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    passwordObscureText= true;
    _isLoginIn = false;
  }

  final StringBuffer _errorMessage = StringBuffer();
  String? get errorMessage =>
      _errorMessage.toString().trim().isEmpty ? null : _errorMessage.toString();
  void setErrorMessage(String message, {bool refresh = true}) {
    _errorMessage.clear();
    _errorMessage.write(message);
    if(refresh) {
      notify();
    }
  }


  bool passwordObscureText =true;

  void togglePasswordObscure() {
    passwordObscureText = !passwordObscureText;
    notify();
  }

  bool _isLoginIn = false;

  bool get isLoginIn => _isLoginIn;

  set isLoginIn(bool value) {
    _isLoginIn = value;
    notify();
  }

  Future<UserInfoEntity?> login({
    required String email,
    required String password,
  }) async {
    _isLoginIn = true;
    notify();

    final loginUseCase = getIt<LoginUseCase>();
    final param = LoginParams(email: email, password: password);
    final response = await loginUseCase(param);
    _isLoginIn = false;
    notify();
    return response.fold(
      (l) {
        return Future.error(l.message);
      },
      (r) {
        return r;
      },
    );
  }
}
