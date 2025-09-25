import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/profile_edit_text_field.dart';

class NameEditWidget extends StatelessWidget {
  final TextEditingController firstNameController;

  final TextEditingController lastNameController;

  const NameEditWidget(
      {super.key,
      required this.firstNameController,
      required this.lastNameController});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ProfileEditTextField(
            controller: firstNameController,
            hintText: context.language.firstName,
            labelText: context.language.firstName,
            validator: FieldValidators(context).firstNameValidator,
            suffixIcon: const Icon(Icons.person_outline),
          ),
        ),
        10.gapW,
        Expanded(
          child: ProfileEditTextField(
            controller: lastNameController,
            hintText: context.language.lastName,
            labelText: context.language.lastName,
            suffixIcon: const Icon(Icons.person_outline),
            validator: FieldValidators(context).lastNameValidator,
          ),
        ),
      ],
    );
  }
}
