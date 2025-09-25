/*
* provider : forgot password
*/

import 'package:app/core/config/provider/base_provider.dart';

import '../../../../core/utils/resource/dependency_injection.dart';
import '../../domain/entity/user_id_with_token_entity.dart';
import '../../domain/usecase/forgot_password_otp_verify_use_case.dart';
import '../../domain/usecase/forgot_password_send_otp_use_case.dart';
import '../../domain/usecase/reset_password_use_case.dart';

class ForgotPasswordProvider extends BaseProvider {
  String? emailOrPhone;
  int? userId;
  UserIdWithTokenEntity? userIdWithTokenViewModel;

  bool isObscureText = true;

  void toggleObscureText() {
    isObscureText = !isObscureText;
    notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    emailOrPhone = null;
    userId = null;
    userIdWithTokenViewModel = null;
    isOtpSending = false;
    isOtpVerifying = false;
    isPasswordUpdating = false;
    isObscureText = true;
  }

  final StringBuffer _errorMessage = StringBuffer();

  String? get errorMessage =>
      _errorMessage.toString().trim().isEmpty ? null : _errorMessage.toString();

  void setErrorMessage(String message, {bool refresh = true}) {
    _errorMessage.clear();
    _errorMessage.write(message);
    if (refresh) {
      notify();
    }
  }

  bool isOtpSending = false;

  Future<int?> sendOtpCode({required String emailOrPhone}) async {
    isOtpSending = true;
    notify();
    final forgotPasswordSendOtpUseCase = getIt<ForgotPasswordSendOtpUseCase>();
    final param = ForgotPasswordSendOtpParams(emailOrPhone: emailOrPhone);
    final response = await forgotPasswordSendOtpUseCase(param);
    isOtpSending = false;
    notify();
    return response.fold(
      (l) {
        return Future.error(l.message);
      },
      (r) {
        return r.id;
      },
    );
  }

  bool isOtpVerifying = false;

  Future<UserIdWithTokenEntity?> verifyOtp(
      {required String otp, required String phone, required int userId}) async {
    isOtpVerifying = true;
    notify();
    final forgotPasswordVerifyOtpUseCase =
        getIt<ForgotPasswordOtpVerifyUseCase>();
    final param =
        ForgotPasswordOtpVerifyParams(otp: otp, userId: userId, phone: phone);
    final response = await forgotPasswordVerifyOtpUseCase(param);
    isOtpVerifying = false;
    notify();
    return response.fold(
      (l) {
        return Future.error(l.message);
      },
      (r) {
        return UserIdWithTokenEntity(userId: r.userId, token: r.token);
      },
    );
  }

  bool isPasswordUpdating = false;

  Future<bool> updatePassword(
      {required String password,
      required String token,
      required int userId}) async {
    isPasswordUpdating = true;
    notify();
    final updatePasswordUseCase = getIt<ResetPasswordUseCase>();

    final param =
        UpdatePasswordParams(userId: userId, password: password, token: token);
    final response = await updatePasswordUseCase(param);
    isPasswordUpdating = false;
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
