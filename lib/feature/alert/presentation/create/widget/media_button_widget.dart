import 'package:app/core/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';

/// UI [MediaButtonWidget] for media button
class MediaUploadButtonWidget extends StatelessWidget {
  final String hintText;
  final String? text;
  final IconData icon;
  final void Function() onTap;

  const MediaUploadButtonWidget(
      {super.key,
      required this.hintText,
      this.text,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: AppColors.colorGreyExtraLight),
        ),
        color: AppColors.colorWhite,
        shadowColor: const Color(0x2006141A),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text ?? hintText,
                  maxLines: 1,
                  style: text != null
                      ? TextStyle(
                          fontSize: 12.sp,
                          height: 1,
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w400,
                        )
                      : TextStyle(
                          fontSize: 12.sp,
                          height: 1,
                          color: AppColors.colorGreyLight,
                          fontWeight: FontWeight.w400,
                        ),
                ),
              ),
              Icon(
                icon,
                color: AppColors.colorGrey,
                size: Dimens.iconSize18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaViewFrameWidget extends StatelessWidget {
  final Widget child;
  final void Function() onClose;

  const MediaViewFrameWidget(
      {super.key, required this.child, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.transparent,
      shadowColor: const Color(0x2006141A),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColors.colorAppGrey)),
            height: 150.h,
            width: double.infinity,
            child: child,
          ),
          Positioned(
              right: 5.r,
              top: 5.r,
              child: InkWell(
                onTap: onClose,
                child: CircleAvatar(
                    backgroundColor: Colors.red.shade50,
                    radius: 10.r,
                    child: Icon(Icons.close, size: 12.sp, color: Colors.red)),
              )),
        ],
      ),
    );
  }
}
