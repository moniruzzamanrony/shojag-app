import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../alert/presentation/details/provider/alert_details_provider.dart';
import '../../../alert/presentation/list/provider/alert_list_provider.dart';

class ResponseDialog extends HookWidget {
  final int alertId;

  const ResponseDialog({super.key, required this.alertId});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return AlertDialog(
      title: Text(context.language.confirmation),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.language.areYouSureYouWantToRespondToThisAlert,
            style: const TextStyle(color: AppColors.colorBlack),
          ),
          16.gapH,
          //if (context.userType == UserType.citizen)
          TextField(
            controller: textEditingController,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            maxLength: 80,
            decoration: InputDecoration(
                hintText: context.language.writeYourMessageHere,
                hintStyle: TextStyle(
                    color: AppColors.colorGreyLight, fontSize: 12.sp)),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(context.language.cancel)),
        LoadingAnimatedButton(
          height: 36.h,
          width: 80.w,
          minWidth: 10,
          text: context.language.confirm,
          btnColor: ColoredButtonType.green,
          onTap: (startLoading, stopLoading, btnState) {
            final message = textEditingController.text.trim().isEmpty
                ? null
                : textEditingController.text.trim();

            _responseAlert(context, alertId, message,
                startLoading: startLoading, stopLoading: stopLoading);
          },
        )
      ],
    );
  }

  void _responseAlert(BuildContext ctx, int alertId, String? message,
      {required Function startLoading, required Function stopLoading}) async {
    final alertDetailsProvider = ctx.read<AlertDetailsProvider>();
    startLoading();

    final result = await alertDetailsProvider
        .responseAlert(
            userId: ctx.userId,
            apiToken: ctx.apiToken,
            alertId: alertId,
            message: message)
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          ctx.pop();
          showAppSnackBar(ctx, error.toString(), type: MessageType.normal);
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
    if (result) {
      if (ctx.mounted) {
        ctx.read<AlertListProvider>().populateAllAlertLists(
            token: ctx.apiToken,
            userId: ctx.userId,
            loadMyAlerts: ctx.isCitizen);

        showAppSnackBar(ctx, 'You have responded this alert',
            type: MessageType.success);
      }
    }
  }
}
