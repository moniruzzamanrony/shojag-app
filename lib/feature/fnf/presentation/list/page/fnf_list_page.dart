import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_share_location_time_widget.dart';
import 'package:app/feature/fnf/presentation/search/widget/empty_contact_list_widget.dart';
import 'package:app/shared/presentation/widget/custom_app_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as prov;

import '../../../../../core/config/router/routes.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/enums/notification_type.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/provider/location_provider.dart';
import '../../../../../shared/presentation/widget/skeleton_list.dart';
import '../../../domain/entity/fnf_list_entity.dart';
import '../provider/fnf_list_provider.dart';
import '../widget/fnf_list_single_item.dart';

class FnfListPage extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool _fromNotification;
  final NotificationType _notificationType;
  final int? _fnfId;

  const FnfListPage(
      {super.key,
      required this.scrollController,
      bool fromNotification = false,
      NotificationType notificationType = NotificationType.none,
      int? fnfId})
      : _fromNotification = fromNotification,
        _notificationType = notificationType,
        _fnfId = fnfId;

  @override
  ConsumerState<FnfListPage> createState() => _FnfListPageState();
}

class _FnfListPageState extends ConsumerState<FnfListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        ref
            .read(fnfListProvider.notifier)
            .loadList(token: context.apiToken, userId: context.userId)
            .then((_) {
          if (mounted) {
            _showShareLocationDialog();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppRefreshIndicator(
        child: Column(
          children: [
            //_permissionSection(context),
            prov.Selector<LocationProvider, bool>(
              selector: (_, provider) =>
                  provider.hasBackgroundLocationPermission,
              builder: (_, hasPermission, __) {
                if (hasPermission) return const SizedBox.shrink();

                return Container(
                  margin: Styles.horizontalPadding.copyWith(
                    top: Dimens.padding8,
                  ),
                  padding: EdgeInsets.all(Dimens.padding8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error.shade(248),
                    borderRadius: BorderRadius.circular(Dimens.borderRadius6),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        context.language
                            .enableBackgroundLocationToShareYourLocation,
                        style: TextStyle(
                          fontSize: Dimens.fontSize11,
                          color: context.colorScheme.error,
                        ),
                      )),
                      Gap(Dimens.padding8),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(Routes.locationSettings);
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.padding4,
                                  vertical: Dimens.padding4),
                              textStyle: TextStyle(
                                fontSize: Dimens.fontSize11,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          child: Text(context.language.change))
                    ],
                  ),
                );
              },
            ),
            Expanded(child: _listChild(context, ref)),
          ],
        ),
        onRefresh: () async {
          ref
              .read(fnfListProvider.notifier)
              .loadList(token: context.apiToken, userId: context.userId);
        });
  }

  Widget _listChild(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fnfListProvider);
    if (state.isLoading) {
      return SkeletonList(
        separator: Dimens.padding10,
        scrollController: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: Styles.horizontalPadding.copyWith(bottom: 16.h, top: 8.h),
        child: FnfListSingleItem(
          model: FnfListEntity.skeleton(),
        ),
      );
    }
    if (state.error != null) {

      return const Center(child: EmptyContactListWidget());
    }

    if (state.list.isNotEmpty) {
      return SafeArea(
        top: false,
        child: ListView.separated(
          controller: widget.scrollController,
          // primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (_, __) => 10.gapH,
          padding: Styles.horizontalPadding.copyWith(bottom: 72.h, top: 8.h),
          itemCount: state.list.length,
          itemBuilder: (_, index) =>
              FnfListSingleItem(model: state.list[index]),
        ),
      );
    }

    return const EmptyContactListWidget();
  }

  /// page share location dialog if it come from notification
  void _showShareLocationDialog() {
    if (!mounted) return;

    if (widget._fromNotification &&
        widget._notificationType == NotificationType.locationShareRequest &&
        widget._fnfId != null) {
      final model = ref.read(fnfListProvider).getListItemById(widget._fnfId!);

      if (model != null) {
        showModalBottomSheet(
            context: context,
            builder: (_) => FnfShareLocationTimeSheet(model: model));
      }
    }
  }
}
