import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/presentation/list/widget/fnf_list_style.dart';
import 'package:app/feature/fnf/presentation/list/widget/list_picture_widget.dart';
import 'package:app/feature/fnf/presentation/list/widget/sharing_status_widget.dart';
import 'package:app/feature/fnf/presentation/map/page/fnf_map_view_page.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_share_location_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../../consent/presentation/widget/consent_checker.dart';
import '../../map/provider/current_fnf_model_provider.dart';
import '../provider/fnf_list_action_provider.dart';
import '../provider/fnf_list_provider.dart';

/*
class FnfListSingleItem extends StatelessWidget {
  final FnfListEntity model;

  const FnfListSingleItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: listVerticalPadding,
        child: Stack(
          children: [
            Row(
              children: [
                ListPictureWidget(image: model.image),
                _infoSection(context),
              ],
            ),
            if (model.isAccepted && model.baseLocation != null)
              Align(
                  alignment: Alignment.topRight,
                  child: FnfViewMapButton(model: model))
          ],
        ),
      ),
    );
  }

  Widget _infoSection(BuildContext context) {
    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(model.userName, style: nameStyle),
            gapBetweenTitles,
            Text(model.userPhone, style: phoneStyle),
            if (model.isAccepted) ...[
              gapBetweenTitles,
              SharingStatusWidget(
                  sharingTimeType: model.selfLocationSharingTimeType,
                  expireAt: model.selfLocationPermissionExpireAt)
            ] else ...[
              gapBetweenTitles,
              Text(
                  model.isSender
                      ? context.language.requestSent
                      : context.language.pending,
                  style: timeLimitStyle.copyWith(color: AppColors.colorAppBlue))
            ],
            gapBetweenTitleAndButtons,
            _buttonSection(context),
          ]),
    );
  }

  Widget _buttonSection(BuildContext context) {
    return Row(
      spacing: Dimens.padding8,
      children: [
        FnfDeleteButton(model: model),
        if (!model.isSender && model.isPending) FnfAcceptButton(model: model),
        if (model.isAccepted) FnfShareLocationButton(model: model),
      ],
    );
  }
}
*/

class FnfListSingleItem extends StatelessWidget {
  final FnfListEntity model;

