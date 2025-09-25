import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/validator/field_validators.dart';
import '../../widget/profile_edit_text_field.dart';

class EmailEditWidget extends StatelessWidget {
  final TextEditingController emailController;

  const EmailEditWidget({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return ProfileEditTextField(
      controller: emailController,
      hintText: 'email@example.com',
      labelText: context.language.email,
      validator: FieldValidators(context).emailNullableValidator,
      suffixIcon: const Icon(Icons.email_outlined),
    );
  }
}
