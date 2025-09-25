import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:app/feature/home/presentation/provider/home_provider.dart';
import 'package:app/feature/response/presentation/widget/response_dialog.dart';
import 'package:app/feature/response/presentation/widget/response_list_single_item.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/enums/alert_status.dart';
import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../alert/domain/entity/alert_entity.dart';
import '../../../alert/domain/entity/alert_response_entity.dart';
import '../../../alert/presentation/details/provider/alert_details_provider.dart';

class ResponseSectionWidget extends StatelessWidget {
  final ScrollController _scrollController;

  const ResponseSectionWidget(
      {super.key, required ScrollController scrollController})
      : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AlertDetailsProvider>(
      builder: (_, provider, child) => provider.currentAlert?.id == null
          ? const SizedBox.shrink()
          : FutureBuilder(
              future: provider.loadAlertResponses(
                  userId: context.userId,
                  apiToken: context.apiToken,
                  alertId: provider.currentAlert!.id),
              builder: (context, snapshot) {
                final isDone = snapshot.connectionState == ConnectionState.done;
                return AnimatedCrossFade(
                    firstChild: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    secondChild: provider.hasAlertResponsesLoadingError
                        ? Center(
                            child: Text(
                              context.language.somethingWentWrong,
                              style:
                                  const TextStyle(color: AppColors.colorGrey),
                            ),
                          )
                        : _ResponseListSection(
                            scrollController: _scrollController),
                    crossFadeState: isDone
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 150));
              },
            ),
    );
  }
}

class _ResponseListSection extends HookWidget {
  final ScrollController _scrollController;

