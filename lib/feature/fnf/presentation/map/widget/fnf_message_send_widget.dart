import 'package:app/core/utils/enums/message_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/style/style.dart';

class FnfMessageSendWidget extends ConsumerStatefulWidget {
  final FnfListEntity model;

  const FnfMessageSendWidget({super.key, required this.model});

  @override
  ConsumerState<FnfMessageSendWidget> createState() =>
      _FnfMessageSendWidgetState();
}

class _FnfMessageSendWidgetState extends ConsumerState<FnfMessageSendWidget> {
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _validMessageNotifier;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _validMessageNotifier = ValueNotifier(false);
    _controller.addListener(_checkMessageValidity);
  }

  @override
  void dispose() {
    _controller.removeListener(_checkMessageValidity);
    _validMessageNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _checkMessageValidity() {
    if (_controller.text.trim().isNotEmpty) {
      _validMessageNotifier.value = true;
    } else {
      _validMessageNotifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fnfMessageProvider);
    final isLoading = state is AsyncLoading;

    ref.listen<AsyncValue<bool>>(fnfMessageProvider, (prev, next) {
      next.whenOrNull(
        data: (success) {
          if (success) {
            context.pop();
            _controller.clear();
            showAppSnackBar(
              context,
              context.language.messageSentSuccessfully,
              type: MessageType.success,
            );
          }
        },
        error: (error, _) {
          context.pop();
          showAppSnackBar(
            context,
            error.toString(),
            type: MessageType.error,
          );
        },
      );
    });

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.horizontalSpace, vertical: Dimens.padding8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.language
                      .dropAMessageForUserName(widget.model.userName),
                  style: TextStyle(
                      color: AppColors.colorBlack, fontSize: Dimens.fontSize14),
                ),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          Padding(
            padding: Styles.horizontalPadding,
            child: TextField(
              controller: _controller,
              autofocus: true,
              maxLength: 30,
              style: TextStyle(fontSize: Dimens.fontSize12),
              decoration: InputDecoration(
                  hintText: context.language.writeAMessage,
                  hintStyle: const TextStyle(color: AppColors.colorGrey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.r)),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  suffixIcon: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : ValueListenableBuilder(
                          valueListenable: _validMessageNotifier,
                          builder: (_, isValid, __) => InkWell(
                              onTap: !isValid
                                  ? null
                                  : () {
                                      ref
                                          .read(fnfMessageProvider.notifier)
                                          .sendMessage(
                                              token: context.apiToken,
                                              userId: context.userId,
                                              fnfId: widget.model.id,
                                              message: _controller.text.trim());
                                    },
                              child: Icon(
                                Icons.send,
                                color: !isValid
                                    ? AppColors.colorGrey
                                    : AppColors.colorAppGreen,
                              )),
                        )),
            ),
          ),
          16.gapH,
        ],
      ),
    );
  }
}
