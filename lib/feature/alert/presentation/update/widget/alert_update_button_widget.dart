import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/update/provider/alert_update_provider.dart';
import 'package:app/feature/home/presentation/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/helper/network_helper.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../../../shared/presentation/widget/success_widget.dart';
import '../../details/provider/alert_details_provider.dart';
import '../../list/provider/alert_list_provider.dart';

class AlertUpdateButtonWidget extends StatelessWidget {
  const AlertUpdateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AlertUpdateProvider, bool>(
      selector: (_, provider) => provider.isAlertUpdating,
      builder: (_, value, __) => LoadingAnimatedButton(
        height: 48.h,
        width: 1.sw,
        elevation: 0,
        btnColor: ColoredButtonType.green,
        onTap: (startLoading, stopLoading, btnState) => _updateAlert(context,
            startLoading: startLoading, stopLoading: stopLoading),
        text: context.language.update,
      ),
    );
  }

  Future<void> _updateAlert(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    final updateProvider = ctx.read<AlertUpdateProvider>();
    final detailsProvider = ctx.read<AlertDetailsProvider>();
    final listProvider = ctx.read<AlertListProvider>();
    final homeProvider = ctx.read<HomeProvider>();

    final alertId = updateProvider.alertModel.id;
    final userId = ctx.userId;
    final apiToken = ctx.apiToken;

    if (!await isNetworkAvailable) {
      return;
    }

    startLoading();
    final isAlertUpdated = await updateProvider
        .updateAlert(
      userId: userId,
      token: apiToken,
    )
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          showAppSnackBar(ctx, type: MessageType.error, error.toString());
        }
        return false;
      },
    ).whenComplete(
      () {
        if (ctx.mounted) {
          stopLoading();
        }
      },
    );
    if (!ctx.mounted) {
      return;
    }
    if (!isAlertUpdated) {
      return;
    }

    await showAppDialog(ctx,
        dialogWidget: SuccessWidget(
            subTitle: ctx.language.yourAlertHasBeenUpdatedSuccessfully));
    if (!ctx.mounted) {
      return;
    }
    ctx.pop();
    await detailsProvider.loadAlertDetailsWithResponses(
        userId: ctx.userId,
        apiToken: ctx.apiToken,
        alertId: alertId,
        refresh: true);
    final currentAlert = detailsProvider.currentAlert;
    if (currentAlert != null) {
      listProvider.updateAlertModel(currentAlert);
      homeProvider.updateAlertModel(currentAlert);
    }
  }
}
