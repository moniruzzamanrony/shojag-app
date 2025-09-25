/* profile image page and pick widget */

import 'dart:io';

import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/assets.dart';
import '../../../../core/utils/helper/permission_helper.dart';
import '../../../../core/utils/style/style.dart';
import '../../../../shared/presentation/provider/session_provider.dart';
import '../provider/profile_provider.dart';

class ProfileImageViewAndPickWidget extends StatefulWidget {
  const ProfileImageViewAndPickWidget({super.key});

  @override
  State<ProfileImageViewAndPickWidget> createState() =>
      _ProfileImageViewAndPickWidgetState();
}

class _ProfileImageViewAndPickWidgetState
    extends State<ProfileImageViewAndPickWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.r,
      width: 100.r,
      child: GestureDetector(
        onTap: () {
          PermissionHelper.imagePermissionHandler().then((permitted) {
            if (mounted) if (permitted) _pickImage();
          });
        },
        child: Stack(
          children: [
            _imageView(context),
            _cameraOrCloseIcon(context),
          ],
        ),
      ),
    );
  }

  Positioned _cameraOrCloseIcon(BuildContext context) {
    return Positioned(
      bottom: 4.r,
      right: 4.r,
      child: Selector<ProfileProvider, File?>(
        selector: (_, provider) => provider.selectedImage,
        builder: (_, value, __) => InkWell(
          onTap: value == null
              ? null
              : () {
                  context.read<ProfileProvider>().selectedImage = null;
                },
          child: Container(
            height: 24.r,
            width: 24.r,
            alignment: Alignment.center,
            padding: EdgeInsets.all(Dimens.padding4),
            decoration: BoxDecoration(
                color: AppColors.colorWhite,
                border: Border.all(color: AppColors.colorAppGreen),
                shape: BoxShape.circle),
            child: value != null
                ? Icon(
                    Icons.close_outlined,
                    size: 14.sp,
                    color: AppColors.colorAppRed,
                  )
                : Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.colorAppGreen,
                    size: 14.sp,
                  ),
          ),
        ),
      ),
    );
  }

  Positioned _imageView(BuildContext context) {
    final photoUrl = context.photo;

    return Positioned.fill(
      child: Selector<ProfileProvider, File?>(
        selector: (_, provider) => provider.selectedImage,
        builder: (_, value, __) => Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: Styles.boxShadow(),
              shape: BoxShape.circle),
          child: value != null
              ? Image.file(
                  File(value.path),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _defaultAvatar(),
                )
              : (photoUrl != null && photoUrl.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: photoUrl,
                      fit: BoxFit.contain,
                      errorWidget: (_, __, ___) => _defaultAvatar(),
                    )
                  : _defaultAvatar(),
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Padding(
      padding: EdgeInsets.all(Dimens.borderRadius16),
      child: Image.asset(
        Assets.userAvatarFilledPng,
        color: Colors.grey,
        fit: BoxFit.contain,
      ),
    );
  }

  // crop image function for profile
  Future<File?> _cropImage(BuildContext ctx, XFile? file) async {
    if (file != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressQuality: 95,
        maxHeight: 300,
        maxWidth: 300,
        // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Profile Image',
              toolbarColor: ctx.colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: true,
              cropStyle: CropStyle.circle,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ]),
          IOSUiSettings(
            title: 'Profile Image',
            cropStyle: CropStyle.circle,
            hidesNavigationBar: true,
            minimumAspectRatio: 1.0,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    }
    return null;
  }

  // pick image function for profile
  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final profileProvider = context.read<ProfileProvider>();
    final sessionProvider = context.read<SessionProvider>();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    final croppedImage = await _cropImage(context, pickedImage);

    profileProvider.selectedImage = croppedImage;

    final updatedEntity = await profileProvider
        .uploadProfileImage(
            userId: sessionProvider.userId, token: sessionProvider.apiToken)
        .onError((error, stackTrace) => null);
    if (updatedEntity == null) {
      return;
    }
    if (updatedEntity.profilePicUrl != null) {
      await sessionProvider.updateProfilePicSession(
          profilePhoto: updatedEntity.profilePicUrl!);
    }

    profileProvider.selectedImage = null;
    if (mounted) setState(() {});
  }
}
