/*
*  home page latest/recent alert list section (ui)
*/

import 'dart:math' as math;

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/enums/operation_state.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:app/feature/alert/presentation/list/provider/list_sort_type_provider.dart';
import 'package:app/feature/alert/presentation/list/widget/alert_list_single_item.dart';
import 'package:app/feature/home/presentation/provider/home_provider.dart';
import 'package:app/feature/home/presentation/widget/recent_list_selection_button_widget.dart';
import 'package:app/feature/home/presentation/widget/recent_reloading_button_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/sort_type.dart';
import '../../../../core/utils/enums/user_type.dart';
import '../../../../shared/presentation/widget/skeleton_list.dart';
import '../../../alert/domain/entity/alert_entity.dart';

class RecentSectionWidget extends StatelessWidget {
  const RecentSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headingSection(context),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.horizontalSpace, vertical: Dimens.padding4),
            child: const DottedLine(dashColor: AppColors.colorGreyLight)),
        _buildButtonSection(context),
        Expanded(child: _buildListSection(context))
      ],
    );
  }

  Padding _headingSection(BuildContext context) {
    return Padding(
      padding: Styles.horizontalPadding,
      child: Row(
        children: [
          Text(
            context.language.latestAlerts,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.colorAppGrey),
          ),
          8.gapW,
          FilledButton(
            onPressed: () {
              final listType = context.read<AlertListProvider>().listType;
              context.read<AlertListProvider>().updateListType(listType);
              context.goNamed(Routes.alertList);
            },
            style: FilledButton.styleFrom(
              visualDensity: Styles.minimumVisualDensity,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              backgroundColor: AppColors.colorAppBlue.shade(220),
              foregroundColor: AppColors.colorAppBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r)),
              textStyle: TextStyle(fontSize: 12.sp),
            ),
            child: Text(
              context.language.seeAll,
            ),
          ),
          const Spacer(),
          Selector<ListSortTypeProvider, SortType>(
            selector: (_, provider) => provider.sortType,
            builder: (_, value, __) => PopupMenuButton(
                child: Row(
                  spacing: Dimens.padding4,
                  children: [
                    Text(
                      context.isBangla ? value.titleBn : value.titleEn,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    FaIcon(
                      FontAwesomeIcons.sort,
                      size: 12.sp,
                      color: AppColors.colorGrey,
                    )
                  ],
                ),
                itemBuilder: (BuildContext ctx) => SortType.values
                    .map(
                      (e) => PopupMenuItem(
                          onTap: () {
                            ctx.read<ListSortTypeProvider>().updateSortType(e);
                            ctx.read<HomeProvider>().getDashboardData(
                                token: ctx.apiToken, userId: ctx.userId);
                          },
                          value: e,
                          child: Text(
                            context.isBangla ? e.titleBn : e.titleEn,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.colorGrey),
                          )),
                    )
                    .toList()),
          ),
        ],
      ),
    );
  }

  // load list from api and convert to manageable list
  Widget _buildListSection(BuildContext context) {
    return Selector<AlertListProvider, ListType>(
        selector: (_, listProvider) => listProvider.listType,
        builder: (_, type, __) => Selector<HomeProvider, List<AlertEntity>>(
              selector: (_, homeProvider) =>
                  homeProvider.getAlertListBasedOnType(type),
              builder: (_, list, __) => Selector<HomeProvider, bool>(
                  selector: (_, h2) =>
                      h2.operationState == OperationState.waiting,
                  builder: (_, isLoading, __) {
                    if (isLoading) {
                      return SkeletonList(
                          separator: Dimens.padding16,
                          padding: Styles.horizontalPadding.copyWith(
                              top: 8.h, bottom: 160.h),
                          child: AlertListSingleItem(
                            item: AlertEntity.skeleton(),
                          ));
                    }

                    return list.isEmpty
                        ? Center(
                            child: Padding(
                              padding: Styles.horizontalPadding,
                              child: Text(
                                context.language
                                    .noAlertsFoundTypeOrCheckInternet(
                                        context.isBangla
                                            ? type.titleBn
                                            : type.titleEn),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.colorAppGrey),
                              ),
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (_, __) =>
                                SizedBox(height: Dimens.padding16),
                            padding: Styles.horizontalPadding.copyWith(
                                top: 8.h, bottom: 160.h),
                            itemBuilder: (context, index) =>
                                AlertListSingleItem(item: list[index]),
                            itemCount: math.min(
                                context.userType == UserType.citizen ? 5 : 8,
                                list.length),
                          );
                  }),
            ));
  }

  // button of active, closed, user's own alerts and see all button
  Widget _buildButtonSection(BuildContext context) {
    return Padding(
      padding: Styles.horizontalPadding,
      child: Selector<AlertListProvider, ListType>(
        selector: (_, provider) => provider.listType,
        builder: (_, value, __) => Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: Dimens.padding4,
                  children: [
                    RecentListSelectionButtonWidget(
                      text: context.language.active,
                      enabledColor: AppColors.colorAppRed,
                      type: ListType.active,
                      isSelected: value == ListType.active,
                    ),
                    RecentListSelectionButtonWidget(
                      text: context.language.closed,
                      enabledColor: AppColors.colorAppGreen,
                      type: ListType.closed,
                      isSelected: value == ListType.closed,
                    ),
                    RecentListSelectionButtonWidget(
                      text: context.language.responded,
                      enabledColor: AppColors.colorAppBlueDark,
                      type: ListType.responded,
                      isSelected: value == ListType.responded,
                    ),
                    if (context.isCitizen)
                      RecentListSelectionButtonWidget(
                        text: context.language.myAlerts,
                        enabledColor: AppColors.colorAppBlueDark,
                        type: ListType.myAlerts,
                        isSelected: value == ListType.myAlerts,
                      ),
                  ],
                ),
              ),
            ),
            const RecentReloadingButtonWidget(),
          ],
        ),
      ),
    );
  }
}
