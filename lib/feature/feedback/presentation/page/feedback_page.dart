import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/core/utils/helper/network_helper.dart';
import 'package:app/feature/feedback/presentation/provider/feedback_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/style/style.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedbackProvider(),
      builder: (_, __) => Scaffold(
        backgroundColor: AppColors.colorAppTransparent,
        resizeToAvoidBottomInset: false,
        body: HomeBackground(
          child: Column(
            children: [
              CustomAppBar(title: context.language.feedback),
              const Expanded(
                child: CurvedBottomBackground(child: _FeedbackForm()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm({super.key});

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  late final FeedbackProvider feedbackProvider;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: Styles.horizontalPadding,
      child: Center(
        child: Column(
          children: [
            32.gapH,
            Text(
              context.language.pleaseProvideYourValuableFeedback,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.2,
              ),
            ),
            16.gapH,
            // _ratingBar(context),
            16.gapH,
            _textForm(context),
            24.gapH,
            LayoutBuilder(
              builder: (ctx, constraints) => Selector<FeedbackProvider, bool>(
                selector: (_, provider) => provider.isValid,
                builder: (_, valid, __) => LoadingAnimatedButton(
                    height: 40.h,
                    width: constraints.maxWidth,
                    onTap: valid
                        ? (startLoading, stopLoading, btnState) =>
                            _submitFeedback(startLoading, stopLoading, btnState,
                                context: context)
                        : null,
                    text: context.language.submit,
                    btnColor: ColoredButtonType.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback(Function startLoading, Function stopLoading, btnState,
      {required BuildContext context}) async {
    hideAppKeyboard(context);
    try {
      startLoading.call();
      final userId = context.userId;
      final token = context.apiToken;

      if (!await isNetworkAvailable) {
        if (context.mounted) {
          throw context.language.noInternetConnection;
        }
      }

      final isReviewSubmitted =
          await feedbackProvider.sendFeedback(token: token, userId: userId);
      if (isReviewSubmitted) {
        if (context.mounted) {
          showAppSnackBar(
              context, context.language.feedbackSubmittedSuccessfully,
              type: MessageType.success);
          textController.text = '';
          feedbackProvider
            ..resetAll()
            ..notify();
        }
      }
    } catch (e) {
      if (context.mounted) {
        showAppSnackBar(context, e.toString(), type: MessageType.error);
      }
    } finally {
      stopLoading.call();
    }
  }

  TextFormField _textForm(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.colorGreyExtraLight),
        borderRadius: BorderRadius.circular(10.r));
    return TextFormField(
      maxLines: 4,
      controller: textController,
      onChanged: (value) {
        context.read<FeedbackProvider>().review = value.trim();
      },
      style: TextStyle(fontSize: 12.sp, color: AppColors.colorBlack),
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          hintText: context.language.writeYourFeedbackHere,
          hintStyle: const TextStyle(
            color: AppColors.colorAppGrey,
          )),
    );
  }
}
