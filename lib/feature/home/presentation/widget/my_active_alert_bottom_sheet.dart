import 'package:app/core/config/router/routes.dart';
import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:app/feature/home/presentation/provider/home_provider.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/style/style.dart';
import '../../../alert/domain/entity/alert_entity.dart';

class MyActiveAlertBottomSheet extends StatelessWidget {
  const MyActiveAlertBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardProvider, int>(
      selector: (_, provider) => provider.currentIndex,
      builder: (_, index, __) => Selector<HomeProvider, AlertEntity?>(
        selector: (_, provider) => provider.myActiveAlert,
        builder: (_, item, __) => item != null && index == 0
            ? _ActiveAlertBottomSheet(item: item)
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _ActiveAlertBottomSheet extends HookWidget {
  final AlertEntity item;

  const _ActiveAlertBottomSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useValueNotifier<bool>(false);
    return BottomSheet(
      showDragHandle: false,
      enableDrag: false,
      constraints: const BoxConstraints(),
      backgroundColor: Colors.transparent,
      builder: (_) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.none,
        child: Card(
          surfaceTintColor: context.colorScheme.secondary,
          margin: Styles.horizontalPadding,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          elevation: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                onTap: () {
                  isExpanded.value = !isExpanded.value;
                },
                child: Padding(
                  padding: Styles.horizontalPadding.copyWith(top: 8.h, bottom: 8.h),
                  child: Row(
                    children: [
                      Text(
                        context.language.yourActiveAlerts,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.secondary),
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              width: 30.r,
                              height: 30.r,
                              child: const DropLottieAnim(
                                  color: AppColors.colorAppRed)),
                          ValueListenableBuilder(
                            valueListenable: isExpanded,
                            builder: (_, isExpandedValue, __) =>
                                AnimatedRotation(
                              turns: isExpandedValue ? 0 : -1 / 2,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.colorAppRed.shade(220),
                                size: Dimens.iconSize16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isExpanded,
                  builder: (_, isExpandedValue, __) {
                    if (!isExpandedValue) return const SizedBox.shrink();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: Styles.horizontalPadding,
                          child: const DottedLine(
                              dashColor: AppColors.colorAppGrey),
                        ),
                        ListTile(
                          dense: true,
                          onTap: () {
                            context.goNamed(Routes.alertDetails, extra: item);
                          },
                          minVerticalPadding: 0,
                          contentPadding: Styles.horizontalPadding,
                          visualDensity: VisualDensity.compact,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimens.borderRadius16),
                            bottomRight: Radius.circular(Dimens.borderRadius16),
                          )),
                          title: Text(
                            item.incidentTitle,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                          subtitle: item.address == null
                              ? null
                              : Text(item.address!,
                                  style: TextStyle(fontSize: 12.sp)),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: Dimens.iconSize16),
                        ),
                        Gap(Dimens.padding8),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
      onClosing: () {},
    );
  }
}