  const _ResponseListSection(
      {super.key, required ScrollController scrollController})
      : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    final isExpandedNotifier = useValueNotifier<bool>(true);
    return Column(
      children: [
        _postActionButtonSection(context),
        _separator(),
        InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () {
            isExpandedNotifier.value = !isExpandedNotifier.value;
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) async {
                await Future.delayed(const Duration(milliseconds: 150));
                if (context.mounted && isExpandedNotifier.value) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                }
              },
            );
          },
          child: Row(
            children: [
              Text(context.language.responses,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.colorGrey,
                  )),
              4.gapW,
              Selector<AlertDetailsProvider, int>(
                selector: (_, provider) => provider.responseMapList.length,
                builder: (_, value, __) => Text('($value)',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.colorGrey,
                    )),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: isExpandedNotifier,
                builder: (_, isExpanded, __) => AnimatedRotation(
                  turns: isExpanded ? 0 : -1 / 2,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.colorGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
        const DottedLine(dashColor: AppColors.colorGreyLight),
        ValueListenableBuilder(
          valueListenable: isExpandedNotifier,
          builder: (_, isExpanded, __) => isExpanded
              ? Selector<AlertDetailsProvider, Map<int, AlertResponseEntity>>(
                  selector: (_, provider) => provider.responseMapList,
                  builder: (_, mapList, __) {
                    final list = mapList.values.toList();
                    if (list.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                            child: Text(
                          context.language.noResponsesYet,
                          style: const TextStyle(color: AppColors.colorGrey),
                        )),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ResponseListSingleItem(item: list[index]),
                      itemCount: list.length,
                    );
                  },
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _separator() => 16.gapH;

  Widget _postActionButtonSection(BuildContext context) {
    final model = context.read<AlertDetailsProvider>().currentAlert!;

    final bool isOwnPost = model.userId == context.userId;
    final bool isPostClosed = model.status == AlertStatus.closed;

    // if post is closed
    if (isPostClosed) {
      // if closed and own post
      if (isOwnPost) {
        return ColoredBackgroundButton(
          onPressed: () {
            showAppDialog(context,
                dialogWidget: AlertDialog(
                  title: Text(context.language.confirmation),
                  content: Text(
                    context.language.areYouSureYouWantToDeleteThisAlert,
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
                        width: 80.w,
                        height: 32.h,
                        onTap: (startLoading, stopLoading, btnState) {
                          _deleteAlert(context, model,
                              startLoading: startLoading,
                              stopLoading: stopLoading);
                        },
                        btnColor: ColoredButtonType.green,
                        text: context.language.yes),
                  ],
                ));
          },
          text: context.language.delete,
          buttonColor: ColoredButtonType.red,
        );
      }
      // if closed and not own post
      else {
        return ColoredBackgroundButton(
            onPressed: null,
            buttonColor: ColoredButtonType.green,
            text: context.language.closed);
      }

      // if post id open
    } else {
      // if post is open and own post
      if (isOwnPost) {
        // self added report
        return Row(
          children: [
            Expanded(
                child: ColoredBackgroundButton(
              text: context.language.update,
              buttonColor: ColoredButtonType.green,
              onPressed: () {
                context.goNamed(Routes.alertUpdate, extra: model);
              },
            )),
            16.gapW,
            Expanded(
                child: ColoredBackgroundButton(
              onPressed: () {
                showAppDialog(context,
                    dialogWidget: AlertDialog(
                      title: Text(context.language.confirmation),
                      content: Text(
                        context.language.areYouSureYouWantToCloseThisAlert,
                        style: const TextStyle(color: AppColors.colorBlack),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => context.pop(),
                            child: Text(context.language.cancel)),
                        LoadingAnimatedButton(
                          height: 32.h,
                          width: 80.w,
                          onTap: (startLoading, stopLoading, btnState) =>
                              _closeAlert(context, model,
                                  startLoading: startLoading,
                                  stopLoading: stopLoading),
                          text: context.language.yes,
                          btnColor: ColoredButtonType.green,
                        ),
                      ],
                    ));
              },
              buttonColor: ColoredButtonType.red,
              text: context.language.close,
            )),
          ],
        );
      }
      // if post is open and not own post
      else {
        return Selector<AlertDetailsProvider, bool>(
          selector: (_, provider) => provider.isResponded(context.userId),
          builder: (_, isResponder, __) {
            final currentUserType = context.userType;
            // if already responded by user
            if (isResponder) {
              // show cancel button to the police, ambulance and fire service
              if (currentUserType == UserType.police ||
                  currentUserType == UserType.ambulance ||
                  currentUserType == UserType.fireService) {
                return ColoredBackgroundButton(
                  onPressed: () {
                    showAppDialog(context,
                        dialogWidget: AlertDialog(
                          title: Text(context.language.confirmation),
                          content: Text(
                            context
                                .language.areYouSureYouWantToCancelThisResponse,
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
                              onTap: (startLoading, stopLoading, btnState) {
                                _deleteAlertResponse(context, model,
                                    startLoading: startLoading,
                                    stopLoading: stopLoading);
                              },
                              width: 80.w,
                              height: 32.h,
                              btnColor: ColoredButtonType.green,
                              text: context.language.yes,
                            ),
                          ],
                        ));
                  },
                  buttonColor: ColoredButtonType.red,
                  text: context.language.cancel,
                );
              }
              // show response sent button only to the citizen
              else {
                return ColoredBackgroundButton(
                  onPressed: null,
                  buttonColor: ColoredButtonType.red,
                  text: context.language.responseSent,
                );
              }
            }
            // if not responded by user yet
            else {
              // show response button to the police, ambulance and fire service only no one from their group
              if (currentUserType == UserType.police ||
                  currentUserType == UserType.ambulance ||
                  currentUserType == UserType.fireService) {
                final isAlreadyRespondedByGroup = context
                    .read<AlertDetailsProvider>()
                    .hasAlreadyRespondedByGroup(currentUserType!);

                if (isAlreadyRespondedByGroup) {
                  return ColoredBackgroundButton(
                    onPressed: null,
                    buttonColor: ColoredButtonType.red,
                    text: 'Already Responded by ${currentUserType.titleEn}',
                  );
                }
              }
              // show response button to the all citizen
              return ColoredBackgroundButton(
                onPressed: () {
                  showAppDialog(context,
                      dialogWidget: ResponseDialog(alertId: model.id));
                },
                buttonColor: ColoredButtonType.green,
                text: context.language.response,
              );
            }
          },
        );
      }
    }
  }

  void _deleteAlertResponse(BuildContext ctx, AlertEntity alertModel,
      {required Function startLoading, required Function stopLoading}) async {
    final alertDetailsProvider = ctx.read<AlertDetailsProvider>();

    startLoading();

    final isResponseDeleted = await alertDetailsProvider
        .responseAlertDelete(
            userId: ctx.userId, apiToken: ctx.apiToken, alertId: alertModel.id)
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          showAppSnackBar(ctx, error.toString(), type: MessageType.normal);
        }
        return false;
      },
    ).whenComplete(
      () => stopLoading(),
    );
    if (!ctx.mounted) return;
    if (isResponseDeleted) {
      ctx.pop();
      showAppSnackBar(ctx, ctx.language.alertResponseCancelSuccessfully,
          type: MessageType.normal);
    }
  }

  void _closeAlert(BuildContext ctx, AlertEntity alertModel,
      {required Function startLoading, required Function stopLoading}) async {
    final alertDetailsProvider = ctx.read<AlertDetailsProvider>();
    final alertListProvider = ctx.read<AlertListProvider>();

    startLoading();
    final isAlertClosed = await alertDetailsProvider
        .closeAlert(ctx.userId, ctx.apiToken, alertModel)
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          showAppSnackBar(ctx, error.toString(), type: MessageType.error);
        }
        return false;
      },
    ).whenComplete(
      () {
        stopLoading();
        if (ctx.mounted) {
          ctx.pop();
        }
      },
    );
    if (!ctx.mounted) return;

    if (isAlertClosed) {
      showAppSnackBar(ctx, ctx.language.alertClosedSuccessfully,
          type: MessageType.success);

      // update alert details model
      final currentAlert = alertDetailsProvider.currentAlert;
      if (currentAlert == null) return;
      final updateAlert = currentAlert.copyWith(status: AlertStatus.closed);
      alertDetailsProvider.currentAlert = updateAlert;
      alertListProvider.notify();

      // update alert list
      alertListProvider.updateAlertModel(updateAlert);

      ctx
          .read<HomeProvider>()
          .getDashboardData(token: ctx.apiToken, userId: ctx.userId);
    }
  }

  void _deleteAlert(BuildContext ctx, AlertEntity alertModel,
      {required Function startLoading, required Function stopLoading}) async {
    final alertDetailsProvider = ctx.read<AlertDetailsProvider>();
    final alertListProvider = ctx.read<AlertListProvider>();

    startLoading();
    final isDeleted = await alertDetailsProvider
        .deleteAlert(ctx.userId, ctx.apiToken, alertModel)
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          showAppSnackBar(ctx, error.toString(), type: MessageType.error);
        }
        return false;
      },
    ).whenComplete(
      () {
        stopLoading();
        if (ctx.mounted) ctx.pop();
      },
    );
    if (!ctx.mounted) return;

    if (isDeleted) {
      ctx
          .read<HomeProvider>()
          .getDashboardData(token: ctx.apiToken, userId: ctx.userId);

      // update alert list
      alertListProvider.deleteAlertIfExist(alertModel);

      showAppSnackBar(ctx, ctx.language.alertDeletedSuccessfully,
          type: MessageType.success);
      ctx.pop();
    }
  }
}
