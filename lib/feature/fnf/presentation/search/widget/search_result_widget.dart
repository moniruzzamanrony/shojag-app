import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/fnf_status.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/fnf/presentation/search/provider/fnf_request_provider.dart';
import 'package:app/feature/fnf/presentation/search/provider/fnf_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/operation_state.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../../fnf/domain/entity/search_fnf_result_entity.dart';
import '../../list/provider/fnf_list_provider.dart';
import '../../list/widget/list_picture_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchFnfResultEntity model;

  const SearchResultWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.borderRadius10),
          side: const BorderSide(color: AppColors.colorGreyExtraLight)),
      child: Row(
        children: [
          ListPictureWidget(image: model.userImage),
          _infoSection(context),
        ],
      ),
    );
  }

  Widget _infoSection(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final requestState = ref.watch(fnfRequestProvider).requestState;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.userName,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                4.gapH,
                Text(
                  model.userPhone,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorAppGrey,
                  ),
                ),
                12.gapH,
                if (model.userId == context.userId)
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.h))
                else if (model.fnfStatus == FnfStatus.pending)
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '${context.language.requestSent}\n',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorBlack,
                        ),
                      ),
                      TextSpan(
                        text: context.language.pending,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorAppRed,
                        ),
                      ),
                    ]),
                  )
                else if (model.fnfStatus == FnfStatus.accepted)
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '${context.language.alreadyInFnfList}\n',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorBlack,
                        ),
                      ),
                    ]),
                  )
                else
                  IndexedStack(
                    alignment: Alignment.center,
                    index: requestState == OperationState.waiting ? 1 : 0,
                    children: [
                      FilledButton(
                        onPressed: () {
                          _showAddToFnfDialog(context, ref);
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 20.h),
                          visualDensity: Styles.minimumVisualDensity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                          foregroundColor: AppColors.colorWhite,
                          backgroundColor: AppColors.colorAppGreen,
                        ),
                        child: Text(context.language.addToFnfList),
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddToFnfDialog(BuildContext context, WidgetRef ref) {
    showAppDialog(context,
        dialogWidget: AlertDialog(
          title: Text(context.language.confirmation),
          content: Text(
            context.language
                .areYouSureYouWantToSendRequestToUserName(model.userName),
            style: TextStyle(color: AppColors.colorBlack, fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(context.language.cancel),
            ),
            LoadingAnimatedButton(
              height: 36.h,
              width: 80.w,
              minWidth: 10,
              text: context.language.confirm,
              btnColor: ColoredButtonType.green,
              onTap: (startLoading, stopLoading, btnState) {
                hideAppKeyboard(context);
                _addToFnf(context, ref,
                    startLoading: startLoading, stopLoading: stopLoading);
              },
            ),
          ],
        ));
  }

  void _addToFnf(BuildContext context, WidgetRef ref,
      {required Function startLoading, required Function stopLoading}) {
    startLoading.call();
    ref
        .read(fnfRequestProvider.notifier)
        .sendRequest(
            token: context.apiToken,
            senderId: context.userId,
            receiverId: model.userId)
        .then((v) {
      if (ref.read(fnfRequestProvider).requestState == OperationState.success &&
          context.mounted) {
        context.pop();
        ref
            .read(fnfSearchProvider.notifier)
            .searchFnf(phoneNumber: model.userPhone, token: context.apiToken);
        ref.read(fnfListProvider.notifier).loadList(
              token: context.apiToken,
              userId: context.userId,
            );
      }
    }).whenComplete(() {
      stopLoading.call();
    });
  }
}
