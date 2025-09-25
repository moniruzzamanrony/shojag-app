import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/profile/presentation/page/edit/profile_edit_page.dart';
import 'package:app/feature/profile/presentation/provider/profile_edit_provider.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/provider/session_provider.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import 'email_edit_widget.dart';
import 'name_edit_widget.dart';

class AmbulanceEditForm extends StatefulWidget {
  final UserAmbulance currentUser;

  const AmbulanceEditForm({super.key, required this.currentUser});

  @override
  State<AmbulanceEditForm> createState() => _AmbulanceEditFormState();
}

class _AmbulanceEditFormState extends State<AmbulanceEditForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _firstNameController =
        TextEditingController(text: widget.currentUser.firstName);
    _lastNameController =
        TextEditingController(text: widget.currentUser.lastName);
    _emailController = TextEditingController(text: widget.currentUser.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        NameEditWidget(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController),
        profileEditItemGap(),
        EmailEditWidget(emailController: _emailController),
        profileEditItemGap(),
        LoadingAnimatedButton(
            height: 48.h,
            width: 1.sw,
            text: context.language.saveChanges,
            onTap: (startLoading, stopLoading, btnState) =>
                _updateAmbulanceProfile(context,
                    startLoading: startLoading, stopLoading: stopLoading),
            btnColor: ColoredButtonType.green)
      ]),
    );
  }

  void _updateAmbulanceProfile(BuildContext ctx,
      {required Function startLoading, required Function stopLoading}) async {
    final profileProvider = ctx.read<ProfileEditProvider>();
    profileProvider.setErrorMessage('');

    if (FocusScope.of(ctx).hasFocus) {
      FocusScope.of(ctx).unfocus();
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final sessionProvider = ctx.read<SessionProvider>();
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;

    startLoading();
    final updatedEntity = await profileProvider
        .updateProfile(
            userId: ctx.userId,
            token: ctx.apiToken,
            firstName: firstName,
            lastName: lastName,
            email: email)
        .onError(
      (error, stackTrace) {
        profileProvider.setErrorMessage(error.toString());
        return null;
      },
    ).whenComplete(() => stopLoading);

    if (updatedEntity != null) {
      await sessionProvider.updateProfileInfoSession(entity: updatedEntity);

      if (ctx.mounted) {
        ctx.pop();
        showAppSnackBar(ctx, ctx.language.profileUpdatedSuccessfully,
            type: MessageType.success);
      }
    }
  }
}
