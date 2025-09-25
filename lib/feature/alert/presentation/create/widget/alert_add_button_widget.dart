import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/router/routes.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/helper/network_helper.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../../../shared/presentation/widget/success_widget.dart';
import '../../list/provider/alert_list_provider.dart';
import '../provider/alert_add_provider.dart';
import 'alert_creation_confirmation_dialog.dart';

/// UI [AlertAddButtonWidget] for alert add button
class AlertAddButtonWidget extends StatelessWidget {
  final AlertType currentType;

  const AlertAddButtonWidget({super.key, required this.currentType});

  @override
  Widget build(BuildContext context) {
    //final disabled = currentType != AlertType.community; // TODO: disable for only community
    final disabled = false;

    return Selector<AlertAddProvider, bool>(
      selector: (_, provider) => provider.isAlertAdding,
      builder: (_, value, __) => LoadingAnimatedButton(
        width: 1.sw,
        height: 48.h,
        btnColor: ColoredButtonType.red,
        onTap: disabled
            ? null
            : (startLoading, stopLoading, btnState) {
                hideAppKeyboard(context);
                _addAlert(context, currentType,
                    startLoading: startLoading, stopLoading: stopLoading);
              },
        text:
            disabled ? context.language.comingSoon : context.language.postAlert,
      ),
    );
  }

  // adding alert button function
  void _addAlert(BuildContext ctx, AlertType type,
      {required Function startLoading, required Function stopLoading}) async {
    final userId = ctx.userId;
    final apiToken = ctx.apiToken;
    final alertAddProvider = ctx.read<AlertAddProvider>();

    final hasInternet = await isNetworkAvailable;
    if (!ctx.mounted) {
      return;
    }

    if (!hasInternet) {
      showAppSnackBar(
          ctx, type: MessageType.normal, ctx.language.noInternetConnection);
      return;
    }

    final isValid = _alertValidator(ctx);
    if (!isValid) {
      return;
    }
    if (!ctx.mounted) {
      return;
    }
    final hasConfirmed = await _showAlertAddConfirmationDialog(ctx);
    if (hasConfirmed != true) {
      return;
    }
    startLoading();
    final isAlertCreated = await alertAddProvider
        .addAlert(
            userId: userId, token: apiToken, selectedPrimaryCategory: type)
        .onError(
      (error, stackTrace) {
        if (ctx.mounted) {
          showAppSnackBar(ctx, type: MessageType.normal, error.toString());
        }

        return false;
      },
    ).whenComplete(
      () {
        stopLoading();
      },
    );

    if (!ctx.mounted) {
      return;
    }

    if (isAlertCreated) {
      await showAppDialog(ctx,
          dialogWidget: SuccessWidget(
            subTitle: ctx.language.yourAlertHasBeenCreatedSuccessfully,
          ));
      alertAddProvider.resetAll();

      if (ctx.mounted) {
        ctx.read<AlertListProvider>().updateListType(ListType.myAlerts);
        ctx.goNamed(Routes.alertList);
      }
    }
  }

  // validate alert form
  bool _alertValidator(BuildContext context) {
    final selectedIncidentType =
        context.read<AlertAddProvider>().selectedIncidentType;
    final customIncident = context.read<AlertAddProvider>().customIncident;
    final description = context.read<AlertAddProvider>().description;
    final selectedLatLng = context.read<AlertAddProvider>().selectedLatLng;

    bool isValid = true;
    String message = '';

    if ((currentType == AlertType.community ||
            currentType == AlertType.fireService) &&
        (selectedIncidentType == null && customIncident == null)) {
      message = context.language.pleaseSelectAnIncidentType;
      isValid = false;
    } else if (description == null || description.trim().isEmpty) {
      message = context.language.writeShortDescriptionAboutTheIncident;
      isValid = false;
    } else if (selectedLatLng == null) {
      message = context.language.selectALocation;
      isValid = false;
    }

    if (!isValid) {
      showAppSnackBar(context, type: MessageType.warning, message);
    }

    return isValid;
  }

  // show alert confirmation dialog
  Future<bool?> _showAlertAddConfirmationDialog(BuildContext context) async {
    return await showAppDialog<bool?>(context,
        dialogWidget: const AlertCreationConfirmationDialog());
  }
}
