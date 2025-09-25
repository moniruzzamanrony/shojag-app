import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/feature/profile/presentation/page/edit/name_edit_widget.dart';
import 'package:app/feature/profile/presentation/page/edit/profile_edit_page.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:app/shared/presentation/widget/loading_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/enums/gender.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/datetime_helper.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../shared/presentation/provider/session_provider.dart';
import '../../provider/profile_edit_provider.dart';
import '../../widget/profile_edit_text_field.dart';
import 'email_edit_widget.dart';
import 'gender_edit_widget.dart';

class CitizenEditForm extends StatefulWidget {
  final UserCitizen currentUser;

  const CitizenEditForm({super.key, required this.currentUser});

  @override
  State<CitizenEditForm> createState() => _CitizenEditFormState();
}

class _CitizenEditFormState extends State<CitizenEditForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  late final TextEditingController _nidController;
  late final TextEditingController _addressController;
  Gender? _selectedGender;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _firstNameController =
        TextEditingController(text: widget.currentUser.firstName);
    _lastNameController =
        TextEditingController(text: widget.currentUser.lastName);
    _emailController = TextEditingController(text: widget.currentUser.email);
    _dobController = TextEditingController(
        text: widget.currentUser.dob?.formatDate(pattern: pattern_dd_MM_yyyy));
    _nidController = TextEditingController(text: widget.currentUser.nid);
    _addressController =
        TextEditingController(text: widget.currentUser.address);

    _selectedGender = widget.currentUser.gender;
    _selectedDate = widget.currentUser.dob;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _nidController.dispose();
    _addressController.dispose();
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
        GenderEditWidget(
          onChanged: (v) {
            setState(() {
              _selectedGender = v;
            });
          },
          selectedGender: _selectedGender,
        ),
        profileEditItemGap(),
        ProfileEditTextField(
          controller: _dobController,
          readOnly: true,
          hintText: 'Enter your date of birth',
          labelText: context.language.dateOfBirth,
          suffixIcon: const Icon(Icons.calendar_month_outlined),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(1930),
              lastDate: DateTime.now(),
            );
            _selectedDate = date;

            _dobController.text =
                date?.formatDate(pattern: pattern_dd_MM_yyyy) ?? '';
          },
        ),
        profileEditItemGap(),
        ProfileEditTextField(
          controller: _nidController,
          hintText: 'XXX-XXX-XXXX',
          labelText: context.language.nid,
          suffixIcon: const Icon(Icons.numbers_outlined),
        ),
        profileEditItemGap(),
        ProfileEditTextField(
          controller: _addressController,
          hintText: 'Enter your address',
          labelText: context.language.address,
          suffixIcon: const Icon(Icons.location_on_outlined),
        ),
        profileEditItemGap(),
        LoadingAnimatedButton(
            height: 48.h,
            width: 1.sw,
            text: context.language.saveChanges,
            onTap: (startLoading, stopLoading, btnState) =>
                _updateCitizenProfile(context,
                    startLoading: startLoading, stopLoading: stopLoading),
            btnColor: ColoredButtonType.green)
      ]),
    );
  }

  void _updateCitizenProfile(BuildContext ctx,
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
    final dob = _selectedDate?.formatDate(pattern: pattern_YYYYMMdd);
    final nid = _nidController.text;
    final address = _addressController.text;

    startLoading();
    final updatedEntity = await profileProvider
        .updateProfile(
            userId: ctx.userId,
            token: ctx.apiToken,
            gender: _selectedGender?.titleEn,
            firstName: firstName,
            lastName: lastName,
            email: email,
            dob: dob,
            nid: nid,
            address: address)
        .onError(
      (error, stackTrace) {
        profileProvider.setErrorMessage(error.toString());
        return null;
      },
    ).whenComplete(() => stopLoading());

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
