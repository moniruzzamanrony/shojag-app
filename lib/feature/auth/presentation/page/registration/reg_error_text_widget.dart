import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/presentation/widget/error_text_widget.dart';
import '../../provider/registration_provider.dart';

class RegErrorTextWidget extends StatelessWidget {
  const RegErrorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationProvider, String?>(
      selector: (_, provider) => provider.errorMessage,
      builder: (_, errorText, __) => ErrorTextWidget(errorText: errorText),
    );
  }
}
