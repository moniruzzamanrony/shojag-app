import 'package:app/feature/auth/data/model/forgot_password/forgot_password_email_phone_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_email_phone_remote_response_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_otp_verify_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_otp_verify_remote_response_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/reset_password_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/reset_password_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/otp_verify_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/thana_list_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/verify_phone_remote_response_model.dart';
import 'package:app/feature/auth/data/model/user_authorization/user_authorization_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/login/login_remote_post_model.dart';
import '../model/login/login_remote_response_model.dart';
import '../model/registration/otp_verify_remote_response_model.dart';
import '../model/registration/registration_remote_post_model.dart';
import '../model/registration/registration_remote_response_model.dart';
import '../model/registration/verify_phone_remote_post_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, ThanaListRemoteResponseModel>> getThanaList() {
    return remoteService.getThanaList();
  }

  @override
  Future<Either<Failure, LoginRemoteResponseModel>> loginRemote(
      LoginRemotePostModel model) {
    return remoteService.login(model);
  }

  @override
  Future<Either<Failure, RegistrationRemoteResponseModel>> registrationRemote(
      RegistrationRemotePostModel model) {
    return remoteService.registration(model);
  }

  @override
  Future<Either<Failure, OtpVerifyRemoteResponseModel>> verifyOtpRemote(
      OtpVerifyRemotePostModel model) {
    return remoteService.verifyOtp(model);
  }

  @override
  Future<Either<Failure, VerifyPhoneResponseModel>> verifyPhoneRemote(
      VerifyPhonePostModel model) {
    return remoteService.verifyPhone(model);
  }

  @override
  Future<Either<Failure, ForgotPasswordEmailPhoneRemoteResponseModel>>
      forgotPasswordEmailOrPhoneRemote(
          ForgotPasswordEmailPhoneRemotePostModel model) {
    return remoteService.forgotPasswordEmailOrPhone(model);
  }

  @override
  Future<Either<Failure, ForgotPasswordOtpVerifyRemoteResponseModel>>
      forgotPasswordOtpVerifyRemote(
          ForgotPasswordOtpVerifyRemotePostModel model) {
    return remoteService.forgotPasswordOtpVerify(model);
  }

  @override
  Future<Either<Failure, ResetPasswordRemoteResponseModel>> resetPasswordRemote(
      ResetPasswordRemotePostModel model) {
    return remoteService.resetPassword(model);
  }

  @override
  Future<Either<Failure, UserAuthorizationRemoteResponseModel>>
      authorizeUserRemote(String token) {
    return remoteService.authorizeUser(token);
  }
}
