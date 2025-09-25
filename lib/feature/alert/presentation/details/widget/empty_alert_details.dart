import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../fnf/presentation/search/widget/empty_contact_list_widget.dart';

class EmptyAlertDetails extends StatelessWidget {
  const EmptyAlertDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      hasBottomCurve: true,
      child: Column(
        children: [
          CustomAppBar(title: context.language.alertDetails),
          const Expanded(
            child: CurvedBottomBackground(
              child: EmptyContactListWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
