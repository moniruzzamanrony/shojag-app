import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/list_type.dart';
import '../../../../../core/utils/style/style.dart';

class ListTypeSelectionWidget extends StatelessWidget {
  final PageController pageController;

  const ListTypeSelectionWidget({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Styles.horizontalPadding,
      color: AppColors.colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.borderRadius10),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding10),
        child: Selector<AlertListProvider, ListType>(
          selector: (_, provider) => provider.listType,
          builder: (_, value, __) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Dimens.padding8,
            children: [
              Expanded(
                child: _ListTypeSingleItem(
                  backgroundColor: AppColors.colorAppRed.shade(200),
                  contentColor: AppColors.colorAppRed,
                  title: context.language.active,
                  icon: Assets.activeAlertSvg,
                  isSelected: value == ListType.active,
                  onTap: () {
                    final ListType listType = ListType.active;
                    context.read<AlertListProvider>().updateListType(listType);
                    pageController.jumpToPage(listType.value);
                  },
                ),
              ),
              Expanded(
                child: _ListTypeSingleItem(
                  backgroundColor: AppColors.colorAppGreen.shade(200),
                  contentColor: AppColors.colorAppGreen,
                  title: context.language.closed,
                  icon: Assets.closedAlertSvg,
                  isSelected: value == ListType.closed,
                  onTap: () {
                    final ListType listType = ListType.closed;
                    context.read<AlertListProvider>().updateListType(listType);
                    pageController.jumpToPage(listType.value);
                  },
                ),
              ),
              Expanded(
                child: _ListTypeSingleItem(
                  backgroundColor: AppColors.colorAppBlueDark.shade(220),
                  contentColor: AppColors.colorAppBlueDark,
                  title: context.language.responded,
                  icon: Assets.respondedAlertSvg,
                  isSelected: value == ListType.responded,
                  onTap: () {
                    final ListType listType = ListType.responded;
                    context.read<AlertListProvider>().updateListType(listType);
                    pageController.jumpToPage(listType.value);
                  },
                ),
              ),
              if (context.isCitizen)
                Expanded(
                  child: _ListTypeSingleItem(
                    backgroundColor: AppColors.colorAppBlueDark.shade(220),
                    contentColor: AppColors.colorAppBlueDark,
                    title: context.language.myAlerts,
                    icon: Assets.myAlertSvg,
                    isSelected: value == ListType.myAlerts,
                    onTap: () {
                      final ListType listType = ListType.myAlerts;
                      context
                          .read<AlertListProvider>()
                          .updateListType(listType);
                      pageController.jumpToPage(listType.value);
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _ListTypeSingleItem extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color contentColor;
  final String title;
  final String icon;
  final bool isSelected;

  const _ListTypeSingleItem(
      {required this.backgroundColor,
      required this.contentColor,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //width: 66.w,
            height: 72.h,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: contentColor, width: 2)
                    : null,
                color: isSelected ? backgroundColor : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.r)),
            child: SvgPicture.asset(
              icon,
              height: 24.r,
              colorFilter: ColorFilter.mode(
                  isSelected ? contentColor : AppColors.colorAppGrey,
                  BlendMode.srcIn),
              placeholderBuilder: (context) => Icon(
                Icons.error_outline_outlined,
                color: contentColor,
              ),
            ),
          ),
          8.gapH,
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.sp,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: AppColors.colorBlack),
          ),
        ],
      ),
    );
  }
}
