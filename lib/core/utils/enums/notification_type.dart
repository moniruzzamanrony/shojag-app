/// [NotificationType] enum is used to represent the type of the notification
/// these types are used to navigate to the correct screen
/// NotificationType.fromValue(String value) is used to get the notification type from the value
/// Notification sends from the server {FCM} or other push notification service
enum NotificationType {
  none,
  newAlert,
  alertResponse,
  newFnfRequest,
  acceptFnfRequest,
  locationShareRequest,
  locationShareStatusUpdate,
  userReachFnfLocation;

  factory NotificationType.fromValue(String value) {
    return switch (value) {
      'new_alert' => NotificationType.newAlert,
      'responded_alert' => NotificationType.alertResponse,
      'fnf_request_alert' => NotificationType.newFnfRequest,
      'fnf_accept_alert' => NotificationType.acceptFnfRequest,
      'location_share_request' => NotificationType.locationShareRequest,
      'location_share_status_update' =>
        NotificationType.locationShareStatusUpdate,
      'user_reach_fnflocation' => NotificationType.userReachFnfLocation,
      _ => NotificationType.none,
    };
  }
}
