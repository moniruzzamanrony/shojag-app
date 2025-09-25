import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/auth_text_field.dart';

class RegNameWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const RegNameWidget(
      {super.key,
      required this.firstNameController,
      required this.lastNameController});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: AuthTextField(
          hintText: context.language.firstName,
          validator: FieldValidators(context).firstNameValidator,
          controller: firstNameController,
        )),
        10.gapW,
        Expanded(
            child: AuthTextField(
          hintText: context.language.lastName,
          controller: lastNameController,
          validator: FieldValidators(context).lastNameValidator,
        )),
      ],
    );
  }
}
