import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/fnf/presentation/list/provider/fnf_list_provider.dart';
import 'package:app/feature/fnf/presentation/map/widget/location_address_view_single_item.dart';
import 'package:app/shared/presentation/provider/tooltip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../domain/entity/fnf_list_entity.dart';
import '../../list/widget/fnf_list_style.dart';
import '../provider/current_fnf_model_provider.dart';
import '../provider/fnf_map_address_provider.dart';
import '../provider/fnf_map_view_provider.dart';

class FnfLocationAddressWidget extends ConsumerWidget {
  const FnfLocationAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fnfMapViewProvider);
    final model = state.model;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: state.viewState == AddressViewState.add
              ? const SizedBox.shrink()
              : Wrap(
                  spacing: 6.r,
                  runSpacing: 6.r,
                  children: List.generate(model.locations.length, (index) {
                    final item = model.locations[index];

                    return LocationAddressViewSingleItem(
                      item: item,
                      baseLocation: model.baseLocation!,
                      onDelete: () => onAddressDelete(context, ref, item),
                      onTap: () => onAddressTap(context, ref, item),
                    );
                  }),
                ),
        ),
        _AddressAddOrCloseButton(model: model),
      ],
    );
  }

  void onAddressTap(
      BuildContext context, WidgetRef ref, FnfLocationsEntity item) async {
    final controller = ref.read(fnfMapViewProvider).mapController;

    final cameraState = await controller?.getCameraState();
    final point = Point(coordinates: Position(item.longitude, item.latitude));

    controller?.flyTo(
        CameraOptions(
            center: point,
            zoom: cameraState?.zoom,
            bearing: cameraState?.bearing,
            pitch: cameraState?.pitch),
        MapAnimationOptions(duration: 1000));
  }

  void onAddressDelete(
      BuildContext context, WidgetRef ref, FnfLocationsEntity item) {
    showAppDialog(context,
        dialogWidget: AlertDialog(
          title: Text(context.language.confirmation),
          content: Text(
            context.language.areYouSureYouWantToRemoveAddress,
            style: const TextStyle(color: AppColors.colorBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(context.language.cancel),
            ),
            LoadingAnimatedButton(
              height: listPopupButtonHeight,
              width: listPopupButtonWidth,
              minWidth: listPopupButtonMinWidth,
              text: context.language.confirm,
              btnColor: ColoredButtonType.green,
              onTap: (startLoading, stopLoading, btnState) {
                _delete(context, ref, item,
                    startLoading: startLoading, stopLoading: stopLoading);
              },
            ),
          ],
        ));
  }

  void _delete(BuildContext context, WidgetRef ref, FnfLocationsEntity item,
      {required Function startLoading, required Function stopLoading}) {
    final notifier = ref.watch(fnfMapViewAddressProvider.notifier);
    startLoading.call();

    notifier
        .deleteAddress(token: context.apiToken, fnfLocationId: item.id)
        .onError((error, stacktrace) {
      if (context.mounted) {
        showAppSnackBar(context, error.toString(), type: MessageType.error);
      }
      return false;
    }).then((isSuccess) async {
      if (isSuccess && context.mounted) {
        context.pop();

        showAppSnackBar(context, context.language.addressDeletedSuccessfully,
            type: MessageType.success);

        await ref
            .read(fnfListProvider.notifier)
            .loadList(token: context.apiToken, userId: context.userId);

        final updatedModel =
            ref.read(fnfListProvider).getListItemById(item.fnfId);
        if (updatedModel != null) {
          ref.read(currentFnfModelProvider.notifier).state = updatedModel;
        }
      }
    }).whenComplete(() {
      stopLoading.call();
    });
  }
}

class _AddressAddOrCloseButton extends ConsumerStatefulWidget {
  final FnfListEntity model;

  const _AddressAddOrCloseButton({super.key, required this.model});

  @override
  ConsumerState<_AddressAddOrCloseButton> createState() =>
      _AddressAddOrCloseButtonState();
}

class _AddressAddOrCloseButtonState
    extends ConsumerState<_AddressAddOrCloseButton> {
  late final SuperTooltipController _tooltipController;

  @override
  void initState() {
    super.initState();
    _tooltipController = SuperTooltipController();
  }

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fnfMapViewProvider);
    final notifier = ref.watch(fnfMapViewProvider.notifier);

    if (state.viewState == AddressViewState.add) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _viewTooltip();
      });
    }

    return SuperTooltip(
      controller: _tooltipController,
      content: SizedBox(
        width: 0.5.sw,
        child: StyledText(
          text: context.language
              .addLocationToolTipWithUsername(widget.model.userName),
          style: TextStyle(color: Colors.black, fontSize: 10.sp),
          tags: {
            'bold': StyledTextTag(
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          },
        ),
      ),
      child: InkWell(
        onTap: () {
          if (state.viewState == AddressViewState.view) {
            // cant add more than [AppConstants.maxFnfAddressLocationCount] address
            if (widget.model.locations.length >=
                AppConstants.maxFnfAddressLocationCount) {
              showAppSnackBar(
                  context,
                  context.language.youCanAddUpToAddressWithCount(
                      AppConstants.maxFnfAddressLocationCount),
                  type: MessageType.warning);
              return;
            }

            // if friend did not share location yet, can not add address
            if (widget.model.baseLocation == null) {
              showAppSnackBar(
                  context,
                  context.language.didNotSharedLocationWithYouUserName(
                      widget.model.userName),
                  type: MessageType.warning);
              return;
            }
          }
          notifier.toggleViewState();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
              color: state.viewState == AddressViewState.add
                  ? context.colorScheme.secondary
                  : context.colorScheme.primary,
              borderRadius: BorderRadius.circular(16.r)
              //  shape: BoxShape.circle,
              ),
          child: Row(
            children: [
              Text(
                state.viewState == AddressViewState.add
                    ? context.language.close
                    : context.language.add,
                style: TextStyle(
                    color: context.colorScheme.onPrimary,
                    fontSize: 12.sp,
                    height: 1.2,
                    fontWeight: FontWeight.bold),
              ),
              4.gapW,
              FaIcon(
                state.viewState == AddressViewState.add
                    ? FontAwesomeIcons.xmark
                    : FontAwesomeIcons.plus,
                size: 12.sp,
                color: context.colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _viewTooltip() async {
    final tooltipProvider = context.read<TooltipProvider>();
    final lastViewDate = tooltipProvider.getTooltipViewDate();
    if (lastViewDate != null &&
        !lastViewDate.isSameDay(other: DateTime.now())) {
      await Future.delayed(const Duration(milliseconds: 300));
      _tooltipController.showTooltip();
    }
    await tooltipProvider.saveTooltipViewDate(dateTime: DateTime.now());
  }
}
