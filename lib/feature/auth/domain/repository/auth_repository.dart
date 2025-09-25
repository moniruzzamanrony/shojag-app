import 'package:app/feature/auth/data/model/registration/otp_verify_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/otp_verify_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/verify_phone_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/verify_phone_remote_response_model.dart';
import 'package:app/feature/auth/data/service/auth_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/forgot_password/forgot_password_email_phone_remote_post_model.dart';
import '../../data/model/forgot_password/forgot_password_email_phone_remote_response_model.dart';
import '../../data/model/forgot_password/forgot_password_otp_verify_remote_post_model.dart';
import '../../data/model/forgot_password/forgot_password_otp_verify_remote_response_model.dart';
import '../../data/model/forgot_password/reset_password_remote_post_model.dart';
import '../../data/model/forgot_password/reset_password_remote_response_model.dart';
import '../../data/model/login/login_remote_post_model.dart';
import '../../data/model/login/login_remote_response_model.dart';
import '../../data/model/registration/registration_remote_post_model.dart';
import '../../data/model/registration/registration_remote_response_model.dart';
import '../../data/model/registration/thana_list_remote_response_model.dart';
import '../../data/model/user_authorization/user_authorization_remote_response_model.dart';

abstract class AuthRepository {
  final IAuthRemoteService remoteService;

  const AuthRepository({required this.remoteService});

  Future<Either<Failure, ThanaListRemoteResponseModel>> getThanaList();

  Future<Either<Failure, LoginRemoteResponseModel>> loginRemote(
      LoginRemotePostModel model);

  Future<Either<Failure, RegistrationRemoteResponseModel>> registrationRemote(
      RegistrationRemotePostModel model);

  Future<Either<Failure, VerifyPhoneResponseModel>> verifyPhoneRemote(
      VerifyPhonePostModel model);

  Future<Either<Failure, OtpVerifyRemoteResponseModel>> verifyOtpRemote(
      OtpVerifyRemotePostModel model);

  Future<Either<Failure, ForgotPasswordEmailPhoneRemoteResponseModel>>
      forgotPasswordEmailOrPhoneRemote(
          ForgotPasswordEmailPhoneRemotePostModel model);

  Future<Either<Failure, ForgotPasswordOtpVerifyRemoteResponseModel>>
      forgotPasswordOtpVerifyRemote(
          ForgotPasswordOtpVerifyRemotePostModel model);

  Future<Either<Failure, ResetPasswordRemoteResponseModel>> resetPasswordRemote(
      ResetPasswordRemotePostModel model);

  Future<Either<Failure, UserAuthorizationRemoteResponseModel>>
      authorizeUserRemote(String token);
}
