import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/auth_text_field.dart';

class RegEmpIdWidget extends StatelessWidget {
  final TextEditingController empIdController;

  const RegEmpIdWidget({super.key, required this.empIdController});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      hintText: context.language.policeId,
      controller: empIdController,
      validator: (p0) => FieldValidators(context).customEmptyOrNullValidator(p0, fieldName: 'Employee ID'),
    );
  }
}
