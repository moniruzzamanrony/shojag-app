import 'dart:io';

import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/profile/domain/usecase/profile_pic_update_use_case.dart';

import '../../domain/entity/profile_pic_update_entity.dart';
import '../../domain/usecase/logout_user_use_case.dart';

class ProfileProvider extends BaseProvider {


  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  set selectedImage(File? value) {
    _selectedImage = value;
    notify();
  }

  bool isProfilePicUploading = false;

  Future<ProfilePicUpdateEntity?> uploadProfileImage(
      {required int userId, required String token}) async {
    if (_selectedImage == null) return null;
    final file = File(_selectedImage!.path);

    final profilePicUpdateUseCase = getIt<ProfilePicUpdateUseCase>();
    final param =
        ProfilePicUpdateParam(userId: userId, token: token, file: file);

    isProfilePicUploading = true;
    notify();
    final response = await profilePicUpdateUseCase(param);
    isProfilePicUploading = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  Future<bool> logoutRemote(String token) async {
    final logoutUserUseCase = getIt<LogoutUserUseCase>();
    final response = await logoutUserUseCase(LogoutUserParam(token: token));
    return response.fold((l) => false, (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    _selectedImage = null;
  }
}
