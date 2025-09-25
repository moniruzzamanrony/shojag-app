import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/validator/field_validators.dart';
import '../../provider/registration_provider.dart';
import '../../widget/auth_text_field.dart';

class RegRepeatPasswordWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  const RegRepeatPasswordWidget(
      {super.key,
      required this.passwordController,
      required this.repeatPasswordController});

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationProvider, bool>(
      selector: (_, provider) => provider.passwordObscureText,
      builder: (_, value, __) => AuthTextField(
        obscureText: value,
        controller: repeatPasswordController,
        suffixIcon: GestureDetector(
          onTap: () {
            context.read<RegistrationProvider>().togglePasswordObscure();
          },
          child: Icon(
            value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.colorAppGrey,
            size: Dimens.iconSize16,
          ),
        ),
        hintText: context.language.repeatPassword,
        validator: (p0) {
          return FieldValidators(context).repeatPasswordValidator(p0,
              anotherValue: passwordController.text);
        },
      ),
    );
  }
}
