import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/enums/message_type.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/core/utils/validator/field_validators.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/helper/network_helper.dart';
import '../../../domain/entity/alert_entity.dart';

class AlertReportSheet extends StatefulWidget {
  final AlertEntity model;

  const AlertReportSheet({super.key, required this.model});

  @override
  State<AlertReportSheet> createState() => _AlertReportSheetState();
}

class _AlertReportSheetState extends State<AlertReportSheet> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late final GlobalKey<FormFieldState> _textFormFieldKey;

  @override
  void initState() {
    super.initState();
    _textFormFieldKey = GlobalKey<FormFieldState>();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.colorGreyExtraLight.shade(180),
                    foregroundColor: AppColors.colorAppGrey,
                  ),
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close)),
            ),
            Text(
              context.language.submitReport,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            8.gapH,
            Text(
              context.language.pleaseExplainInDetailWhyYouWantToReportAnIssue,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.colorAppGrey,
              ),
            ),
            16.gapH,
            TextFormField(
                key: _textFormFieldKey,
                controller: _textEditingController,
                focusNode: _focusNode,
                maxLines: 5,
                validator: FieldValidators(context).emptyOrNullValidator,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorGreyExtraLight.shade(180),
                  hintStyle: const TextStyle(color: AppColors.colorAppGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  hintText: context.language.writeYourMessageHere,
                )),
            20.gapH,
            Align(
                child: LoadingAnimatedButton(
              height: 48.h,
              width: 1.sw,
              text: context.language.submitReport,
              btnColor: ColoredButtonType.red,
              onTap: _submitReport,
            )),
            20.gapH,
            MediaQuery.viewInsetsOf(context).bottom.gapH,
          ],
        ),
      ),
    );
  }

  void _submitReport(
      Function startLoading, Function stopLoading, ButtonState btnState) async {
    _focusNode.unfocus();
    if (!_textFormFieldKey.currentState!.validate()) {
      return;
    }
    final userId = context.userId;
    final token = context.apiToken;
    final alertId = widget.model.id;
    final comment = _textEditingController.text;

    final detailsProvider = context.read<AlertDetailsProvider>();

    if (!await isNetworkAvailable) {
      if (mounted) {
        showAppSnackBar(context, context.language.noInternetConnection,
            type: MessageType.normal);
      }
      return;
    }

    startLoading.call();
    final isReported = await detailsProvider
        .reportAlert(userId, token, alertId, comment)
        .onError((error, stackTrace) {
      if (mounted) {
        showAppSnackBar(context, error.toString(), type: MessageType.normal);
      }
      return false;
    }).whenComplete(() {
      stopLoading.call();
    });
    if (isReported) {
      if (mounted) {
        context.pop();
        showAppSnackBar(context, context.language.reportSubmittedSuccessfully,
            type: MessageType.success);
      }
    }
  }
}
