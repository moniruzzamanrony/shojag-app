import 'package:go_router/go_router.dart';

import '../config/router/app_router.dart';
import '../config/router/routes.dart';
import '../utils/enums/notification_type.dart';

/// [NotificationManager] is used to manage notifications
/// It is used to navigate to the correct screen
/// on notification click
/// or open the app on notification click
abstract class NotificationManager {
  void redirection(Map<String, dynamic> data) {
    // check notification type
    final notificationType = data['notification_type'] as String?;
    if (notificationType == null) return;
    final type = NotificationType.fromValue(notificationType);
    if (type == NotificationType.none) return;

    final context = rootNavigatorKey.currentState?.context;
    if (context == null) return;

    try {
      switch (type) {
        // for alert
        case NotificationType.newAlert:
          final alertId = int.tryParse(data['value']);
          if (alertId == null) return;
          context.goNamed(Routes.alertDetailsFromNotification, extra: alertId);
          break;
        case NotificationType.alertResponse:
          final alertId = int.tryParse(data['value']);
          if (alertId == null) return;
          context.goNamed(Routes.alertDetailsFromNotification, extra: alertId);
          break;

        // for fnf
        case NotificationType.locationShareRequest:
          final fnfId = int.tryParse(data['value']);
          if (fnfId == null) return;
          context.goNamed(Routes.fnfHome, extra: <String, dynamic>{
            'is_from_notification': true,
            'notification_type': type,
            'fnf_id': fnfId
          });
          break;

        case NotificationType.locationShareStatusUpdate:
          final fnfId = int.tryParse(data['value']);
          if (fnfId == null) return;
          context.goNamed(Routes.fnfHome, extra: <String, dynamic>{
            'is_from_notification': true,
            'notification_type': type,
            'fnf_id': fnfId
          });
          break;

        case NotificationType.userReachFnfLocation:
          final fnfId = int.tryParse(data['value']);
          if (fnfId == null) return;
          context.goNamed(Routes.fnfHome, extra: <String, dynamic>{
            'is_from_notification': true,
            'notification_type': type,
            'fnf_id': fnfId
          });
          break;

        case NotificationType.newFnfRequest:
          final fnfId = int.tryParse(data['value']);
          if (fnfId == null) return;
          context.goNamed(Routes.fnfHome, extra: <String, dynamic>{
            'is_from_notification': true,
            'notification_type': type,
            'fnf_id': fnfId
          });
          break;

        case NotificationType.acceptFnfRequest:
          final fnfId = int.tryParse(data['value']);
          if (fnfId == null) return;
          context.goNamed(Routes.fnfHome, extra: <String, dynamic>{
            'is_from_notification': true,
            'notification_type': type,
            'fnf_id': fnfId
          });
          break;

        default:
          return;
      }
    } catch (_) {}
  }
}
