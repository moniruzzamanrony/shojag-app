import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/presentation/list/provider/fnf_list_provider.dart';
import 'package:app/feature/fnf/presentation/list/widget/fnf_list_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../provider/fnf_list_action_provider.dart';

class FnfDeleteButton extends StatelessWidget {
  final FnfListEntity model;

  const FnfDeleteButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          _showDeleteDialog(context);
        },
        style: fnfButtonStyle(context).copyWith(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.colorAppRed)),
        child: Text(context.language.delete));
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
}
