/// [ApiConstants] is a class that contains all the api constants.
/// It contains base url and all the api end points
class ApiConstants {
  static const String apiBaseUrlWithHttps = 'https://shojag.com';

  // alert api
  static final String incidentListEndPoint = '/api/incident';
  static final String activeAlertListEndPoint = '/api/active-alerts';
  static final String closedAlertListEndPoint = '/api/closed-alerts';
  static final String myAlertListEndPoint = '/api/my-alerts';
  static final String respondedAlertListEndPoint = '/api/responded-alerts';
  static final String allActiveAlertListEndPoint = '/api/all-active-alert';
  static final String alertDetailEndPoint = '/api/alert-detail';
  static final String alertAddEndPoint = '/api/alert/create';
  static final String alertDeleteEndPoint = '/api/alert-delete';
  static final String alertStatusUpdateEndPoint = '/api/close-alert';
  static final String alertResponseEndPoint = '/api/alert-response';
  static final String alertResponseDeleteEndPoint = '/api/response-delete';
  static final String updateAlertEndPoint = '/api/update-alert';
  static final String reportAlertEndPoint = '/api/alert-report';

  // authentication api
  static final String thanaListEndPoint = '/api/thana';
  static final String loginEndPoint = '/api/login';
  static final String verifyPhoneEndPoint = '/api/verify-phone';
  static final String verifyOtpPoint = '/api/verify-otp';
  static final String registerEndPoint = '/api/register';
  static final String forgotPasswordEmailPhoneEndPoint = '/api/forgot-password';
  static final String forgotPasswordOtpConfirmEndPoint =
      '/api/confirm-reset-otp';
  static final String resetPasswordEndPoint = '/api/reset-password';
  static final String authorizationUserEndPoint = '/api/authorize-user';

  // fnf api
  static final String searchFnfEndPoint = '/api/search-fnf';
  static final String requestFnfEndPoint = '/api/request-fnf';
  static final String acceptFnfEndPoint = '/api/accept-fnf';
  static final String rejectFnfEndPoint = '/api/reject-fnf';
  static final String cancelFnfEndPoint = '/api/cancel-sent-fnf';
  static final String deleteFnfEndPoint = '/api/delete-fnf';
  static final String incomingFnfListFnfEndPoint = '/api/incoming-fnf';
  static final String outgoingFnfListFnfEndPoint = '/api/outgoing-fnf';
  static final String locationShareLimitEndPoint =
      '/api/location-share-status-fnf';
  static final String locationShareRequestEndPoint =
      '/api/location-share-request';
  static final String fnfLocationLabelAddEndPoint = '/api/fnf-location-label-add';
  static final String fnfLocationLabelDeleteEndPoint = '/api/fnf-location-label-delete';
  static final String fnfDetailsEndPoint = '/api/fnf-detail';

  // new fnf api
  static final String searchFriendEndPoint = '/api/search-friend';
  static final String requestFriendEndPoint = '/api/request-friend';
  static final String acceptFriendRequestEndPoint = '/api/accept-friend-request';
  static final String friendDetailEndPoint = '/api/friend-detail';
  static final String friendListEndPoint = '/api/friend-list';
  static final String deleteFriendEndPoint = '/api/delete-friend';
  static final String friendLocationLabelAddEndPoint = '/api/friend-location-label-add';
  static final String friendLocationShareLimitEndPoint =
      '/api/location-share-status-friend';
  static final String friendLocationShareRequestEndPoint =
      '/api/location-share-request-friend';
  static final String friendLocationLabelDeleteEndPoint = '/api/friend-location-label-delete';
  static final String friendMessageUpdateEndPoint = '/api/friend-message-update';

  // profile api
  static final String updateProfileEndPoint = '/api/update-profile';
  static final String updateProfilePicEndPoint = '/api/update-profile-pic';
  static final String updateDeviceTokenEndPoint = '/api/update-device-token';
  static final String updateUserLocationEndPoint = '/api/update-userlocation';
  static final String logoutUserEndPoint = '/api/logout';

  // setting api
  static final String areaLimitUpdateEndPoint = '/api/area-limit';
  static final String updatePasswordEndPoint = '/api/update-password';
  static final String deleteAccountEndPoint = '/api/delete-account';


  // dashboard api
  static final String dashboardAlertEndPoint = '/api/dashboard-alert';


  // premium api
  static final String premiumCheckEndPoint = '/api/is-premium';

  // feedback api
  static final String feedbackSendEndPoint = '/api/app-feedback';

  // payment api
  static final String paymentIpnUrl = '$apiBaseUrlWithHttps/api/ipn';
}

