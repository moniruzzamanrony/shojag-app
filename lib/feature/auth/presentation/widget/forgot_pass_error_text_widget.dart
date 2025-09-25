import 'package:app/feature/auth/presentation/provider/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widget/error_text_widget.dart';

class ForgotPassErrorTextWidget extends StatelessWidget {

  const ForgotPassErrorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ForgotPasswordProvider, String?>(
      selector: (_, provider) => provider.errorMessage,
      builder: (_, errorText, __) => ErrorTextWidget(errorText: errorText),
    );
  }
}
