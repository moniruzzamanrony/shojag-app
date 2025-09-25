/*
* provider : registration
*/

import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/auth/domain/entity/thana_entity.dart';
import 'package:app/feature/auth/domain/usecase/registration_use_case.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enums/gender.dart';
import '../../../../core/utils/enums/user_type.dart';
import '../../domain/entity/otp_verify_id_and_token_entity.dart';
import '../../domain/entity/user_info_entity.dart';
import '../../domain/usecase/get_thana_list_use_case.dart';
import '../../domain/usecase/verify_otp_use_case.dart';
import '../../domain/usecase/verify_phone_use_case.dart';

class RegistrationProvider extends BaseProvider {

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

  bool passwordObscureText = true;

  void togglePasswordObscure() {
    passwordObscureText = !passwordObscureText;
    notify();
  }

  int? tempId;
  String? tempToken;

  bool _isPhoneVerified = false;

  bool get isPhoneVerified => _isPhoneVerified;

  set isPhoneVerified(bool value) {
    _isPhoneVerified = value;
    notify();
  }

  bool _isPhoneVerifying = false;

  bool get isPhoneVerifying => _isPhoneVerifying;

  set isPhoneVerifying(bool value) {
    _isPhoneVerifying = value;
    notify();
  }

  bool _isOtpVerifying = false;

  bool get isOtpVerifying => _isOtpVerifying;

  set isOtpVerifying(bool value) {
    _isOtpVerifying = value;
    notify();
  }

  UserType? _selectedUserType = UserType.citizen;

  UserType? get selectedUserType => _selectedUserType;

  set selectedUserType(UserType? value) {
    _selectedUserType = value;
    notify();
  }

  Gender? _selectGender;

  Gender? get selectGender => _selectGender;

  set selectGender(Gender? value) {
    _selectGender = value;
    notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    _isOtpVerifying = false;
    _isPhoneVerifying = false;
    _isPhoneVerified = false;
    _selectedUserType = UserType.citizen;
    _selectGender = null;
    tempId = null;
    selectedThana = null;
    _acceptTermsAndCondition = true;
  }

  ThanaEntity? selectedThana;

  Future<List<ThanaEntity>> getThanaList() async {
    final getThanaListUseCase = getIt<GetThanaListUseCase>();
    final response = await getThanaListUseCase(NoParams());
    return response.fold((l) => [], (r) => r);
  }

  Future<int> verifyPhone(String phone) async {
    isPhoneVerifying = true;
    notify();

    final verifyPhoneUseCase = getIt<VerifyPhoneUseCase>();
    final param = VerifyPhoneParams(phone: phone);
    final response = await verifyPhoneUseCase(param);
    isPhoneVerifying = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r.id);
  }

  Future<OtpVerifyIdAndTokenEntity?> verifyOtp(
      {required String otp, required int tempId}) async {
    isOtpVerifying = true;
    notify();

    final verifyOtpUseCase = getIt<VerifyOtpUseCase>();
    final param = VerifyOtpParams(otp: otp, tempId: tempId);
    final response = await verifyOtpUseCase(param);
    isOtpVerifying = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  bool _isRegistering = false;

  bool get isRegistering => _isRegistering;

  set isRegistering(bool value) {
    _isRegistering = value;
    notify();
  }

  bool _acceptTermsAndCondition = true;

  bool get acceptTermsAndCondition => _acceptTermsAndCondition;

  set acceptTermsAndCondition(bool value) {
    _acceptTermsAndCondition = value;
    notify();
  }

  Future<UserInfoEntity?> register({
    required String firstName,
    required String lastName,
    required String email,
    required int typeId,
    required String? gender,
    required String phone,
    required String policeId,
    required String organization,
    required String password,
    required String tempToken,
    required String deviceToken,
    required int tempId,
    required double latitude,
    required double longitude,
    required int thanaId,
  }) async {
    _isRegistering = true;
    notify();

    final registrationUseCase = getIt<RegistrationUseCase>();

    final param = RegistrationParams(
        firstName: firstName,
        lastName: lastName,
        email: email,
        typeId: typeId,
        gender: gender,
        password: password,
        token: tempToken,
        policeId: policeId,
        fireStation: organization,
        hospitalOrAgency: organization,
        deviceToken: deviceToken,
        latitude: latitude,
        longitude: longitude,
        thanaId: thanaId,
        tempId: tempId);
    final response = await registrationUseCase(param);
    _isRegistering = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }
}
