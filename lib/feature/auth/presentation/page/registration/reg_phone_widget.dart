import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/validator/field_validators.dart';
import '../../provider/registration_provider.dart';
import '../../widget/auth_text_field.dart';
import '../../widget/otp_dialog.dart';

class RegPhoneWidget extends StatefulWidget {
  final TextEditingController phoneController;

  const RegPhoneWidget({super.key, required this.phoneController});

  @override
  State<RegPhoneWidget> createState() => _RegPhoneWidgetState();
}

class _RegPhoneWidgetState extends State<RegPhoneWidget> {
  final _phoneFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationProvider, bool>(
      selector: (_, provider) => provider.isPhoneVerified,
      builder: (_, isPhoneVerified, __) => AuthTextField(
        mKey: _phoneFieldKey,
        hintText: context.language.phone,
        readOnly: isPhoneVerified,
        keyboardType: TextInputType.phone,
        controller: widget.phoneController,
        validator: FieldValidators(context).phoneValidator,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        suffixIcon: isPhoneVerified
            ? Icon(
                Icons.check_circle,
                color: context.colorScheme.primary,
                size: Dimens.iconSize16,
              )
            : Selector<RegistrationProvider, bool>(
                selector: (_, provider) => provider.isPhoneVerifying,
                builder: (_, isPhoneVerifying, __) => isPhoneVerifying
                    ? Align(
                        alignment: Alignment.centerRight,
                        widthFactor: 0.2,
                        child: Container(
                            height: 16.r,
                            width: 16.r,
                            margin: EdgeInsets.only(right: 10.w),
                            child: const CircularProgressIndicator()))
                    : InkWell(
                        onTap: () {
                          _verifyPhone(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            context.language.verify,
                            style:
                                const TextStyle(color: AppColors.colorAppGreen),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  void _verifyPhone(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final registrationProvider = context.read<RegistrationProvider>();
    registrationProvider.setErrorMessage('');

    final isValid = _phoneFieldKey.currentState?.validate();
    if (isValid != true) {
      return;
    }

    final phoneNumber = widget.phoneController.text;
    final tempId = await registrationProvider.verifyPhone(phoneNumber).onError(
      (error, stackTrace) {
        registrationProvider.setErrorMessage(error.toString());
        return -1;
      },
    );

    if (tempId > 0) {
      if (!context.mounted) {
        return;
      }
      showAppDialog(context,
          barrierDismissible: false,
          dialogWidget: OtpDialog(
            phoneNumber: phoneNumber,
            tempId: tempId,
          ));
    }
  }
}
