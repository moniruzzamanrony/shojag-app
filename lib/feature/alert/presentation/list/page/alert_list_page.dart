/* *
* alert list page ui
* 3 type of list
* */

import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/list/widget/alert_list_view_widget.dart';
import 'package:app/feature/alert/presentation/list/widget/list_type_selection_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/skeleton_list.dart';
import '../../../domain/entity/alert_entity.dart';
import '../provider/alert_list_provider.dart';
import '../widget/alert_list_single_item.dart';

class AlertListPage extends StatefulWidget {
  const AlertListPage({super.key});

  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final alertListProvider =
        Provider.of<AlertListProvider>(context, listen: false);

    final initialIndex = alertListProvider.listType.value;
    _pageController = PageController(initialPage: initialIndex);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userId = context.userId;
      final apiToken = context.apiToken;
      alertListProvider.populateAllAlertLists(
          token: apiToken, userId: userId, loadMyAlerts: context.isCitizen);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Scaffold(
        backgroundColor: AppColors.colorAppTransparent,
        body: Column(
          children: [
            CustomAppBar(title: context.language.alertList),
            Expanded(
              child: CurvedBottomBackground(
                backgroundColor: AppColors.scaffoldBackgroundColorPaleMintLight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    20.gapH,
                    ListTypeSelectionWidget(pageController: _pageController),
                    //const __AlertListFilterWidget(),
                    20.gapH,
                    Expanded(
                        child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _listPages(context),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _listPages(BuildContext context) {
    return [
      _generateList(ListType.active),
      _generateList(ListType.closed),
      _generateList(ListType.responded),
      if (context.isCitizen) _generateList(ListType.myAlerts),
    ];
  }

  // to generate dynamic list
  Widget _generateList(ListType type) {
    return Selector<AlertListProvider, List<AlertEntity>>(
      selector: (_, provider) => provider.getAlertList(type),
      builder: (_, list, __) => Selector<AlertListProvider, bool>(
          selector: (_, p2) => p2.isLoading(type),
          builder: (_, isLoading, __) => Selector<AlertListProvider, bool>(
              selector: (_, p3) => p3.isFetching(type),
              builder: (context, isFetching, __) {
                Widget child;

                if (isLoading) {
                  child = SkeletonList(
                      separator: Dimens.padding16,
                      padding: Styles.horizontalPadding.copyWith(bottom: 16.h),
                      child: AlertListSingleItem(
                        item: AlertEntity.skeleton(),
                      ));
                } else if (list.isEmpty) {
                  child = SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      primary: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: Styles.horizontalPadding,
                      child: Selector<AlertListProvider, ListType>(
                        selector: (_, provider) => provider.listType,
                        builder: (_, type, __) => Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            context.language.noAlertsFoundTypeOrCheckInternet(
                                context.isBangla ? type.titleBn : type.titleEn),
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.colorAppGrey),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  child = AlertListViewWidget(
                      fetchMore: () =>
                          context.read<AlertListProvider>().fetchMoreAlerts(
                                userId: context.userId,
                                token: context.apiToken,
                                type: type,
                              ),
                      list: list,
                      isFetching: isFetching);
                }

                return CustomMaterialIndicator(
                    onRefresh: () async {
                      context.read<AlertListProvider>().populateAllAlertLists(
                          token: context.apiToken,
                          userId: context.userId,
                          loadMyAlerts: context.isCitizen);
                    },
                    child: child);
              })),
    );
  }
}
