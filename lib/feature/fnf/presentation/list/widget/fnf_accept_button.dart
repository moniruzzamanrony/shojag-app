import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/presentation/list/widget/fnf_list_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../../fnf/domain/entity/fnf_list_entity.dart';
import '../provider/fnf_list_action_provider.dart';
import '../provider/fnf_list_provider.dart';

class FnfAcceptButton extends StatelessWidget {
  final FnfListEntity model;

  const FnfAcceptButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          _showAcceptDialog(context);
        },
        style: fnfButtonStyle(context).copyWith(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.colorAppGreen)),
        child: Text(context.language.accept));
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