  const FnfListSingleItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final child = Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.borderRadius16)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListPictureWidget(image: model.image, padding: EdgeInsets.zero),
              8.gapW,
              Expanded(
                child: SizedBox(
                  height: 66.r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.userName,
                        style: nameStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        model.userPhone,
                        style: phoneStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (model.isPending) ...[
                        gapBetweenTitles,
                        Text(
                            model.isSender
                                ? context.language.requestSent
                                : context.language.pending,
                            style: timeLimitStyle.copyWith(
                                color: AppColors.colorAppBlue))
                      ],
                    ],
                  ),
                ),
              ),
              if (model.isAccepted)
                InkWell(
                    onTapDown: (details) async {
                      await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            details.globalPosition.dx,
                            details.globalPosition.dy,
                            0,
                            0),
                        items: [
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete),
                                const SizedBox(width: 8),
                                Text(context.language.delete),
                              ],
                            ),
                          ),
                        ],
                        elevation: 8,
                      ).then((value) {
                        if (value == 'delete') {
                          if (context.mounted) {
                            _showDeleteDialog(context);
                          }
                        }
                      });
                    },
                    child: const Icon(Icons.more_vert)),
            ],
          ),
          Gap(Dimens.padding16),
          // Divider(
          //   height: 20.h,
          //   thickness: 0.5,
          //   color: AppColors.colorGreyLight,
          // ),
          if (model.isAccepted) ...[
            SharingStatusWidget(
                text: context.language.sharingWithYou,
                sharingTimeType: model.friendLocationSharingTimeType,
                expireAt: model.friendLocationPermissionExpireAt),
            8.gapH,
            SharingStatusWidget(
                text: context.language.youAreSharing,
                sharingTimeType: model.selfLocationSharingTimeType,
                expireAt: model.selfLocationPermissionExpireAt),
            16.gapH,
          ],
          _buildButtonSection(context),
        ]),
      ),
    );

    if (!model.premiumStatus) {
      return ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, //
          0, 0.2126, 0.7152, 0.0722, //
          0, 0, 0.2126, 0.7152, //
          0.0722, 0, 0, 0, //
          0, 0, 1, 0, //
        ]),
        child: IgnorePointer(child: child),
      );
    }

    return child;
  }

  Widget _buildButtonSection(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle:
          WidgetStatePropertyAll(context.textTheme.bodySmall?.copyWith()),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r))),
    );
    final outlineButtonStyle = buttonStyle.copyWith(
      side: WidgetStatePropertyAll(
          BorderSide(color: context.colorScheme.primary)),
    );

    final maxLines = 1;
    final overflow = TextOverflow.ellipsis;
    final alignment = TextAlign.center;

    if (model.isAccepted) {
      return Skeleton.unite(
        child: Row(
          children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () async {
                      // check if location permission is granted
                      final hasPermission = await consentChecker(context);
                      if (!hasPermission || !context.mounted) {
                        return;
                      }

                      // check if always location permission is granted
                      final hasAlwaysPermission =
                          await alwaysPermissionChecker(context);
                      if (!hasAlwaysPermission || !context.mounted) {
                        return;
                      }

                      showModalBottomSheet(
                          context: context,
                          constraints: const BoxConstraints(),
                          builder: (_) =>
                              FnfShareLocationTimeSheet(model: model));
                    },
                    style: outlineButtonStyle,
                    child: Text(
                      context.language.shareLocation,
                      maxLines: maxLines,
                      textAlign: alignment,
                      overflow: overflow,
                    ))),
            8.gapW,
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderScope(
                          overrides: [
                            currentFnfModelProvider.overrideWith(
                              (ref) => model,
                            ),
                          ],
                          child: const FnfMapViewPage(),
                        ),
                      ),
                    );
                  },
                  style: buttonStyle,
                  child: Text(
                    context.language.viewOnMap,
                    maxLines: maxLines,
                    textAlign: alignment,
                    overflow: overflow,
                  )),
            ),
          ],
        ),
      );
    }
    return Row(
      children: [
        Expanded(
            child: OutlinedButton(
                onPressed: () {
                  _showDeleteDialog(context);
                },
                style: outlineButtonStyle,
                child: Text(
                  context.language.delete,
                  maxLines: maxLines,
                  textAlign: alignment,
                  overflow: overflow,
                ))),
        if (model.isReceiver) ...[
          8.gapW,
          Expanded(
              child: FilledButton(
                  onPressed: () {
                    _showAcceptDialog(context);
                  },
                  style: buttonStyle,
                  child: Text(
                    context.language.accept,
                    maxLines: maxLines,
                    textAlign: alignment,
                    overflow: overflow,
                  )))
        ],
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) async {
    showAppDialog(context,
        dialogWidget: AlertDialog(
          title: Text(context.language.confirmation),
          content: Text(
            context.language.areYouSureYouWantToRemoveFromYourFnfList,
            style: const TextStyle(color: AppColors.colorBlack),
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: Text(
                context.language.cancel,
              ),
            ),
            Consumer(
              builder: (_, ref, __) => LoadingAnimatedButton(
                height: listPopupButtonHeight,
                width: listPopupButtonWidth,
                minWidth: listPopupButtonMinWidth,
                text: context.language.confirm,
                btnColor: ColoredButtonType.red,
                onTap: (startLoading, stopLoading, btnState) {
                  _delete(context, ref,
                      startLoading: startLoading, stopLoading: stopLoading);
                },
              ),
            ),
          ],
        ));
  }

  void _delete(BuildContext context, WidgetRef ref,
      {required Function startLoading, required Function stopLoading}) {
    final userId = context.userId;
    final token = context.apiToken;

    startLoading.call();
    ref
        .read(fnfListActionProvider.notifier)
        .deleteFnf(
          fnfId: model.id,
          token: token,
          userId: userId,
        )
        .then((_) {
      if (context.mounted) {
        context.pop();
        // load list again
        ref
            .read(fnfListProvider.notifier)
            .loadList(token: token, userId: userId);
      }
    }).whenComplete(() {
      stopLoading.call();
    });
  }

  void _showAcceptDialog(BuildContext context) async {
    showAppDialog(context,
        dialogWidget: AlertDialog(
          title: Text(context.language.confirmation),
          content: Text(
            context.language.areYouSureYouWantToAcceptThisRequest,
            style: const TextStyle(color: AppColors.colorBlack),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                context.language.cancel,
              ),
            ),
            Consumer(
              builder: (_, ref, __) => LoadingAnimatedButton(
                height: listPopupButtonHeight,
                width: listPopupButtonWidth,
                minWidth: listPopupButtonMinWidth,
                text: context.language.confirm,
                btnColor: ColoredButtonType.green,
                onTap: (startLoading, stopLoading, btnState) {
                  _accept(context, ref,
                      startLoading: startLoading, stopLoading: stopLoading);
                },
              ),
            ),
          ],
        ));
  }

  void _accept(BuildContext context, WidgetRef ref,
      {required Function startLoading, required Function stopLoading}) async {
    final userId = context.userId;
    final token = context.apiToken;

    startLoading.call();
    ref
        .read(fnfListActionProvider.notifier)
        .acceptRequest(
          fnfId: model.id,
          token: token,
        )
        .then((_) {
      if (context.mounted) {
        context.pop();
        // load list again
        ref
            .read(fnfListProvider.notifier)
            .loadList(token: token, userId: userId);
      }
    }).whenComplete(() {
      stopLoading.call();
    });
  }
}
