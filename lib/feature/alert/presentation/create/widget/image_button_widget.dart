import 'dart:io';

import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/helper/file_helper.dart';
import '../../../../../core/utils/helper/permission_helper.dart';
import '../../../../../core/utils/style/style.dart';
import '../provider/alert_add_provider.dart';
import 'media_button_widget.dart';

/// UI [ImageButtonWidget] for image button
class ImageButtonWidget extends StatelessWidget {
  const ImageButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AlertAddProvider, File?>(
      selector: (_, provider) => provider.selectedImage,
      builder: (_, value, _) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.bottomCenter,
        child: value == null
            ? MediaUploadButtonWidget(
                hintText: context.language.captureOrUploadImage,
                icon: Icons.camera_alt_outlined,
                onTap: () {
                  _pickImage(context, ImageSource.camera);
                  //_showBottomSheet(context);
                },
              )
            : MediaViewFrameWidget(
                child: Image.file(File(value.path)),
                onClose: () =>
                    context.read<AlertAddProvider>().selectedImage = null,
              ),
      ),
    );
  }

  //pick image from gallery
  void _pickImage(BuildContext ctx, ImageSource source) async {
    final isPermitted = await PermissionHelper.imagePermissionHandler();
    if (!isPermitted || !ctx.mounted) {
      return;
    }

    final ImagePicker picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: source);

    File? image;
    if (pickedImage != null) {
      final tempPath = await FileHelper().temporaryDirectoryPath;
      final outputFilePath = p.join(
        tempPath,
        pickedImage.name.padLeft(pickedImage.name.length + 1, 'temp_'),
      );

      final compressedImageFile = File(outputFilePath);

      final resizedImage = await FlutterImageCompress.compressAndGetFile(
        pickedImage.path,
        compressedImageFile.path,
        minWidth: AppConstants.alertImagePreferredWidth,
        minHeight: AppConstants.alertImagePreferredHeight,
        quality: AppConstants.alertImagePreferredQuality,
      );
      if (resizedImage != null) {
        image = File(resizedImage.path);
      }
    }

    if (ctx.mounted) {
      ctx.read<AlertAddProvider>().selectedImage = image;
    }
  }

  void _showBottomSheet(BuildContext context) {
    final contentPadding = EdgeInsets.zero;
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: Styles.horizontalPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.gapH,
              Text(
                context.language.selectAnOption,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorAppGrey,
                ),
              ),
              ListTile(
                onTap: () {
                  context.pop();
                  _pickImage(context, ImageSource.camera);
                },
                contentPadding: contentPadding,
                title: Text(context.language.camera),
                trailing: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              ),
              const Divider(height: 0, color: AppColors.colorGreyExtraLight),
              ListTile(
                onTap: () {
                  context.pop();
                  _pickImage(context, ImageSource.gallery);
                },
                contentPadding: contentPadding,
                title: Text(context.language.gallery),
                trailing: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const Icon(Icons.photo_size_select_actual_outlined),
                ),
              ),
              20.gapH,
            ],
          ),
        );
      },
    );
  }
}
