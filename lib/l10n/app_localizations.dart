import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Shojag'**
  String get app_title;

  /// No description provided for @citizen.
  ///
  /// In en, this message translates to:
  /// **'Field Officer'**
  String get citizen;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Officer'**
  String get police;

  /// No description provided for @ambulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get ambulance;

  /// No description provided for @fire_service.
  ///
  /// In en, this message translates to:
  /// **'Fire Service'**
  String get fire_service;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @yourLifeLIneInEmergencies.
  ///
  /// In en, this message translates to:
  /// **'Your life line in emergencies, just a tap away'**
  String get yourLifeLIneInEmergencies;

  /// No description provided for @togetherWeConnectTogetherWeProtect.
  ///
  /// In en, this message translates to:
  /// **'Together We Connect, Together We Protect'**
  String get togetherWeConnectTogetherWeProtect;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member?'**
  String get notAMember;

  /// No description provided for @joinNow.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get joinNow;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @selectHowYouWantToJoinWith.
  ///
  /// In en, this message translates to:
  /// **'Select how you want to join with'**
  String get selectHowYouWantToJoinWith;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @policeId.
  ///
  /// In en, this message translates to:
  /// **'Police ID'**
  String get policeId;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get dob;

  /// No description provided for @nid.
  ///
  /// In en, this message translates to:
  /// **'NID'**
  String get nid;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @thana.
  ///
  /// In en, this message translates to:
  /// **'Thana'**
  String get thana;

  /// No description provided for @selectThana.
  ///
  /// In en, this message translates to:
  /// **'Select Thana'**
  String get selectThana;

  /// No description provided for @fireStation.
  ///
  /// In en, this message translates to:
  /// **'Fire Station'**
  String get fireStation;

  /// No description provided for @hospitalAgency.
  ///
  /// In en, this message translates to:
  /// **'Hospital/Agency'**
  String get hospitalAgency;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @selectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get selectDistrict;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeatPassword;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iAgreeToThe;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyAMember.
  ///
  /// In en, this message translates to:
  /// **'Already a member?'**
  String get alreadyAMember;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @enterTheOtpSentToTheNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to the number'**
  String get enterTheOtpSentToTheNumber;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @resetYourAccountPasswordAndAccess.
  ///
  /// In en, this message translates to:
  /// **'Reset your account password and access your personal account again'**
  String get resetYourAccountPasswordAndAccess;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @pleaseEnter4DigitOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter 4 digit OTP Code, we sent to'**
  String get pleaseEnter4DigitOtp;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @didNotReceivedCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t received code?'**
  String get didNotReceivedCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @setANewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set a new password to access your account'**
  String get setANewPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @alerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alerts;

  /// No description provided for @fnf.
  ///
  /// In en, this message translates to:
  /// **'FnF'**
  String get fnf;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @emergencyService.
  ///
  /// In en, this message translates to:
  /// **'Emergency Service'**
  String get emergencyService;

  /// No description provided for @newAlert.
  ///
  /// In en, this message translates to:
  /// **'New Alert'**
  String get newAlert;

  /// No description provided for @alertList.
  ///
  /// In en, this message translates to:
  /// **'Alert List'**
  String get alertList;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @myAlerts.
  ///
  /// In en, this message translates to:
  /// **'My Alerts'**
  String get myAlerts;

  /// No description provided for @respondedAlerts.
  ///
  /// In en, this message translates to:
  /// **'Responded Alerts'**
  String get respondedAlerts;

  /// No description provided for @closedAlerts.
  ///
  /// In en, this message translates to:
  /// **'Closed Alerts'**
  String get closedAlerts;

  /// No description provided for @activeAlerts.
  ///
  /// In en, this message translates to:
  /// **'Active Alerts'**
  String get activeAlerts;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @tripleNine.
  ///
  /// In en, this message translates to:
  /// **'999'**
  String get tripleNine;

  /// No description provided for @pleaseProvideYourValuableFeedback.
  ///
  /// In en, this message translates to:
  /// **'Please provide your valuable feedback about the app. It will help us improve our service.'**
  String get pleaseProvideYourValuableFeedback;

  /// No description provided for @writeYourFeedbackHere.
  ///
  /// In en, this message translates to:
  /// **'Write your feedback here...'**
  String get writeYourFeedbackHere;

  /// No description provided for @feedbackSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Feedback submitted successfully'**
  String get feedbackSubmittedSuccessfully;

  /// No description provided for @createAlert.
  ///
  /// In en, this message translates to:
  /// **'Create Alert'**
  String get createAlert;

  /// No description provided for @latestAlerts.
  ///
  /// In en, this message translates to:
  /// **'Latest Alerts'**
  String get latestAlerts;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @responded.
  ///
  /// In en, this message translates to:
  /// **'Responded'**
  String get responded;

  /// No description provided for @yourActiveAlerts.
  ///
  /// In en, this message translates to:
  /// **'Your Active Alerts'**
  String get yourActiveAlerts;

  /// No description provided for @alertMap.
  ///
  /// In en, this message translates to:
  /// **'Alert Map'**
  String get alertMap;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @noAlertFound.
  ///
  /// In en, this message translates to:
  /// **'No alert found'**
  String get noAlertFound;

  /// No description provided for @createTypeNewAlert.
  ///
  /// In en, this message translates to:
  /// **'New {type} Alert'**
  String createTypeNewAlert(Object type);

  /// No description provided for @selectIncidentType.
  ///
  /// In en, this message translates to:
  /// **'Select incident type'**
  String get selectIncidentType;

  /// No description provided for @describeYourIncident.
  ///
  /// In en, this message translates to:
  /// **'Describe your incident'**
  String get describeYourIncident;

  /// No description provided for @selectAlertLocation.
  ///
  /// In en, this message translates to:
  /// **'Select alert location'**
  String get selectAlertLocation;

  /// No description provided for @egFlatNoRoadNo.
  ///
  /// In en, this message translates to:
  /// **'eg. Flat No. Road No.'**
  String get egFlatNoRoadNo;

  /// No description provided for @captureOrUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Capture or upload image'**
  String get captureOrUploadImage;

  /// No description provided for @selectAnOption.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get selectAnOption;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @alsoShareThisAlertWith.
  ///
  /// In en, this message translates to:
  /// **'Also share this alert with'**
  String get alsoShareThisAlertWith;

  /// No description provided for @starRequired.
  ///
  /// In en, this message translates to:
  /// **'* Required'**
  String get starRequired;

  /// No description provided for @pleaseSelectAnIncidentType.
  ///
  /// In en, this message translates to:
  /// **'Please select an incident type'**
  String get pleaseSelectAnIncidentType;

  /// No description provided for @writeShortDescriptionAboutTheIncident.
  ///
  /// In en, this message translates to:
  /// **'Write short description about the incident'**
  String get writeShortDescriptionAboutTheIncident;

  /// No description provided for @selectALocation.
  ///
  /// In en, this message translates to:
  /// **'Select a location'**
  String get selectALocation;

  /// No description provided for @postAlert.
  ///
  /// In en, this message translates to:
  /// **'Post Alert'**
  String get postAlert;

  /// No description provided for @successWithQuotes.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get successWithQuotes;

  /// No description provided for @congratulationsWithQuotes.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulationsWithQuotes;

  /// No description provided for @yourAlertHasBeenCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your alert has been created successfully'**
  String get yourAlertHasBeenCreatedSuccessfully;

  /// No description provided for @iAmSure.
  ///
  /// In en, this message translates to:
  /// **'I\'m Sure'**
  String get iAmSure;

  /// No description provided for @iAmSureAboutTheAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to create this alert? Fake alerts may lead to lagal action and account suspension.'**
  String get iAmSureAboutTheAlert;

  /// No description provided for @communityAlertCreateInfoNotice.
  ///
  /// In en, this message translates to:
  /// **'Due to the limited number of communities currently using this app, community support may be delayed. We are growing, and we hope this trend will continue to improve over time.'**
  String get communityAlertCreateInfoNotice;

  /// No description provided for @alertUpdate.
  ///
  /// In en, this message translates to:
  /// **'Alert Update'**
  String get alertUpdate;

  /// No description provided for @addressOptional.
  ///
  /// In en, this message translates to:
  /// **'Address (Optional)'**
  String get addressOptional;

  /// No description provided for @yourAlertHasBeenUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your alert has been updated successfully'**
  String get yourAlertHasBeenUpdatedSuccessfully;

  /// No description provided for @noAlertsFoundTypeOrCheckInternet.
  ///
  /// In en, this message translates to:
  /// **'No {type} alerts found or check your internet connection'**
  String noAlertsFoundTypeOrCheckInternet(Object type);

  /// No description provided for @byWithName.
  ///
  /// In en, this message translates to:
  /// **'By {name}'**
  String byWithName(Object name);

  /// No description provided for @toKMConverter.
  ///
  /// In en, this message translates to:
  /// **'{distance} {unit, select, km{K.M} meter{Meter} other{n/a}}'**
  String toKMConverter(String unit, num distance);

  /// No description provided for @alertDetails.
  ///
  /// In en, this message translates to:
  /// **'Alert Details'**
  String get alertDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @typeOfIncident.
  ///
  /// In en, this message translates to:
  /// **'Type of Incident'**
  String get typeOfIncident;

  /// No description provided for @shortDescription.
  ///
  /// In en, this message translates to:
  /// **'Short Description'**
  String get shortDescription;

  /// No description provided for @alertDescription.
  ///
  /// In en, this message translates to:
  /// **'Alert Description'**
  String get alertDescription;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @viewImage.
  ///
  /// In en, this message translates to:
  /// **'View Image'**
  String get viewImage;

  /// No description provided for @viewMap.
  ///
  /// In en, this message translates to:
  /// **'View Map'**
  String get viewMap;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View On Map'**
  String get viewOnMap;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @responses.
  ///
  /// In en, this message translates to:
  /// **'Responses'**
  String get responses;

  /// No description provided for @noResponsesYet.
  ///
  /// In en, this message translates to:
  /// **'No responses yet'**
  String get noResponsesYet;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @areYouSureYouWantToDeleteThisAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this alert?'**
  String get areYouSureYouWantToDeleteThisAlert;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @areYouSureYouWantToCloseThisAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close this alert?'**
  String get areYouSureYouWantToCloseThisAlert;

  /// No description provided for @areYouSureYouWantToDeleteThisResponse.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this response?'**
  String get areYouSureYouWantToDeleteThisResponse;

  /// No description provided for @areYouSureYouWantToUpdateThisAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to update this alert?'**
  String get areYouSureYouWantToUpdateThisAlert;

  /// No description provided for @areYouSureYouWantToRespondToThisAlert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to respond to this alert?'**
  String get areYouSureYouWantToRespondToThisAlert;

  /// No description provided for @areYouSureYouWantToCancelThisResponse.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this response?'**
  String get areYouSureYouWantToCancelThisResponse;

  /// No description provided for @writeYourMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Write your message here'**
  String get writeYourMessageHere;

  /// No description provided for @responseSent.
  ///
  /// In en, this message translates to:
  /// **'Response sent'**
  String get responseSent;

  /// No description provided for @reportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get reportAnIssue;

  /// No description provided for @pleaseExplainInDetailWhyYouWantToReportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Please explain in detail why you want to report an issue and include any additional information to help us resolve the issue as quickly as possible.'**
  String get pleaseExplainInDetailWhyYouWantToReportAnIssue;

  /// No description provided for @writeYourIssue.
  ///
  /// In en, this message translates to:
  /// **'Write your issue'**
  String get writeYourIssue;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @reportSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully'**
  String get reportSubmittedSuccessfully;

  /// No description provided for @alertClosedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Alert closed successfully'**
  String get alertClosedSuccessfully;

  /// No description provided for @alertResponseCancelSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Alert response canceled successfully'**
  String get alertResponseCancelSuccessfully;

  /// No description provided for @alertDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Alert deleted successfully'**
  String get alertDeletedSuccessfully;

  /// No description provided for @alreadyRespondedByUserType.
  ///
  /// In en, this message translates to:
  /// **'Already responded by {user_type}'**
  String alreadyRespondedByUserType(Object user_type);

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @wantToGetDirectHelp.
  ///
  /// In en, this message translates to:
  /// **'Want to get direct help?'**
  String get wantToGetDirectHelp;

  /// No description provided for @callNowToTalk.
  ///
  /// In en, this message translates to:
  /// **'Call now <call>999</call> to talk'**
  String get callNowToTalk;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select app language'**
  String get selectAppLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @bangla.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get bangla;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @turnOnToGetNotifications.
  ///
  /// In en, this message translates to:
  /// **'Turn on to get notifications'**
  String get turnOnToGetNotifications;

  /// No description provided for @radius.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get radius;

  /// No description provided for @selectYourAreaRadius.
  ///
  /// In en, this message translates to:
  /// **'Select your area radius'**
  String get selectYourAreaRadius;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changeYourAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'Change your account password'**
  String get changeYourAccountPassword;

  /// No description provided for @updatePermissionAndService.
  ///
  /// In en, this message translates to:
  /// **'Update permission and service'**
  String get updatePermissionAndService;

  /// No description provided for @deleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Your Account'**
  String get deleteYourAccount;

  /// No description provided for @areYouSureYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get areYouSureYouWantToDeleteYourAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get warning;

  /// No description provided for @thisActionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This is permanent and cannot be undone'**
  String get thisActionCannotBeUndone;

  /// No description provided for @allYourDataWillBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'All your alerts, responses, fnf and profile data will be deleted. Once you deleted you will lost your access to Shojag.'**
  String get allYourDataWillBeDeleted;

  /// No description provided for @enterYourPasswordToProceed.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to proceed'**
  String get enterYourPasswordToProceed;

  /// No description provided for @locationSettings.
  ///
  /// In en, this message translates to:
  /// **'Location Settings'**
  String get locationSettings;

  /// No description provided for @backgroundLocation.
  ///
  /// In en, this message translates to:
  /// **'Background Location'**
  String get backgroundLocation;

  /// No description provided for @accessToYourLocationWhenTheAppIsInBackground.
  ///
  /// In en, this message translates to:
  /// **'Access to your location when the app is in the background'**
  String get accessToYourLocationWhenTheAppIsInBackground;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @turnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn On'**
  String get turnOn;

  /// No description provided for @turnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get turnOff;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get currentPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @deletePermanently.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get deletePermanently;

  /// No description provided for @fnfLocator.
  ///
  /// In en, this message translates to:
  /// **'FnF Locator'**
  String get fnfLocator;

  /// No description provided for @locateYourFnf.
  ///
  /// In en, this message translates to:
  /// **'Locate Your FnF'**
  String get locateYourFnf;

  /// No description provided for @sharingPermission.
  ///
  /// In en, this message translates to:
  /// **'Sharing Permission'**
  String get sharingPermission;

  /// No description provided for @addNewFnF.
  ///
  /// In en, this message translates to:
  /// **'Add New FnF'**
  String get addNewFnF;

  /// No description provided for @shareLocation.
  ///
  /// In en, this message translates to:
  /// **'Share Location'**
  String get shareLocation;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @changePermission.
  ///
  /// In en, this message translates to:
  /// **'Change Permission'**
  String get changePermission;

  /// No description provided for @enableBackgroundLocationToShareYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable background location to keep sharing your location even when the app is not active.'**
  String get enableBackgroundLocationToShareYourLocation;

  /// No description provided for @allowShojagToAccessYourBackgroundLocationToShare.
  ///
  /// In en, this message translates to:
  /// **'Allow shojag to access your background location to share with your FnF even app is not in use or closed'**
  String get allowShojagToAccessYourBackgroundLocationToShare;

  /// No description provided for @shojagCollectsBackgroundLocationToShareWithFnF.
  ///
  /// In en, this message translates to:
  /// **'Shojag collects your location data in the background to share with your FnF, even when the app is not in use or closed.'**
  String get shojagCollectsBackgroundLocationToShareWithFnF;

  /// No description provided for @toShareYourLocationEvenTheApp.
  ///
  /// In en, this message translates to:
  /// **'To share your location in even the app is not in use or closed, please enable \'Allow all the time\' permission.'**
  String get toShareYourLocationEvenTheApp;

  /// No description provided for @permissionLocationSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings > Permissions > Location > Allow all the time'**
  String get permissionLocationSettings;

  /// No description provided for @shareYourRealTimeLocationWithName.
  ///
  /// In en, this message translates to:
  /// **'Share your real-time location with {name}'**
  String shareYourRealTimeLocationWithName(Object name);

  /// No description provided for @forWithHour.
  ///
  /// In en, this message translates to:
  /// **'For {hour} hour'**
  String forWithHour(Object hour);

  /// No description provided for @untilITurnThisOff.
  ///
  /// In en, this message translates to:
  /// **'Until I turn this off'**
  String get untilITurnThisOff;

  /// No description provided for @untilWithTime.
  ///
  /// In en, this message translates to:
  /// **'Until {time}'**
  String untilWithTime(Object time);

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request'**
  String get cancelRequest;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @areYouSureYouWantToRemoveFromYourFnfList.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this from your FnF list?'**
  String get areYouSureYouWantToRemoveFromYourFnfList;

  /// No description provided for @areYouSureYouWantToCancelFnFRequest.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this FnF Request?'**
  String get areYouSureYouWantToCancelFnFRequest;

  /// No description provided for @areYouSureYouWantToAcceptThisRequest.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to accept this request?'**
  String get areYouSureYouWantToAcceptThisRequest;

  /// No description provided for @areYouSureYouWantToDeclineThisRequest.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to decline this request?'**
  String get areYouSureYouWantToDeclineThisRequest;

  /// No description provided for @sharingWithYou.
  ///
  /// In en, this message translates to:
  /// **'Sharing with you'**
  String get sharingWithYou;

  /// No description provided for @youAreSharing.
  ///
  /// In en, this message translates to:
  /// **'You are sharing'**
  String get youAreSharing;

  /// No description provided for @searchFnf.
  ///
  /// In en, this message translates to:
  /// **'Search FnF'**
  String get searchFnf;

  /// No description provided for @searchNumber.
  ///
  /// In en, this message translates to:
  /// **'Search Number'**
  String get searchNumber;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @noContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get noContactsFound;

  /// No description provided for @noUserFound.
  ///
  /// In en, this message translates to:
  /// **'No user found. Check the number and try again'**
  String get noUserFound;

  /// No description provided for @areYouSureYouWantToSendRequestToUserName.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to send request to {name}'**
  String areYouSureYouWantToSendRequestToUserName(Object name);

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get requestSent;

  /// No description provided for @addToFnfList.
  ///
  /// In en, this message translates to:
  /// **'Add to FnF'**
  String get addToFnfList;

  /// No description provided for @alreadyInFnfList.
  ///
  /// In en, this message translates to:
  /// **'Already in FnF'**
  String get alreadyInFnfList;

  /// No description provided for @enterPlaceName.
  ///
  /// In en, this message translates to:
  /// **'Enter place name'**
  String get enterPlaceName;

  /// No description provided for @tapOnMapToAddALocationAddSetALabel.
  ///
  /// In en, this message translates to:
  /// **'Tap on map to add a location and set a label'**
  String get tapOnMapToAddALocationAddSetALabel;

  /// No description provided for @requestSentWaitForAccept.
  ///
  /// In en, this message translates to:
  /// **'Request sent. Please wait until accept'**
  String get requestSentWaitForAccept;

  /// No description provided for @areYouSureYouWantToRemoveAddress.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this address?'**
  String get areYouSureYouWantToRemoveAddress;

  /// No description provided for @didNotSharedLocationWithYouUserName.
  ///
  /// In en, this message translates to:
  /// **'Did not shared location with you {name}'**
  String didNotSharedLocationWithYouUserName(Object name);

  /// No description provided for @addressDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address deleted successfully'**
  String get addressDeletedSuccessfully;

  /// No description provided for @addressAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address added successfully'**
  String get addressAddedSuccessfully;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @tapToSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap to send a message'**
  String get tapToSendMessage;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @noMessagesFound.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t send any messages yet'**
  String get noMessagesFound;

  /// No description provided for @messageFromUserName.
  ///
  /// In en, this message translates to:
  /// **'Message from {name}:'**
  String messageFromUserName(Object name);

  /// No description provided for @writeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get writeAMessage;

  /// No description provided for @dropAMessageForUserName.
  ///
  /// In en, this message translates to:
  /// **'Drop a message for {name}'**
  String dropAMessageForUserName(Object name);

  /// No description provided for @messageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully'**
  String get messageSentSuccessfully;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'UPGRADE'**
  String get upgrade;

  /// No description provided for @pro.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get pro;

  /// No description provided for @pleaseUpgradeToProToUnlockAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Please upgrade to PRO to unlock all features'**
  String get pleaseUpgradeToProToUnlockAllFeatures;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade To Pro'**
  String get upgradeToPro;

  /// No description provided for @upgradeToShojagPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade To Shojag Pro'**
  String get upgradeToShojagPro;

  /// No description provided for @addFnf.
  ///
  /// In en, this message translates to:
  /// **'Add FnF'**
  String get addFnf;

  /// No description provided for @youCanAddUnlimitedFnfWithPremiumUser.
  ///
  /// In en, this message translates to:
  /// **'You can add as many FnF as you want, but they also need to be Premium Users'**
  String get youCanAddUnlimitedFnfWithPremiumUser;

  /// No description provided for @locateYourFnfLiveLocation.
  ///
  /// In en, this message translates to:
  /// **'You can locate your FnF anywhere around the world and view their live location'**
  String get locateYourFnfLiveLocation;

  /// No description provided for @addCustomLocation.
  ///
  /// In en, this message translates to:
  /// **'Add FnF Custom Location'**
  String get addCustomLocation;

  /// No description provided for @newPlace.
  ///
  /// In en, this message translates to:
  /// **'New Place'**
  String get newPlace;

  /// No description provided for @locationWithUserName.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s location'**
  String locationWithUserName(Object name);

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @addLocationToolTipWithUsername.
  ///
  /// In en, this message translates to:
  /// **'Add location for <bold>{username}</bold> to get notified when they arrive at the location.\n\n1. Tap on map to add location.\n2. Set a label for it.'**
  String addLocationToolTipWithUsername(Object username);

  /// No description provided for @requestToShareLocation.
  ///
  /// In en, this message translates to:
  /// **'Request to share location'**
  String get requestToShareLocation;

  /// No description provided for @youCanAddUpToAddressWithCount.
  ///
  /// In en, this message translates to:
  /// **'You can set {count} custom Location for each FnF and once they arrive their location you will get a notification.'**
  String youCanAddUpToAddressWithCount(Object count);

  /// No description provided for @unlockProWithCurrencyAndAmount.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro {currency} {amount}'**
  String unlockProWithCurrencyAndAmount(Object currency, Object amount);

  /// No description provided for @unlockProWithCurrencyAndAmountAndDays.
  ///
  /// In en, this message translates to:
  /// **'Unlock PRO for {days} days {currency} {amount}'**
  String unlockProWithCurrencyAndAmountAndDays(
    Object currency,
    Object amount,
    Object days,
  );

  /// No description provided for @youAreNotAPremiumUser.
  ///
  /// In en, this message translates to:
  /// **'You are not a premium user. Upgrade now to unlock premium features'**
  String get youAreNotAPremiumUser;

  /// No description provided for @yourSubscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Your subscription status'**
  String get yourSubscriptionStatus;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @renewSubscription.
  ///
  /// In en, this message translates to:
  /// **'Renew Subscription'**
  String get renewSubscription;

  /// No description provided for @yourSubscriptionWillBeExpireOnWithDate.
  ///
  /// In en, this message translates to:
  /// **'Your subscription will be expire on {date}'**
  String yourSubscriptionWillBeExpireOnWithDate(Object date);

  /// No description provided for @expireOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String expireOn(Object date);

  /// No description provided for @remainingDays.
  ///
  /// In en, this message translates to:
  /// **'Remaining : {days} days'**
  String remainingDays(Object days);

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days} days left'**
  String daysLeft(Object days);

  /// No description provided for @upgradeToUnlockProFeatures.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to unlock PRO features'**
  String get upgradeToUnlockProFeatures;

  /// No description provided for @yourCurrentSubscription.
  ///
  /// In en, this message translates to:
  /// **'Your current subscription'**
  String get yourCurrentSubscription;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @yourSessionHasBeenExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has been expired!'**
  String get yourSessionHasBeenExpired;

  /// No description provided for @loginAgainToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login again to continue'**
  String get loginAgainToContinue;

  /// No description provided for @loginAgain.
  ///
  /// In en, this message translates to:
  /// **'Login Again'**
  String get loginAgain;

  /// No description provided for @ifYouFindThisAlertPostCommentMisleading.
  ///
  /// In en, this message translates to:
  /// **'If you find this alert/post/comments to be false, misleading, or inappropriate, please report it. Our team will review and take necessary actions.'**
  String get ifYouFindThisAlertPostCommentMisleading;

  /// No description provided for @agreeAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Agree and Continue'**
  String get agreeAndContinue;

  /// No description provided for @locationAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Location access required'**
  String get locationAccessRequired;

  /// No description provided for @shojagCollectsYourLocationDataTo.
  ///
  /// In en, this message translates to:
  /// **'Shojag collects your location data to:'**
  String get shojagCollectsYourLocationDataTo;

  /// No description provided for @shojagLocationDataUsageMessages.
  ///
  /// In en, this message translates to:
  /// **'<tab1/><icon/> Identify your current location.<br/><tab1/><icon/> Notify you about nearby alerts created by other users.<br/><tab1/><icon/> Notify your friends and family when you reach specific places.<br/><tab1/><icon/> Share your live location with selected contacts and your data will be securely stored and <bold>only</bold> shared with contacts you approve.<br/><br/><bold>This data is collected even when the app is closed or not in use</bold> to ensure accurate alerts and real-time updates.<br/><br/><red>⚠ <bold>Without this permission, Shojag cannot provide its core features.</bold></red>'**
  String get shojagLocationDataUsageMessages;

  /// No description provided for @currentSubscription.
  ///
  /// In en, this message translates to:
  /// **'Current Subscription'**
  String get currentSubscription;

  /// No description provided for @tryPremiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Try Premium Features'**
  String get tryPremiumFeatures;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @tourAgain.
  ///
  /// In en, this message translates to:
  /// **'Tour Again'**
  String get tourAgain;

  /// No description provided for @phoneNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberIsRequired;

  /// No description provided for @phoneShouldBeElevenDigits.
  ///
  /// In en, this message translates to:
  /// **'Phone number should be 11 digits'**
  String get phoneShouldBeElevenDigits;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @emailShouldBeValid.
  ///
  /// In en, this message translates to:
  /// **'Email should be valid'**
  String get emailShouldBeValid;

  /// No description provided for @firstNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameIsRequired;

  /// No description provided for @lastNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameIsRequired;

  /// No description provided for @genderIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get genderIsRequired;

  /// No description provided for @policeIdIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Police ID is required'**
  String get policeIdIsRequired;

  /// No description provided for @thanaIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Thana is required'**
  String get thanaIsRequired;

  /// No description provided for @fireStationIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Fire station is required'**
  String get fireStationIsRequired;

  /// No description provided for @hospitalOrAgencyIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Hospital or Agency is required'**
  String get hospitalOrAgencyIsRequired;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordShouldBeAtLeastCharacters.
  ///
  /// In en, this message translates to:
  /// **'Password should be at least {count} characters'**
  String passwordShouldBeAtLeastCharacters(int count);

  /// No description provided for @repeatPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Repeat password is required'**
  String get repeatPasswordIsRequired;

  /// No description provided for @passwordDidNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Repeat password didn\'t match'**
  String get passwordDidNotMatch;

  /// No description provided for @canNotBeNullOrEmptyByField.
  ///
  /// In en, this message translates to:
  /// **'{name} can\'t be empty'**
  String canNotBeNullOrEmptyByField(Object name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
