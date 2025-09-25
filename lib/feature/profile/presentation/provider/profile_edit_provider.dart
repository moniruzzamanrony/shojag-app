import '../../../../core/config/provider/base_provider.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../domain/entity/profile_update_entity.dart';
import '../../domain/usecase/profile_update_use_case.dart';

class ProfileEditProvider extends BaseProvider {

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

  bool isProfileUpdating = false;

  Future<ProfileUpdateEntity?> updateProfile({
    required int userId,
    required String token,
    required String firstName,
    required String lastName,
    String? email,
    String? gender,
    String? dob,
    String? nid,
    String? address,
    int? thanaId,
  }) async {
    final profileUpdateUseCase = getIt<ProfileUpdateUseCase>();

    final param = ProfileUpdateParam(
        userId: userId,
        token: token,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        dob: dob,
        nid: nid,
        address: address,
        email: email,
        thanaId: thanaId);
    isProfileUpdating = true;
    notify();

    final response = await profileUpdateUseCase(param);
    isProfileUpdating = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    _errorMessage.clear();
  }
}
