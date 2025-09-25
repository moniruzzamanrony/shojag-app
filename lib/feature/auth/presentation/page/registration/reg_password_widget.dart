import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/validator/field_validators.dart';
import '../../provider/registration_provider.dart';
import '../../widget/auth_text_field.dart';

class RegPasswordWidget extends StatelessWidget {
  final TextEditingController passwordController;

  const RegPasswordWidget({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationProvider, bool>(
      selector: (_, provider) => provider.passwordObscureText,
      builder: (_, value, __) => AuthTextField(
        obscureText: value,
        controller: passwordController,
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
        hintText: context.language.enterPassword,
        validator: FieldValidators(context).passwordValidator,
      ),
    );
  }
}
