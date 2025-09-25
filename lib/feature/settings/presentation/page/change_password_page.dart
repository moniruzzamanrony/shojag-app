/* UI: Change password
 * handle change password
 */

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:app/feature/settings/presentation/provider/change_password_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/dimens.dart';
import '../../../../core/utils/enums/message_type.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../core/utils/style/style.dart';
import '../../../../core/utils/validator/field_validators.dart';
import '../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../shared/presentation/widget/loading_animated_button.dart';

/// Top-level widget that initializes the [ChangePasswordProvider]
/// and injects it into the widget tree using [ChangeNotifierProvider].
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordProvider(),
      child: const _ChangePasswordPage(),
    );
  }
}

/// Stateful widget that builds the Change Password form.
///
/// Handles form validation, password visibility toggle,
/// and submission logic via [_updatePassword].
class _ChangePasswordPage extends StatefulWidget {
  const _ChangePasswordPage({super.key});

  @override
  State<_ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<_ChangePasswordPage> {
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController repeatPasswordController;
  late final FocusNode currentPasswordFocusNode;
  late final FocusNode newPasswordFocusNode;
  late final FocusNode repeatPasswordFocusNode;

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    currentPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    repeatPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    repeatPasswordController.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    repeatPasswordFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomeBackground(
        child: Column(
          children: [
            CustomAppBar(title: context.language.changePassword),
            Expanded(
              child: CurvedBottomBackground(
                child: SingleChildScrollView(
                  padding: Styles.horizontalPadding,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        16.gapH,
                        Selector<ChangePasswordProvider, bool>(
                          selector: (_, provider) =>
                              provider.passwordObscureText,
                          builder: (_, value, __) => AuthTextField(
                            obscureText: value,
                            // validator: FieldValidators.passwordValidator,
                            controller: currentPasswordController,
                            focusNode: currentPasswordFocusNode,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<ChangePasswordProvider>()
                                    .togglePasswordObscure();
                              },
                              child: Icon(
                                value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.colorAppGrey,
                                size: Dimens.iconSize16,
                              ),
                            ),
                            hintText: context.language.currentPassword,
                          ),
                        ),
                        _itemGap(),
                        Selector<ChangePasswordProvider, bool>(
                          selector: (_, provider) =>
                              provider.passwordObscureText,
                          builder: (_, value, __) => AuthTextField(
                            obscureText: value,
                            validator:
                                FieldValidators(context).passwordValidator,
                            controller: newPasswordController,
                            focusNode: newPasswordFocusNode,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<ChangePasswordProvider>()
                                    .togglePasswordObscure();
                              },
                              child: Icon(
                                value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.colorAppGrey,
                                size: Dimens.iconSize16,
                              ),
                            ),
                            hintText: context.language.newPassword,
                          ),
                        ),
                        _itemGap(),
                        Selector<ChangePasswordProvider, bool>(
                          selector: (_, provider) =>
                              provider.passwordObscureText,
                          builder: (_, value, __) => AuthTextField(
                            obscureText: value,
                            validator: (p0) {
                              return FieldValidators(context)
                                  .repeatPasswordValidator(p0,
                                      anotherValue: newPasswordController.text);
                            },
                            controller: repeatPasswordController,
                            focusNode: repeatPasswordFocusNode,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<ChangePasswordProvider>()
                                    .togglePasswordObscure();
                              },
                              child: Icon(
                                value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.colorAppGrey,
                                size: Dimens.iconSize16,
                              ),
                            ),
                            hintText: context.language.repeatPassword,
                          ),
                        ),
                        _itemGap(),
                        LoadingAnimatedButton(
                            height: 48.h,
                            width: 1.sw,
                            text: context.language.changePassword,
                            onTap: (startLoading, stopLoading, btnState) =>
                                _updatePassword(context,
                                    startLoading: startLoading,
                                    stopLoading: stopLoading),
                            btnColor: ColoredButtonType.green)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // each widget item gap
  Widget _itemGap() => 16.gapH;

  /// Handles the password update process:
  /// - Validates the form
  /// - Calls [ChangePasswordProvider.updatePassword] with required params
  /// - Shows success or error message using [showAppSnackBar]
  ///
  /// [startLoading] and [stopLoading] are passed by [LoadingAnimatedButton]
  /// to control the button animation.
  void _updatePassword(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    hideAppKeyboard(context);
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    startLoading();

    final userId = ctx.userId;
    final token = ctx.apiToken;
    final oldPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
   // final repeatPassword = repeatPasswordController.text;

    ctx
        .read<ChangePasswordProvider>()
        .updatePassword(
            token: token,
            userId: userId,
            oldPassword: oldPassword,
            newPassword: newPassword)
        .catchError((e) {
      if (ctx.mounted) {
        showAppSnackBar(ctx, e.toString(), type: MessageType.error);
      }
      return false;
    }).then((isUpdated) {
      if (isUpdated && ctx.mounted) {
        ctx.pop();
        showAppSnackBar(ctx, 'Password Changed Successfully',
            type: MessageType.success);
      }
    }).whenComplete(() {
      stopLoading();
    });
  }
}
