/* *
* ui: alert details page for notification page;
* */

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/details/page/alert_details_page.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/feature/alert/presentation/details/widget/empty_alert_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertDetailsPageFromNotification extends StatelessWidget {
  final int alertId;

  const AlertDetailsPageFromNotification({super.key, required this.alertId});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      child: FutureBuilder(
        future:
            context.read<AlertDetailsProvider>().loadAlertDetailsWithResponses(
                  userId: context.userId,
                  apiToken: context.apiToken,
                  alertId: alertId,
                ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const EmptyAlertDetails();
          }
          final model = context.read<AlertDetailsProvider>().currentAlert;
          if (model == null) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          return const AlertDetailsPage();
        },
      ),
    );
  }
}
