// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(username) =>
      "Add location for <bold>${username}</bold> to get notified when they arrive at the location.\n\n1. Tap on map to add location.\n2. Set a label for it.";

  static String m1(user_type) => "Already responded by ${user_type}";

  static String m2(name) => "Are you sure you want to send request to ${name}";

  static String m3(name) => "By ${name}";

  static String m4(name) => "${name} can\'t be empty";

  static String m5(type) => "New ${type} Alert";

  static String m6(days) => "${days} days left";

  static String m7(name) => "Did not shared location with you ${name}";

  static String m8(name) => "Drop a message for ${name}";

  static String m9(date) => "Expires on ${date}";

  static String m10(hour) => "For ${hour} hour";

  static String m11(name) => "${name}\'s location";

  static String m12(name) => "Message from ${name}:";

  static String m13(type) =>
      "No ${type} alerts found or check your internet connection";

  static String m14(count) => "Password should be at least ${count} characters";

  static String m15(days) => "Remaining : ${days} days";

  static String m16(name) => "Share your real-time location with ${name}";

  static String m17(unit, distance) =>
      "${distance} ${Intl.select(unit, {'km': 'K.M', 'meter': 'Meter', 'other': 'n/a'})}";

  static String m18(currency, amount) => "Unlock Pro ${currency} ${amount}";

  static String m19(currency, amount, days) =>
      "Unlock PRO for ${days} days ${currency} ${amount}";

  static String m20(time) => "Until ${time}";

  static String m21(count) =>
      "You can set ${count} custom Location for each FnF and once they arrive their location you will get a notification.";

  static String m22(date) => "Your subscription will be expire on ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("Accept"),
    "accessToYourLocationWhenTheAppIsInBackground":
        MessageLookupByLibrary.simpleMessage(
          "Access to your location when the app is in the background",
        ),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "activeAlerts": MessageLookupByLibrary.simpleMessage("Active Alerts"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCustomLocation": MessageLookupByLibrary.simpleMessage(
      "Add FnF Custom Location",
    ),
    "addFnf": MessageLookupByLibrary.simpleMessage("Add FnF"),
    "addLocationToolTipWithUsername": m0,
    "addNewFnF": MessageLookupByLibrary.simpleMessage("Add New FnF"),
    "addToFnfList": MessageLookupByLibrary.simpleMessage("Add to FnF"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressAddedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Address added successfully",
    ),
    "addressDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Address deleted successfully",
    ),
    "addressOptional": MessageLookupByLibrary.simpleMessage(
      "Address (Optional)",
    ),
    "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
      "Agree and Continue",
    ),
    "alert": MessageLookupByLibrary.simpleMessage("Alert"),
    "alertClosedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Alert closed successfully",
    ),
    "alertDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Alert deleted successfully",
    ),
    "alertDescription": MessageLookupByLibrary.simpleMessage(
      "Alert Description",
    ),
    "alertDetails": MessageLookupByLibrary.simpleMessage("Alert Details"),
    "alertList": MessageLookupByLibrary.simpleMessage("Alert List"),
    "alertMap": MessageLookupByLibrary.simpleMessage("Alert Map"),
    "alertResponseCancelSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Alert response canceled successfully",
    ),
    "alertUpdate": MessageLookupByLibrary.simpleMessage("Alert Update"),
    "alerts": MessageLookupByLibrary.simpleMessage("Alerts"),
    "allYourDataWillBeDeleted": MessageLookupByLibrary.simpleMessage(
      "All your alerts, responses, fnf and profile data will be deleted. Once you deleted you will lost your access to Shojag.",
    ),
    "allowShojagToAccessYourBackgroundLocationToShare":
        MessageLookupByLibrary.simpleMessage(
          "Allow shojag to access your background location to share with your FnF even app is not in use or closed",
        ),
    "alreadyAMember": MessageLookupByLibrary.simpleMessage("Already a member?"),
    "alreadyInFnfList": MessageLookupByLibrary.simpleMessage("Already in FnF"),
    "alreadyRespondedByUserType": m1,
    "alsoShareThisAlertWith": MessageLookupByLibrary.simpleMessage(
      "Also share this alert with",
    ),
    "ambulance": MessageLookupByLibrary.simpleMessage("Ambulance"),
    "app_title": MessageLookupByLibrary.simpleMessage("Shojag"),
    "areYouSureYouWantToAcceptThisRequest":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to accept this request?",
        ),
    "areYouSureYouWantToCancelFnFRequest": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this FnF Request?",
    ),
    "areYouSureYouWantToCancelThisResponse":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to cancel this response?",
        ),
    "areYouSureYouWantToCloseThisAlert": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to close this alert?",
    ),
    "areYouSureYouWantToDeclineThisRequest":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to decline this request?",
        ),
    "areYouSureYouWantToDeleteThisAlert": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this alert?",
    ),
    "areYouSureYouWantToDeleteThisResponse":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to delete this response?",
        ),
    "areYouSureYouWantToDeleteYourAccount":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to delete your account?",
        ),
    "areYouSureYouWantToRemoveAddress": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove this address?",
    ),
    "areYouSureYouWantToRemoveFromYourFnfList":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to remove this from your FnF list?",
        ),
    "areYouSureYouWantToRespondToThisAlert":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to respond to this alert?",
        ),
    "areYouSureYouWantToSendRequestToUserName": m2,
    "areYouSureYouWantToUpdateThisAlert": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to update this alert?",
    ),
    "backgroundLocation": MessageLookupByLibrary.simpleMessage(
      "Background Location",
    ),
    "bangla": MessageLookupByLibrary.simpleMessage("Bangla"),
    "byWithName": m3,
    "call": MessageLookupByLibrary.simpleMessage("Call"),
    "callNowToTalk": MessageLookupByLibrary.simpleMessage(
      "Call now <call>999</call> to talk",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "canNotBeNullOrEmptyByField": m4,
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("Cancel Request"),
    "captureOrUploadImage": MessageLookupByLibrary.simpleMessage(
      "Capture or upload image",
    ),
    "change": MessageLookupByLibrary.simpleMessage("Change"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePermission": MessageLookupByLibrary.simpleMessage(
      "Change Permission",
    ),
    "changeYourAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Change your account password",
    ),
    "citizen": MessageLookupByLibrary.simpleMessage("Citizen"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closed": MessageLookupByLibrary.simpleMessage("Closed"),
    "closedAlerts": MessageLookupByLibrary.simpleMessage("Closed Alerts"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "community": MessageLookupByLibrary.simpleMessage("Community"),
    "communityAlertCreateInfoNotice": MessageLookupByLibrary.simpleMessage(
      "Due to the limited number of communities currently using this app, community support may be delayed. We are growing, and we hope this trend will continue to improve over time.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmation": MessageLookupByLibrary.simpleMessage("Confirmation"),
    "congratulationsWithQuotes": MessageLookupByLibrary.simpleMessage(
      "Congratulations!",
    ),
    "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
    "createAlert": MessageLookupByLibrary.simpleMessage("Create Alert"),
    "createTypeNewAlert": m5,
    "currentPassword": MessageLookupByLibrary.simpleMessage("Old Password"),
    "currentSubscription": MessageLookupByLibrary.simpleMessage(
      "Current Subscription",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
    "daysLeft": m6,
    "decline": MessageLookupByLibrary.simpleMessage("Decline"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deletePermanently": MessageLookupByLibrary.simpleMessage(
      "Delete Permanently",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Delete Your Account",
    ),
    "describeYourIncident": MessageLookupByLibrary.simpleMessage(
      "Describe your incident",
    ),
    "didNotReceivedCode": MessageLookupByLibrary.simpleMessage(
      "Didn\'t received code?",
    ),
    "didNotSharedLocationWithYouUserName": m7,
    "district": MessageLookupByLibrary.simpleMessage("District"),
    "dob": MessageLookupByLibrary.simpleMessage("DOB"),
    "dropAMessageForUserName": m8,
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "egFlatNoRoadNo": MessageLookupByLibrary.simpleMessage(
      "eg. Flat No. Road No.",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "emailShouldBeValid": MessageLookupByLibrary.simpleMessage(
      "Email should be valid",
    ),
    "emergency": MessageLookupByLibrary.simpleMessage("Emergency"),
    "emergencyService": MessageLookupByLibrary.simpleMessage(
      "Emergency Service",
    ),
    "enableBackgroundLocationToShareYourLocation":
        MessageLookupByLibrary.simpleMessage(
          "Enable background location to keep sharing your location even when the app is not active.",
        ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Enter Password"),
    "enterPlaceName": MessageLookupByLibrary.simpleMessage("Enter place name"),
    "enterTheOtpSentToTheNumber": MessageLookupByLibrary.simpleMessage(
      "Enter the OTP sent to the number",
    ),
    "enterYourPasswordToProceed": MessageLookupByLibrary.simpleMessage(
      "Enter your password to proceed",
    ),
    "expireOn": m9,
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "feedbackSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Feedback submitted successfully",
    ),
    "female": MessageLookupByLibrary.simpleMessage("Female"),
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "fireStation": MessageLookupByLibrary.simpleMessage("Fire Station"),
    "fireStationIsRequired": MessageLookupByLibrary.simpleMessage(
      "Fire station is required",
    ),
    "fire_service": MessageLookupByLibrary.simpleMessage("Fire Service"),
    "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "firstNameIsRequired": MessageLookupByLibrary.simpleMessage(
      "First name is required",
    ),
    "fnf": MessageLookupByLibrary.simpleMessage("FnF"),
    "fnfLocator": MessageLookupByLibrary.simpleMessage("FnF Locator"),
    "forWithHour": m10,
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "forgot_password": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "genderIsRequired": MessageLookupByLibrary.simpleMessage(
      "Gender is required",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("Get Started"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hospitalAgency": MessageLookupByLibrary.simpleMessage("Hospital/Agency"),
    "hospitalOrAgencyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Hospital or Agency is required",
    ),
    "iAgreeToThe": MessageLookupByLibrary.simpleMessage("I agree to the"),
    "iAmSure": MessageLookupByLibrary.simpleMessage("I\'m Sure"),
    "iAmSureAboutTheAlert": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to create this alert? Fake alerts may lead to lagal action and account suspension.",
    ),
    "ifYouFindThisAlertPostCommentMisleading": MessageLookupByLibrary.simpleMessage(
      "If you find this alert/post/comments to be false, misleading, or inappropriate, please report it. Our team will review and take necessary actions.",
    ),
    "invite": MessageLookupByLibrary.simpleMessage("Invite"),
    "joinNow": MessageLookupByLibrary.simpleMessage("Join Now"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "lastNameIsRequired": MessageLookupByLibrary.simpleMessage(
      "Last name is required",
    ),
    "latestAlerts": MessageLookupByLibrary.simpleMessage("Latest Alerts"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading"),
    "locateYourFnf": MessageLookupByLibrary.simpleMessage("Locate Your FnF"),
    "locateYourFnfLiveLocation": MessageLookupByLibrary.simpleMessage(
      "You can locate your FnF anywhere around the world and view their live location",
    ),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "locationAccessRequired": MessageLookupByLibrary.simpleMessage(
      "Location access required",
    ),
    "locationSettings": MessageLookupByLibrary.simpleMessage(
      "Location Settings",
    ),
    "locationWithUserName": m11,
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginAgain": MessageLookupByLibrary.simpleMessage("Login Again"),
    "loginAgainToContinue": MessageLookupByLibrary.simpleMessage(
      "Login again to continue",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "male": MessageLookupByLibrary.simpleMessage("Male"),
    "map": MessageLookupByLibrary.simpleMessage("Map"),
    "message": MessageLookupByLibrary.simpleMessage("Message"),
    "messageFromUserName": m12,
    "messageSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Message sent successfully",
    ),
    "myAlerts": MessageLookupByLibrary.simpleMessage("My Alerts"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameIsRequired": MessageLookupByLibrary.simpleMessage("Name is required"),
    "newAlert": MessageLookupByLibrary.simpleMessage("New Alert"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPlace": MessageLookupByLibrary.simpleMessage("New Place"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "nid": MessageLookupByLibrary.simpleMessage("NID"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noAlertFound": MessageLookupByLibrary.simpleMessage("No alert found"),
    "noAlertsFoundTypeOrCheckInternet": m13,
    "noContactsFound": MessageLookupByLibrary.simpleMessage(
      "No contacts found",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noMessagesFound": MessageLookupByLibrary.simpleMessage(
      "Didn\'t send any messages yet",
    ),
    "noResponsesYet": MessageLookupByLibrary.simpleMessage("No responses yet"),
    "noUserFound": MessageLookupByLibrary.simpleMessage(
      "No user found. Check the number and try again",
    ),
    "notAMember": MessageLookupByLibrary.simpleMessage("Not a member?"),
    "notification": MessageLookupByLibrary.simpleMessage("Notification"),
    "off": MessageLookupByLibrary.simpleMessage("Off"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "on": MessageLookupByLibrary.simpleMessage("On"),
    "organization": MessageLookupByLibrary.simpleMessage("Organization"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otpVerification": MessageLookupByLibrary.simpleMessage("OTP Verification"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordDidNotMatch": MessageLookupByLibrary.simpleMessage(
      "Repeat password didn\'t match",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordShouldBeAtLeastCharacters": m14,
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "permissionLocationSettings": MessageLookupByLibrary.simpleMessage(
      "App Settings > Permissions > Location > Allow all the time",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "phoneNumberIsRequired": MessageLookupByLibrary.simpleMessage(
      "Phone number is required",
    ),
    "phoneShouldBeElevenDigits": MessageLookupByLibrary.simpleMessage(
      "Phone number should be 11 digits",
    ),
    "pleaseEnter4DigitOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter 4 digit OTP Code, we sent to",
    ),
    "pleaseExplainInDetailWhyYouWantToReportAnIssue":
        MessageLookupByLibrary.simpleMessage(
          "Please explain in detail why you want to report an issue and include any additional information to help us resolve the issue as quickly as possible.",
        ),
    "pleaseProvideYourValuableFeedback": MessageLookupByLibrary.simpleMessage(
      "Please provide your valuable feedback about the app. It will help us improve our service.",
    ),
    "pleaseSelectAnIncidentType": MessageLookupByLibrary.simpleMessage(
      "Please select an incident type",
    ),
    "pleaseUpgradeToProToUnlockAllFeatures":
        MessageLookupByLibrary.simpleMessage(
          "Please upgrade to PRO to unlock all features",
        ),
    "police": MessageLookupByLibrary.simpleMessage("Police"),
    "policeId": MessageLookupByLibrary.simpleMessage("Police ID"),
    "policeIdIsRequired": MessageLookupByLibrary.simpleMessage(
      "Police ID is required",
    ),
    "postAlert": MessageLookupByLibrary.simpleMessage("Post Alert"),
    "premiumFeatures": MessageLookupByLibrary.simpleMessage("Premium Features"),
    "previous": MessageLookupByLibrary.simpleMessage("Previous"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "pro": MessageLookupByLibrary.simpleMessage("PRO"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "radius": MessageLookupByLibrary.simpleMessage("Radius"),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registration": MessageLookupByLibrary.simpleMessage("Registration"),
    "remainingDays": m15,
    "renewSubscription": MessageLookupByLibrary.simpleMessage(
      "Renew Subscription",
    ),
    "repeatPassword": MessageLookupByLibrary.simpleMessage("Repeat Password"),
    "repeatPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Repeat password is required",
    ),
    "reportAnIssue": MessageLookupByLibrary.simpleMessage("Report an issue"),
    "reportSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Report submitted successfully",
    ),
    "requestSent": MessageLookupByLibrary.simpleMessage("Request sent"),
    "requestSentWaitForAccept": MessageLookupByLibrary.simpleMessage(
      "Request sent. Please wait until accept",
    ),
    "requestToShareLocation": MessageLookupByLibrary.simpleMessage(
      "Request to share location",
    ),
    "resend": MessageLookupByLibrary.simpleMessage("Resend"),
    "resendOtp": MessageLookupByLibrary.simpleMessage("Resend OTP"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetYourAccountPasswordAndAccess": MessageLookupByLibrary.simpleMessage(
      "Reset your account password and access your personal account again",
    ),
    "responded": MessageLookupByLibrary.simpleMessage("Responded"),
    "respondedAlerts": MessageLookupByLibrary.simpleMessage("Responded Alerts"),
    "response": MessageLookupByLibrary.simpleMessage("Response"),
    "responseSent": MessageLookupByLibrary.simpleMessage("Response sent"),
    "responses": MessageLookupByLibrary.simpleMessage("Responses"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchFnf": MessageLookupByLibrary.simpleMessage("Search FnF"),
    "searchNumber": MessageLookupByLibrary.simpleMessage("Search Number"),
    "searchResults": MessageLookupByLibrary.simpleMessage("Search Results"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See All"),
    "selectALocation": MessageLookupByLibrary.simpleMessage(
      "Select a location",
    ),
    "selectAlertLocation": MessageLookupByLibrary.simpleMessage(
      "Select alert location",
    ),
    "selectAnOption": MessageLookupByLibrary.simpleMessage("Select an option"),
    "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
      "Select app language",
    ),
    "selectDistrict": MessageLookupByLibrary.simpleMessage("Select District"),
    "selectHowYouWantToJoinWith": MessageLookupByLibrary.simpleMessage(
      "Select how you want to join with",
    ),
    "selectIncidentType": MessageLookupByLibrary.simpleMessage(
      "Select incident type",
    ),
    "selectThana": MessageLookupByLibrary.simpleMessage("Select Thana"),
    "selectYourAreaRadius": MessageLookupByLibrary.simpleMessage(
      "Select your area radius",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "setANewPassword": MessageLookupByLibrary.simpleMessage(
      "Set a new password to access your account",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "shareLocation": MessageLookupByLibrary.simpleMessage("Share Location"),
    "shareYourRealTimeLocationWithName": m16,
    "sharingPermission": MessageLookupByLibrary.simpleMessage(
      "Sharing Permission",
    ),
    "sharingWithYou": MessageLookupByLibrary.simpleMessage("Sharing with you"),
    "shojagCollectsBackgroundLocationToShareWithFnF":
        MessageLookupByLibrary.simpleMessage(
          "Shojag collects your location data in the background to share with your FnF, even when the app is not in use or closed.",
        ),
    "shojagCollectsYourLocationDataTo": MessageLookupByLibrary.simpleMessage(
      "Shojag collects your location data to:",
    ),
    "shojagLocationDataUsageMessages": MessageLookupByLibrary.simpleMessage(
      "<tab1/><icon/> Identify your current location.<br/><tab1/><icon/> Notify you about nearby alerts created by other users.<br/><tab1/><icon/> Notify your friends and family when you reach specific places.<br/><tab1/><icon/> Share your live location with selected contacts and your data will be securely stored and <bold>only</bold> shared with contacts you approve.<br/><br/><bold>This data is collected even when the app is closed or not in use</bold> to ensure accurate alerts and real-time updates.<br/><br/><red>⚠ <bold>Without this permission, Shojag cannot provide its core features.</bold></red>",
    ),
    "shortDescription": MessageLookupByLibrary.simpleMessage(
      "Short Description",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "starRequired": MessageLookupByLibrary.simpleMessage("* Required"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "submitReport": MessageLookupByLibrary.simpleMessage("Submit Report"),
    "subscription": MessageLookupByLibrary.simpleMessage("Subscription"),
    "successWithQuotes": MessageLookupByLibrary.simpleMessage("Success!"),
    "tapOnMapToAddALocationAddSetALabel": MessageLookupByLibrary.simpleMessage(
      "Tap on map to add a location and set a label",
    ),
    "tapToSendMessage": MessageLookupByLibrary.simpleMessage(
      "Tap to send a message",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms and Conditions",
    ),
    "thana": MessageLookupByLibrary.simpleMessage("Thana"),
    "thanaIsRequired": MessageLookupByLibrary.simpleMessage(
      "Thana is required",
    ),
    "thisActionCannotBeUndone": MessageLookupByLibrary.simpleMessage(
      "This is permanent and cannot be undone",
    ),
    "toKMConverter": m17,
    "toShareYourLocationEvenTheApp": MessageLookupByLibrary.simpleMessage(
      "To share your location in even the app is not in use or closed, please enable \'Allow all the time\' permission.",
    ),
    "togetherWeConnectTogetherWeProtect": MessageLookupByLibrary.simpleMessage(
      "Together We Connect, Together We Protect",
    ),
    "tourAgain": MessageLookupByLibrary.simpleMessage("Tour Again"),
    "tripleNine": MessageLookupByLibrary.simpleMessage("999"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "tryPremiumFeatures": MessageLookupByLibrary.simpleMessage(
      "Try Premium Features",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Turn off"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Turn On"),
    "turnOnToGetNotifications": MessageLookupByLibrary.simpleMessage(
      "Turn on to get notifications",
    ),
    "typeOfIncident": MessageLookupByLibrary.simpleMessage("Type of Incident"),
    "unlockProWithCurrencyAndAmount": m18,
    "unlockProWithCurrencyAndAmountAndDays": m19,
    "untilITurnThisOff": MessageLookupByLibrary.simpleMessage(
      "Until I turn this off",
    ),
    "untilWithTime": m20,
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updatePermissionAndService": MessageLookupByLibrary.simpleMessage(
      "Update permission and service",
    ),
    "upgrade": MessageLookupByLibrary.simpleMessage("UPGRADE"),
    "upgradeNow": MessageLookupByLibrary.simpleMessage("Upgrade Now"),
    "upgradeToPro": MessageLookupByLibrary.simpleMessage("Upgrade To Pro"),
    "upgradeToShojagPro": MessageLookupByLibrary.simpleMessage(
      "Upgrade To Shojag Pro",
    ),
    "upgradeToUnlockProFeatures": MessageLookupByLibrary.simpleMessage(
      "Upgrade to unlock PRO features",
    ),
    "verification": MessageLookupByLibrary.simpleMessage("Verification"),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "viewImage": MessageLookupByLibrary.simpleMessage("View Image"),
    "viewMap": MessageLookupByLibrary.simpleMessage("View Map"),
    "viewOnMap": MessageLookupByLibrary.simpleMessage("View On Map"),
    "wantToGetDirectHelp": MessageLookupByLibrary.simpleMessage(
      "Want to get direct help?",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Warning!"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "writeAMessage": MessageLookupByLibrary.simpleMessage("Write a message"),
    "writeShortDescriptionAboutTheIncident":
        MessageLookupByLibrary.simpleMessage(
          "Write short description about the incident",
        ),
    "writeYourFeedbackHere": MessageLookupByLibrary.simpleMessage(
      "Write your feedback here...",
    ),
    "writeYourIssue": MessageLookupByLibrary.simpleMessage("Write your issue"),
    "writeYourMessageHere": MessageLookupByLibrary.simpleMessage(
      "Write your message here",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "you": MessageLookupByLibrary.simpleMessage("You"),
    "youAreNotAPremiumUser": MessageLookupByLibrary.simpleMessage(
      "You are not a premium user. Upgrade now to unlock premium features",
    ),
    "youAreSharing": MessageLookupByLibrary.simpleMessage("You are sharing"),
    "youCanAddUnlimitedFnfWithPremiumUser": MessageLookupByLibrary.simpleMessage(
      "You can add as many FnF as you want, but they also need to be Premium Users",
    ),
    "youCanAddUpToAddressWithCount": m21,
    "yourActiveAlerts": MessageLookupByLibrary.simpleMessage(
      "Your Active Alerts",
    ),
    "yourAlertHasBeenCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your alert has been created successfully",
    ),
    "yourAlertHasBeenUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your alert has been updated successfully",
    ),
    "yourCurrentSubscription": MessageLookupByLibrary.simpleMessage(
      "Your current subscription",
    ),
    "yourLifeLIneInEmergencies": MessageLookupByLibrary.simpleMessage(
      "Your life line in emergencies, just a tap away",
    ),
    "yourSessionHasBeenExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has been expired!",
    ),
    "yourSubscriptionStatus": MessageLookupByLibrary.simpleMessage(
      "Your subscription status",
    ),
    "yourSubscriptionWillBeExpireOnWithDate": m22,
  };
}
