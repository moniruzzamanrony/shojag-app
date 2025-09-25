import 'package:app/feature/auth/data/model/forgot_password/forgot_password_email_phone_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_email_phone_remote_response_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_otp_verify_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/forgot_password_otp_verify_remote_response_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/reset_password_remote_post_model.dart';
import 'package:app/feature/auth/data/model/forgot_password/reset_password_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/otp_verify_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/otp_verify_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/registration_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/registration_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/thana_list_remote_response_model.dart';
import 'package:app/feature/auth/data/model/registration/verify_phone_remote_post_model.dart';
import 'package:app/feature/auth/data/model/registration/verify_phone_remote_response_model.dart';
import 'package:app/feature/auth/data/model/user_authorization/user_authorization_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/data_state.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../model/login/login_remote_post_model.dart';
import '../model/login/login_remote_response_model.dart';

abstract class IAuthRemoteService {
  final BaseApiService apiService;

  const IAuthRemoteService(this.apiService);

  Future<Either<Failure, ThanaListRemoteResponseModel>> getThanaList();

  Future<Either<Failure, LoginRemoteResponseModel>> login(LoginRemotePostModel model);

  Future<Either<Failure, RegistrationRemoteResponseModel>> registration(RegistrationRemotePostModel model);

  Future<Either<Failure, VerifyPhoneResponseModel>> verifyPhone(VerifyPhonePostModel model);

  Future<Either<Failure, OtpVerifyRemoteResponseModel>> verifyOtp(OtpVerifyRemotePostModel model);

  Future<Either<Failure, ForgotPasswordEmailPhoneRemoteResponseModel>> forgotPasswordEmailOrPhone(
    ForgotPasswordEmailPhoneRemotePostModel model,
  );

  Future<Either<Failure, ForgotPasswordOtpVerifyRemoteResponseModel>> forgotPasswordOtpVerify(
    ForgotPasswordOtpVerifyRemotePostModel model,
  );

  Future<Either<Failure, ResetPasswordRemoteResponseModel>> resetPassword(ResetPasswordRemotePostModel model);

  Future<Either<Failure, UserAuthorizationRemoteResponseModel>> authorizeUser(String token);
}

class AuthRemoteService extends IAuthRemoteService {
  const AuthRemoteService(super.apiService);

  @override
  Future<Either<Failure, ThanaListRemoteResponseModel>> getThanaList() {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.thanaListEndPoint,
      data: {},
      fromJson: ThanaListRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, LoginRemoteResponseModel>> login(LoginRemotePostModel model) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.loginEndPoint,
      data: model.toMap(),
      fromJson: LoginRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, OtpVerifyRemoteResponseModel>> verifyOtp(OtpVerifyRemotePostModel model) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.verifyOtpPoint,
      data: model.toMap(),
      fromJson: OtpVerifyRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, VerifyPhoneResponseModel>> verifyPhone(VerifyPhonePostModel model) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.verifyPhoneEndPoint,
      data: model.toMap(),
      fromJson: VerifyPhoneResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, RegistrationRemoteResponseModel>> registration(RegistrationRemotePostModel model) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.registerEndPoint,
      data: model.toMap(),
      fromJson: RegistrationRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, ForgotPasswordEmailPhoneRemoteResponseModel>> forgotPasswordEmailOrPhone(
    ForgotPasswordEmailPhoneRemotePostModel model,
  ) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.forgotPasswordEmailPhoneEndPoint,
      data: model.toMap(),
      fromJson: ForgotPasswordEmailPhoneRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, ForgotPasswordOtpVerifyRemoteResponseModel>> forgotPasswordOtpVerify(
    ForgotPasswordOtpVerifyRemotePostModel model,
  ) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.forgotPasswordOtpConfirmEndPoint,
      data: model.toMap(),
      fromJson: ForgotPasswordOtpVerifyRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, ResetPasswordRemoteResponseModel>> resetPassword(ResetPasswordRemotePostModel model) {
    return apiService.post(
      token: null,
      endPoint: ApiConstants.resetPasswordEndPoint,
      data: model.toMap(),
      fromJson: ResetPasswordRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, UserAuthorizationRemoteResponseModel>> authorizeUser(String token) {
    return apiService.post(
      token: token,
      data: {},
      endPoint: ApiConstants.authorizationUserEndPoint,
      fromJson: UserAuthorizationRemoteResponseModel.fromJson,
    );
  }
}
