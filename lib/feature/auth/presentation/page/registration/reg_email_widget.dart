import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/auth_text_field.dart';

class RegEmailWidget extends StatelessWidget {
  final TextEditingController emailController;

  const RegEmailWidget({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      hintText: context.language.email,
      controller: emailController,
      validator: FieldValidators(context).emailNullableValidator,
    );
  }
}
