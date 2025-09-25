import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants/assets.dart';

class ListPictureWidget extends StatelessWidget {
  final String? image;
  final EdgeInsets? padding;

  const ListPictureWidget({super.key, required this.image, this.padding});

  @override
  Widget build(BuildContext context) {
    return _buildPictureSection();
  }

  Widget _buildPictureSection() {
    final imageSize = 66.r;
    final blankProfile = ClipOval(
      child: Image.asset(
        Assets.userProfilePng,
        fit: BoxFit.cover,
        height: imageSize,
        width: imageSize,
      ),
    );
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w),
      child: image != null && image!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: image!,
              height: imageSize,
              width: imageSize,
              imageBuilder: (_, imageProvider) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain)),
                );
              },
              progressIndicatorBuilder: (_, __, ___) {
                return const RepaintBoundary(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorWidget: (context, url, error) => blankProfile,
            )
          : blankProfile,
    );
  }
}
