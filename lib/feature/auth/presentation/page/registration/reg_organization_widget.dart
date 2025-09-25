import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/auth_text_field.dart';

class RegOrganizationWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController organizationController;

  const RegOrganizationWidget(
      {super.key,
      required this.hintText,
      required this.organizationController});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      hintText: hintText,
      controller: organizationController,
      validator: (value) => FieldValidators(context)
          .customEmptyOrNullValidator(value, fieldName: hintText),
    );
  }
}
