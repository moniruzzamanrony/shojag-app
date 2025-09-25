import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/presentation/list/widget/fnf_list_style.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_share_location_time_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../consent/presentation/widget/consent_checker.dart';

class FnfShareLocationButton extends StatelessWidget {
  final FnfListEntity model;

  const FnfShareLocationButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          _shareLocation(context);
        },
        style: fnfButtonStyle(context).copyWith(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.colorAppGreen)),
        child: Text(context.language.shareLocation));
  }

  void _shareLocation(BuildContext context) async {
    // check if location permission is granted
    final hasPermission = await consentChecker(context);
    if (!hasPermission || !context.mounted) {
      return;
    }

    // check if always location permission is granted
    final hasAlwaysPermission = await alwaysPermissionChecker(context);
    if (!hasAlwaysPermission || !context.mounted) {
      return;
    }

    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(),
        builder: (_) => FnfShareLocationTimeSheet(model: model))

    //     .then((value) {
    //   if (value == true && context.mounted) {
    //     context
    //         .read<IncomingFnfListProvider>()
    //         .fetchList(userId: context.userId, token: context.apiToken);
    //   }
    // })

    ;
  }
}
