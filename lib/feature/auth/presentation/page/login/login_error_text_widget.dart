import 'package:app/feature/auth/presentation/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/widget/error_text_widget.dart';

class LoginErrorTextWidget extends StatelessWidget {
  const LoginErrorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<LoginProvider, String?>(
      selector: (_, provider) => provider.errorMessage,
      builder: (_, errorText, __) => ErrorTextWidget(
        errorText: errorText,
        maxLines: 2,
      ),
    );
  }
}
