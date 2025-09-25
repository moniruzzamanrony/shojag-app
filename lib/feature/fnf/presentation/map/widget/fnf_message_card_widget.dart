import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/assets.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../fnf/domain/entity/fnf_list_entity.dart';

class FnfMessageCardWidget extends StatelessWidget {
  final FnfListEntity model;

  const FnfMessageCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 44.r,
              width: 44.r,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  boxShadow: Styles.boxShadow(),
                  shape: BoxShape.circle),
              child: model.image != null
                  ? CachedNetworkImage(
                      imageUrl: model.image!,
                      fit: BoxFit.contain,
                      errorWidget: (_, __, ___) => _defaultAvatar(),
                    )
                  : _defaultAvatar(),
            ),
            8.gapW,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: TextStyle(fontSize: 10.sp, color: AppColors.colorGrey),
                  child: Row(
                    children: [
                      Text(context.language.message),
                      if (model.message?.time != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            FontAwesomeIcons.solidCircle,
                            size: 8.sp,
                            color: AppColors.colorGrey,
                          ),
                        ),
                        Text(timeago.format(model.message!.time!)),
                      ]
                    ],
                  ),
                ),
                if (model.message != null)
                  Text(
                    model.message!.message!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(context.language.noMessagesFound,
                      style: TextStyle(
                          fontSize: 12.sp, color: AppColors.colorAppGrey)),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Padding(
      padding: EdgeInsets.all(Dimens.padding8),
      child: Image.asset(
        Assets.userAvatarFilledPng,
        color: Colors.grey,
        fit: BoxFit.contain,
      ),
    );
  }
}
