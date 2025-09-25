import 'dart:ui';

import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/assets.dart';

class ImageViewDialog extends StatelessWidget {
  final String url;

  const ImageViewDialog({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: SizedBox(
            height: 0.5.sh,
            child: PhotoView(
              tightMode: true,
              backgroundDecoration: const BoxDecoration(color: Colors.transparent),
              imageProvider: NetworkImage(url),
              errorBuilder: (_, error, stackTrace) => DecoratedBox(
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      border: Border.all(color: AppColors.colorAppGrey)),
                  child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: 5, sigmaY: 5, tileMode: TileMode.decal),
                      child: SvgPicture.asset(
                        Assets.shojagLogoSvg,
                        colorFilter: const ColorFilter.matrix(<double>[
                          0.2126, 0.7152, 0.0722, 0, //
                          0, 0.2126, 0.7152, 0.0722, //
                          0, 0, 0.2126, 0.7152, //
                          0.0722, 0, 0, 0, //
                          0, 0, 1, 0, //
                        ]),
                      ))),
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 72,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.colorAppRed,
                    backgroundColor: AppColors.colorAppRed.shade(248),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close)),
            ),
          ),
        ),
      ],
    );
  }
}
