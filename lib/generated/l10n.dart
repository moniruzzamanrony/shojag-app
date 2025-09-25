// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Shojag`
  String get app_title {
    return Intl.message('Shojag', name: 'app_title', desc: '', args: []);
  }

  /// `Citizen`
  String get citizen {
    return Intl.message('Citizen', name: 'citizen', desc: '', args: []);
  }

  /// `Community`
  String get community {
    return Intl.message('Community', name: 'community', desc: '', args: []);
  }

  /// `Police`
  String get police {
    return Intl.message('Police', name: 'police', desc: '', args: []);
  }

  /// `Ambulance`
  String get ambulance {
    return Intl.message('Ambulance', name: 'ambulance', desc: '', args: []);
  }

  /// `Fire Service`
  String get fire_service {
    return Intl.message(
      'Fire Service',
      name: 'fire_service',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Get Started`
  String get get_started {
    return Intl.message('Get Started', name: 'get_started', desc: '', args: []);
  }

  /// `Your life line in emergencies, just a tap away`
  String get yourLifeLIneInEmergencies {
    return Intl.message(
      'Your life line in emergencies, just a tap away',
      name: 'yourLifeLIneInEmergencies',
      desc: '',
      args: [],
    );
  }

  /// `Together We Connect, Together We Protect`
  String get togetherWeConnectTogetherWeProtect {
    return Intl.message(
      'Together We Connect, Together We Protect',
      name: 'togetherWeConnectTogetherWeProtect',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Not a member?`
  String get notAMember {
    return Intl.message(
      'Not a member?',
      name: 'notAMember',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get joinNow {
    return Intl.message('Join Now', name: 'joinNow', desc: '', args: []);
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Select how you want to join with`
  String get selectHowYouWantToJoinWith {
    return Intl.message(
      'Select how you want to join with',
      name: 'selectHowYouWantToJoinWith',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Police ID`
  String get policeId {
    return Intl.message('Police ID', name: 'policeId', desc: '', args: []);
  }

  /// `Organization`
  String get organization {
    return Intl.message(
      'Organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `DOB`
  String get dob {
    return Intl.message('DOB', name: 'dob', desc: '', args: []);
  }

  /// `NID`
  String get nid {
    return Intl.message('NID', name: 'nid', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Thana`
  String get thana {
    return Intl.message('Thana', name: 'thana', desc: '', args: []);
  }

  /// `Select Thana`
  String get selectThana {
    return Intl.message(
      'Select Thana',
      name: 'selectThana',
      desc: '',
      args: [],
    );
  }

  /// `Fire Station`
  String get fireStation {
    return Intl.message(
      'Fire Station',
      name: 'fireStation',
      desc: '',
      args: [],
    );
  }

  /// `Hospital/Agency`
  String get hospitalAgency {
    return Intl.message(
      'Hospital/Agency',
      name: 'hospitalAgency',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message('District', name: 'district', desc: '', args: []);
  }

  /// `Select District`
  String get selectDistrict {
    return Intl.message(
      'Select District',
      name: 'selectDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get repeatPassword {
    return Intl.message(
      'Repeat Password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the`
  String get iAgreeToThe {
    return Intl.message(
      'I agree to the',
      name: 'iAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Already a member?`
  String get alreadyAMember {
    return Intl.message(
      'Already a member?',
      name: 'alreadyAMember',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP sent to the number`
  String get enterTheOtpSentToTheNumber {
    return Intl.message(
      'Enter the OTP sent to the number',
      name: 'enterTheOtpSentToTheNumber',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOtp {
    return Intl.message('Resend OTP', name: 'resendOtp', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset your account password and access your personal account again`
  String get resetYourAccountPasswordAndAccess {
    return Intl.message(
      'Reset your account password and access your personal account again',
      name: 'resetYourAccountPasswordAndAccess',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Please enter 4 digit OTP Code, we sent to`
  String get pleaseEnter4DigitOtp {
    return Intl.message(
      'Please enter 4 digit OTP Code, we sent to',
      name: 'pleaseEnter4DigitOtp',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Didn't received code?`
  String get didNotReceivedCode {
    return Intl.message(
      'Didn\'t received code?',
      name: 'didNotReceivedCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password to access your account`
  String get setANewPassword {
    return Intl.message(
      'Set a new password to access your account',
      name: 'setANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Alert`
  String get alert {
    return Intl.message('Alert', name: 'alert', desc: '', args: []);
  }

  /// `Alerts`
  String get alerts {
    return Intl.message('Alerts', name: 'alerts', desc: '', args: []);
  }

  /// `FnF`
  String get fnf {
    return Intl.message('FnF', name: 'fnf', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Emergency Service`
  String get emergencyService {
    return Intl.message(
      'Emergency Service',
      name: 'emergencyService',
      desc: '',
      args: [],
    );
  }

  /// `New Alert`
  String get newAlert {
    return Intl.message('New Alert', name: 'newAlert', desc: '', args: []);
  }

  /// `Alert List`
  String get alertList {
    return Intl.message('Alert List', name: 'alertList', desc: '', args: []);
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message('Invite', name: 'invite', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `My Alerts`
  String get myAlerts {
    return Intl.message('My Alerts', name: 'myAlerts', desc: '', args: []);
  }

  /// `Responded Alerts`
  String get respondedAlerts {
    return Intl.message(
      'Responded Alerts',
      name: 'respondedAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Closed Alerts`
  String get closedAlerts {
    return Intl.message(
      'Closed Alerts',
      name: 'closedAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Active Alerts`
  String get activeAlerts {
    return Intl.message(
      'Active Alerts',
      name: 'activeAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message('Map', name: 'map', desc: '', args: []);
  }

  /// `Emergency`
  String get emergency {
    return Intl.message('Emergency', name: 'emergency', desc: '', args: []);
  }

  /// `999`
  String get tripleNine {
    return Intl.message('999', name: 'tripleNine', desc: '', args: []);
  }

  /// `Please provide your valuable feedback about the app. It will help us improve our service.`
  String get pleaseProvideYourValuableFeedback {
    return Intl.message(
      'Please provide your valuable feedback about the app. It will help us improve our service.',
      name: 'pleaseProvideYourValuableFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Write your feedback here...`
  String get writeYourFeedbackHere {
    return Intl.message(
      'Write your feedback here...',
      name: 'writeYourFeedbackHere',
      desc: '',
      args: [],
    );
  }

  /// `Feedback submitted successfully`
  String get feedbackSubmittedSuccessfully {
    return Intl.message(
      'Feedback submitted successfully',
      name: 'feedbackSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Create Alert`
  String get createAlert {
    return Intl.message(
      'Create Alert',
      name: 'createAlert',
      desc: '',
      args: [],
    );
  }

  /// `Latest Alerts`
  String get latestAlerts {
    return Intl.message(
      'Latest Alerts',
      name: 'latestAlerts',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Responded`
  String get responded {
    return Intl.message('Responded', name: 'responded', desc: '', args: []);
  }

  /// `Your Active Alerts`
  String get yourActiveAlerts {
    return Intl.message(
      'Your Active Alerts',
      name: 'yourActiveAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Alert Map`
  String get alertMap {
    return Intl.message('Alert Map', name: 'alertMap', desc: '', args: []);
  }

  /// `Loading`
  String get loading {
    return Intl.message('Loading', name: 'loading', desc: '', args: []);
  }

  /// `No alert found`
  String get noAlertFound {
    return Intl.message(
      'No alert found',
      name: 'noAlertFound',
      desc: '',
      args: [],
    );
  }

  /// `New {type} Alert`
  String createTypeNewAlert(Object type) {
    return Intl.message(
      'New $type Alert',
      name: 'createTypeNewAlert',
      desc: '',
      args: [type],
    );
  }

  /// `Select incident type`
  String get selectIncidentType {
    return Intl.message(
      'Select incident type',
      name: 'selectIncidentType',
      desc: '',
      args: [],
    );
  }

  /// `Describe your incident`
  String get describeYourIncident {
    return Intl.message(
      'Describe your incident',
      name: 'describeYourIncident',
      desc: '',
      args: [],
    );
  }

  /// `Select alert location`
  String get selectAlertLocation {
    return Intl.message(
      'Select alert location',
      name: 'selectAlertLocation',
      desc: '',
      args: [],
    );
  }

  /// `eg. Flat No. Road No.`
  String get egFlatNoRoadNo {
    return Intl.message(
      'eg. Flat No. Road No.',
      name: 'egFlatNoRoadNo',
      desc: '',
      args: [],
    );
  }

  /// `Capture or upload image`
  String get captureOrUploadImage {
    return Intl.message(
      'Capture or upload image',
      name: 'captureOrUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Select an option`
  String get selectAnOption {
    return Intl.message(
      'Select an option',
      name: 'selectAnOption',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Also share this alert with`
  String get alsoShareThisAlertWith {
    return Intl.message(
      'Also share this alert with',
      name: 'alsoShareThisAlertWith',
      desc: '',
      args: [],
    );
  }

  /// `* Required`
  String get starRequired {
    return Intl.message('* Required', name: 'starRequired', desc: '', args: []);
  }

  /// `Please select an incident type`
  String get pleaseSelectAnIncidentType {
    return Intl.message(
      'Please select an incident type',
      name: 'pleaseSelectAnIncidentType',
      desc: '',
      args: [],
    );
  }

  /// `Write short description about the incident`
  String get writeShortDescriptionAboutTheIncident {
    return Intl.message(
      'Write short description about the incident',
      name: 'writeShortDescriptionAboutTheIncident',
      desc: '',
      args: [],
    );
  }

  /// `Select a location`
  String get selectALocation {
    return Intl.message(
      'Select a location',
      name: 'selectALocation',
      desc: '',
      args: [],
    );
  }

  /// `Post Alert`
  String get postAlert {
    return Intl.message('Post Alert', name: 'postAlert', desc: '', args: []);
  }

  /// `Success!`
  String get successWithQuotes {
    return Intl.message(
      'Success!',
      name: 'successWithQuotes',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulationsWithQuotes {
    return Intl.message(
      'Congratulations!',
      name: 'congratulationsWithQuotes',
      desc: '',
      args: [],
    );
  }

  /// `Your alert has been created successfully`
  String get yourAlertHasBeenCreatedSuccessfully {
    return Intl.message(
      'Your alert has been created successfully',
      name: 'yourAlertHasBeenCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `I'm Sure`
  String get iAmSure {
    return Intl.message('I\'m Sure', name: 'iAmSure', desc: '', args: []);
  }

  /// `Are you sure you want to create this alert? Fake alerts may lead to lagal action and account suspension.`
  String get iAmSureAboutTheAlert {
    return Intl.message(
      'Are you sure you want to create this alert? Fake alerts may lead to lagal action and account suspension.',
      name: 'iAmSureAboutTheAlert',
      desc: '',
      args: [],
    );
  }

  /// `Due to the limited number of communities currently using this app, community support may be delayed. We are growing, and we hope this trend will continue to improve over time.`
  String get communityAlertCreateInfoNotice {
    return Intl.message(
      'Due to the limited number of communities currently using this app, community support may be delayed. We are growing, and we hope this trend will continue to improve over time.',
      name: 'communityAlertCreateInfoNotice',
      desc: '',
      args: [],
    );
  }

  /// `Alert Update`
  String get alertUpdate {
    return Intl.message(
      'Alert Update',
      name: 'alertUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Address (Optional)`
  String get addressOptional {
    return Intl.message(
      'Address (Optional)',
      name: 'addressOptional',
      desc: '',
      args: [],
    );
  }

  /// `Your alert has been updated successfully`
  String get yourAlertHasBeenUpdatedSuccessfully {
    return Intl.message(
      'Your alert has been updated successfully',
      name: 'yourAlertHasBeenUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No {type} alerts found or check your internet connection`
  String noAlertsFoundTypeOrCheckInternet(Object type) {
    return Intl.message(
      'No $type alerts found or check your internet connection',
      name: 'noAlertsFoundTypeOrCheckInternet',
      desc: '',
      args: [type],
    );
  }

  /// `By {name}`
  String byWithName(Object name) {
    return Intl.message('By $name', name: 'byWithName', desc: '', args: [name]);
  }

  /// `{distance} {unit, select, km{K.M} meter{Meter} other{n/a}}`
  String toKMConverter(String unit, num distance) {
    final NumberFormat distanceNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String distanceString = distanceNumberFormat.format(distance);

    return Intl.message(
      '$distanceString ${Intl.select(unit, {'km': 'K.M', 'meter': 'Meter', 'other': 'n/a'})}',
      name: 'toKMConverter',
      desc: '',
      args: [unit, distanceString],
    );
  }

  /// `Alert Details`
  String get alertDetails {
    return Intl.message(
      'Alert Details',
      name: 'alertDetails',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Type of Incident`
  String get typeOfIncident {
    return Intl.message(
      'Type of Incident',
      name: 'typeOfIncident',
      desc: '',
      args: [],
    );
  }

  /// `Short Description`
  String get shortDescription {
    return Intl.message(
      'Short Description',
      name: 'shortDescription',
      desc: '',
      args: [],
    );
  }

  /// `Alert Description`
  String get alertDescription {
    return Intl.message(
      'Alert Description',
      name: 'alertDescription',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `View Image`
  String get viewImage {
    return Intl.message('View Image', name: 'viewImage', desc: '', args: []);
  }

  /// `View Map`
  String get viewMap {
    return Intl.message('View Map', name: 'viewMap', desc: '', args: []);
  }

  /// `View On Map`
  String get viewOnMap {
    return Intl.message('View On Map', name: 'viewOnMap', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Response`
  String get response {
    return Intl.message('Response', name: 'response', desc: '', args: []);
  }

  /// `Responses`
  String get responses {
    return Intl.message('Responses', name: 'responses', desc: '', args: []);
  }

  /// `No responses yet`
  String get noResponsesYet {
    return Intl.message(
      'No responses yet',
      name: 'noResponsesYet',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this alert?`
  String get areYouSureYouWantToDeleteThisAlert {
    return Intl.message(
      'Are you sure you want to delete this alert?',
      name: 'areYouSureYouWantToDeleteThisAlert',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `Are you sure you want to close this alert?`
  String get areYouSureYouWantToCloseThisAlert {
    return Intl.message(
      'Are you sure you want to close this alert?',
      name: 'areYouSureYouWantToCloseThisAlert',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this response?`
  String get areYouSureYouWantToDeleteThisResponse {
    return Intl.message(
      'Are you sure you want to delete this response?',
      name: 'areYouSureYouWantToDeleteThisResponse',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to update this alert?`
  String get areYouSureYouWantToUpdateThisAlert {
    return Intl.message(
      'Are you sure you want to update this alert?',
      name: 'areYouSureYouWantToUpdateThisAlert',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to respond to this alert?`
  String get areYouSureYouWantToRespondToThisAlert {
    return Intl.message(
      'Are you sure you want to respond to this alert?',
      name: 'areYouSureYouWantToRespondToThisAlert',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this response?`
  String get areYouSureYouWantToCancelThisResponse {
    return Intl.message(
      'Are you sure you want to cancel this response?',
      name: 'areYouSureYouWantToCancelThisResponse',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here`
  String get writeYourMessageHere {
    return Intl.message(
      'Write your message here',
      name: 'writeYourMessageHere',
      desc: '',
      args: [],
    );
  }

  /// `Response sent`
  String get responseSent {
    return Intl.message(
      'Response sent',
      name: 'responseSent',
      desc: '',
      args: [],
    );
  }

  /// `Report an issue`
  String get reportAnIssue {
    return Intl.message(
      'Report an issue',
      name: 'reportAnIssue',
      desc: '',
      args: [],
    );
  }

  /// `Please explain in detail why you want to report an issue and include any additional information to help us resolve the issue as quickly as possible.`
  String get pleaseExplainInDetailWhyYouWantToReportAnIssue {
    return Intl.message(
      'Please explain in detail why you want to report an issue and include any additional information to help us resolve the issue as quickly as possible.',
      name: 'pleaseExplainInDetailWhyYouWantToReportAnIssue',
      desc: '',
      args: [],
    );
  }

  /// `Write your issue`
  String get writeYourIssue {
    return Intl.message(
      'Write your issue',
      name: 'writeYourIssue',
      desc: '',
      args: [],
    );
  }

  /// `Submit Report`
  String get submitReport {
    return Intl.message(
      'Submit Report',
      name: 'submitReport',
      desc: '',
      args: [],
    );
  }

  /// `Report submitted successfully`
  String get reportSubmittedSuccessfully {
    return Intl.message(
      'Report submitted successfully',
      name: 'reportSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Alert closed successfully`
  String get alertClosedSuccessfully {
    return Intl.message(
      'Alert closed successfully',
      name: 'alertClosedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Alert response canceled successfully`
  String get alertResponseCancelSuccessfully {
    return Intl.message(
      'Alert response canceled successfully',
      name: 'alertResponseCancelSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Alert deleted successfully`
  String get alertDeletedSuccessfully {
    return Intl.message(
      'Alert deleted successfully',
      name: 'alertDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Already responded by {user_type}`
  String alreadyRespondedByUserType(Object user_type) {
    return Intl.message(
      'Already responded by $user_type',
      name: 'alreadyRespondedByUserType',
      desc: '',
      args: [user_type],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Want to get direct help?`
  String get wantToGetDirectHelp {
    return Intl.message(
      'Want to get direct help?',
      name: 'wantToGetDirectHelp',
      desc: '',
      args: [],
    );
  }

  /// `Call now <call>999</call> to talk`
  String get callNowToTalk {
    return Intl.message(
      'Call now <call>999</call> to talk',
      name: 'callNowToTalk',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Select app language`
  String get selectAppLanguage {
    return Intl.message(
      'Select app language',
      name: 'selectAppLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Bangla`
  String get bangla {
    return Intl.message('Bangla', name: 'bangla', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Turn on to get notifications`
  String get turnOnToGetNotifications {
    return Intl.message(
      'Turn on to get notifications',
      name: 'turnOnToGetNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Radius`
  String get radius {
    return Intl.message('Radius', name: 'radius', desc: '', args: []);
  }

  /// `Select your area radius`
  String get selectYourAreaRadius {
    return Intl.message(
      'Select your area radius',
      name: 'selectYourAreaRadius',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change your account password`
  String get changeYourAccountPassword {
    return Intl.message(
      'Change your account password',
      name: 'changeYourAccountPassword',
      desc: '',
      args: [],
    );
  }

  /// `Update permission and service`
  String get updatePermissionAndService {
    return Intl.message(
      'Update permission and service',
      name: 'updatePermissionAndService',
      desc: '',
      args: [],
    );
  }

  /// `Delete Your Account`
  String get deleteYourAccount {
    return Intl.message(
      'Delete Your Account',
      name: 'deleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get areYouSureYouWantToDeleteYourAccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'areYouSureYouWantToDeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get warning {
    return Intl.message('Warning!', name: 'warning', desc: '', args: []);
  }

  /// `This is permanent and cannot be undone`
  String get thisActionCannotBeUndone {
    return Intl.message(
      'This is permanent and cannot be undone',
      name: 'thisActionCannotBeUndone',
      desc: '',
      args: [],
    );
  }

  /// `All your alerts, responses, fnf and profile data will be deleted. Once you deleted you will lost your access to Shojag.`
  String get allYourDataWillBeDeleted {
    return Intl.message(
      'All your alerts, responses, fnf and profile data will be deleted. Once you deleted you will lost your access to Shojag.',
      name: 'allYourDataWillBeDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to proceed`
  String get enterYourPasswordToProceed {
    return Intl.message(
      'Enter your password to proceed',
      name: 'enterYourPasswordToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Location Settings`
  String get locationSettings {
    return Intl.message(
      'Location Settings',
      name: 'locationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Background Location`
  String get backgroundLocation {
    return Intl.message(
      'Background Location',
      name: 'backgroundLocation',
      desc: '',
      args: [],
    );
  }

  /// `Access to your location when the app is in the background`
  String get accessToYourLocationWhenTheAppIsInBackground {
    return Intl.message(
      'Access to your location when the app is in the background',
      name: 'accessToYourLocationWhenTheAppIsInBackground',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message('On', name: 'on', desc: '', args: []);
  }

  /// `Off`
  String get off {
    return Intl.message('Off', name: 'off', desc: '', args: []);
  }

  /// `Turn On`
  String get turnOn {
    return Intl.message('Turn On', name: 'turnOn', desc: '', args: []);
  }

  /// `Turn off`
  String get turnOff {
    return Intl.message('Turn off', name: 'turnOff', desc: '', args: []);
  }

  /// `Old Password`
  String get currentPassword {
    return Intl.message(
      'Old Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete Permanently`
  String get deletePermanently {
    return Intl.message(
      'Delete Permanently',
      name: 'deletePermanently',
      desc: '',
      args: [],
    );
  }

  /// `FnF Locator`
  String get fnfLocator {
    return Intl.message('FnF Locator', name: 'fnfLocator', desc: '', args: []);
  }

  /// `Locate Your FnF`
  String get locateYourFnf {
    return Intl.message(
      'Locate Your FnF',
      name: 'locateYourFnf',
      desc: '',
      args: [],
    );
  }

  /// `Sharing Permission`
  String get sharingPermission {
    return Intl.message(
      'Sharing Permission',
      name: 'sharingPermission',
      desc: '',
      args: [],
    );
  }

  /// `Add New FnF`
  String get addNewFnF {
    return Intl.message('Add New FnF', name: 'addNewFnF', desc: '', args: []);
  }

  /// `Share Location`
  String get shareLocation {
    return Intl.message(
      'Share Location',
      name: 'shareLocation',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Change Permission`
  String get changePermission {
    return Intl.message(
      'Change Permission',
      name: 'changePermission',
      desc: '',
      args: [],
    );
  }

  /// `Enable background location to keep sharing your location even when the app is not active.`
  String get enableBackgroundLocationToShareYourLocation {
    return Intl.message(
      'Enable background location to keep sharing your location even when the app is not active.',
      name: 'enableBackgroundLocationToShareYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Allow shojag to access your background location to share with your FnF even app is not in use or closed`
  String get allowShojagToAccessYourBackgroundLocationToShare {
    return Intl.message(
      'Allow shojag to access your background location to share with your FnF even app is not in use or closed',
      name: 'allowShojagToAccessYourBackgroundLocationToShare',
      desc: '',
      args: [],
    );
  }

  /// `Shojag collects your location data in the background to share with your FnF, even when the app is not in use or closed.`
  String get shojagCollectsBackgroundLocationToShareWithFnF {
    return Intl.message(
      'Shojag collects your location data in the background to share with your FnF, even when the app is not in use or closed.',
      name: 'shojagCollectsBackgroundLocationToShareWithFnF',
      desc: '',
      args: [],
    );
  }

  /// `To share your location in even the app is not in use or closed, please enable 'Allow all the time' permission.`
  String get toShareYourLocationEvenTheApp {
    return Intl.message(
      'To share your location in even the app is not in use or closed, please enable \'Allow all the time\' permission.',
      name: 'toShareYourLocationEvenTheApp',
      desc: '',
      args: [],
    );
  }

  /// `App Settings > Permissions > Location > Allow all the time`
  String get permissionLocationSettings {
    return Intl.message(
      'App Settings > Permissions > Location > Allow all the time',
      name: 'permissionLocationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Share your real-time location with {name}`
  String shareYourRealTimeLocationWithName(Object name) {
    return Intl.message(
      'Share your real-time location with $name',
      name: 'shareYourRealTimeLocationWithName',
      desc: '',
      args: [name],
    );
  }

  /// `For {hour} hour`
  String forWithHour(Object hour) {
    return Intl.message(
      'For $hour hour',
      name: 'forWithHour',
      desc: '',
      args: [hour],
    );
  }

  /// `Until I turn this off`
  String get untilITurnThisOff {
    return Intl.message(
      'Until I turn this off',
      name: 'untilITurnThisOff',
      desc: '',
      args: [],
    );
  }

  /// `Until {time}`
  String untilWithTime(Object time) {
    return Intl.message(
      'Until $time',
      name: 'untilWithTime',
      desc: '',
      args: [time],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Cancel Request`
  String get cancelRequest {
    return Intl.message(
      'Cancel Request',
      name: 'cancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Decline`
  String get decline {
    return Intl.message('Decline', name: 'decline', desc: '', args: []);
  }

  /// `Are you sure you want to remove this from your FnF list?`
  String get areYouSureYouWantToRemoveFromYourFnfList {
    return Intl.message(
      'Are you sure you want to remove this from your FnF list?',
      name: 'areYouSureYouWantToRemoveFromYourFnfList',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this FnF Request?`
  String get areYouSureYouWantToCancelFnFRequest {
    return Intl.message(
      'Are you sure you want to cancel this FnF Request?',
      name: 'areYouSureYouWantToCancelFnFRequest',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to accept this request?`
  String get areYouSureYouWantToAcceptThisRequest {
    return Intl.message(
      'Are you sure you want to accept this request?',
      name: 'areYouSureYouWantToAcceptThisRequest',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to decline this request?`
  String get areYouSureYouWantToDeclineThisRequest {
    return Intl.message(
      'Are you sure you want to decline this request?',
      name: 'areYouSureYouWantToDeclineThisRequest',
      desc: '',
      args: [],
    );
  }

  /// `Sharing with you`
  String get sharingWithYou {
    return Intl.message(
      'Sharing with you',
      name: 'sharingWithYou',
      desc: '',
      args: [],
    );
  }

  /// `You are sharing`
  String get youAreSharing {
    return Intl.message(
      'You are sharing',
      name: 'youAreSharing',
      desc: '',
      args: [],
    );
  }

  /// `Search FnF`
  String get searchFnf {
    return Intl.message('Search FnF', name: 'searchFnf', desc: '', args: []);
  }

  /// `Search Number`
  String get searchNumber {
    return Intl.message(
      'Search Number',
      name: 'searchNumber',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message('Contacts', name: 'contacts', desc: '', args: []);
  }

  /// `Search Results`
  String get searchResults {
    return Intl.message(
      'Search Results',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `No contacts found`
  String get noContactsFound {
    return Intl.message(
      'No contacts found',
      name: 'noContactsFound',
      desc: '',
      args: [],
    );
  }

  /// `No user found. Check the number and try again`
  String get noUserFound {
    return Intl.message(
      'No user found. Check the number and try again',
      name: 'noUserFound',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to send request to {name}`
  String areYouSureYouWantToSendRequestToUserName(Object name) {
    return Intl.message(
      'Are you sure you want to send request to $name',
      name: 'areYouSureYouWantToSendRequestToUserName',
      desc: '',
      args: [name],
    );
  }

  /// `Request sent`
  String get requestSent {
    return Intl.message(
      'Request sent',
      name: 'requestSent',
      desc: '',
      args: [],
    );
  }

  /// `Add to FnF`
  String get addToFnfList {
    return Intl.message('Add to FnF', name: 'addToFnfList', desc: '', args: []);
  }

  /// `Already in FnF`
  String get alreadyInFnfList {
    return Intl.message(
      'Already in FnF',
      name: 'alreadyInFnfList',
      desc: '',
      args: [],
    );
  }

  /// `Enter place name`
  String get enterPlaceName {
    return Intl.message(
      'Enter place name',
      name: 'enterPlaceName',
      desc: '',
      args: [],
    );
  }

  /// `Tap on map to add a location and set a label`
  String get tapOnMapToAddALocationAddSetALabel {
    return Intl.message(
      'Tap on map to add a location and set a label',
      name: 'tapOnMapToAddALocationAddSetALabel',
      desc: '',
      args: [],
    );
  }

  /// `Request sent. Please wait until accept`
  String get requestSentWaitForAccept {
    return Intl.message(
      'Request sent. Please wait until accept',
      name: 'requestSentWaitForAccept',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this address?`
  String get areYouSureYouWantToRemoveAddress {
    return Intl.message(
      'Are you sure you want to remove this address?',
      name: 'areYouSureYouWantToRemoveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Did not shared location with you {name}`
  String didNotSharedLocationWithYouUserName(Object name) {
    return Intl.message(
      'Did not shared location with you $name',
      name: 'didNotSharedLocationWithYouUserName',
      desc: '',
      args: [name],
    );
  }

  /// `Address deleted successfully`
  String get addressDeletedSuccessfully {
    return Intl.message(
      'Address deleted successfully',
      name: 'addressDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Address added successfully`
  String get addressAddedSuccessfully {
    return Intl.message(
      'Address added successfully',
      name: 'addressAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message('You', name: 'you', desc: '', args: []);
  }

  /// `Tap to send a message`
  String get tapToSendMessage {
    return Intl.message(
      'Tap to send a message',
      name: 'tapToSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Didn't send any messages yet`
  String get noMessagesFound {
    return Intl.message(
      'Didn\'t send any messages yet',
      name: 'noMessagesFound',
      desc: '',
      args: [],
    );
  }

  /// `Message from {name}:`
  String messageFromUserName(Object name) {
    return Intl.message(
      'Message from $name:',
      name: 'messageFromUserName',
      desc: '',
      args: [name],
    );
  }

  /// `Write a message`
  String get writeAMessage {
    return Intl.message(
      'Write a message',
      name: 'writeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Drop a message for {name}`
  String dropAMessageForUserName(Object name) {
    return Intl.message(
      'Drop a message for $name',
      name: 'dropAMessageForUserName',
      desc: '',
      args: [name],
    );
  }

  /// `Message sent successfully`
  String get messageSentSuccessfully {
    return Intl.message(
      'Message sent successfully',
      name: 'messageSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `UPGRADE`
  String get upgrade {
    return Intl.message('UPGRADE', name: 'upgrade', desc: '', args: []);
  }

  /// `PRO`
  String get pro {
    return Intl.message('PRO', name: 'pro', desc: '', args: []);
  }

  /// `Please upgrade to PRO to unlock all features`
  String get pleaseUpgradeToProToUnlockAllFeatures {
    return Intl.message(
      'Please upgrade to PRO to unlock all features',
      name: 'pleaseUpgradeToProToUnlockAllFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Now`
  String get upgradeNow {
    return Intl.message('Upgrade Now', name: 'upgradeNow', desc: '', args: []);
  }

  /// `Upgrade To Pro`
  String get upgradeToPro {
    return Intl.message(
      'Upgrade To Pro',
      name: 'upgradeToPro',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade To Shojag Pro`
  String get upgradeToShojagPro {
    return Intl.message(
      'Upgrade To Shojag Pro',
      name: 'upgradeToShojagPro',
      desc: '',
      args: [],
    );
  }

  /// `Add FnF`
  String get addFnf {
    return Intl.message('Add FnF', name: 'addFnf', desc: '', args: []);
  }

  /// `You can add as many FnF as you want, but they also need to be Premium Users`
  String get youCanAddUnlimitedFnfWithPremiumUser {
    return Intl.message(
      'You can add as many FnF as you want, but they also need to be Premium Users',
      name: 'youCanAddUnlimitedFnfWithPremiumUser',
      desc: '',
      args: [],
    );
  }

  /// `You can locate your FnF anywhere around the world and view their live location`
  String get locateYourFnfLiveLocation {
    return Intl.message(
      'You can locate your FnF anywhere around the world and view their live location',
      name: 'locateYourFnfLiveLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add FnF Custom Location`
  String get addCustomLocation {
    return Intl.message(
      'Add FnF Custom Location',
      name: 'addCustomLocation',
      desc: '',
      args: [],
    );
  }

  /// `New Place`
  String get newPlace {
    return Intl.message('New Place', name: 'newPlace', desc: '', args: []);
  }

  /// `{name}'s location`
  String locationWithUserName(Object name) {
    return Intl.message(
      '$name\'s location',
      name: 'locationWithUserName',
      desc: '',
      args: [name],
    );
  }

  /// `Name is required`
  String get nameIsRequired {
    return Intl.message(
      'Name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Add location for <bold>{username}</bold> to get notified when they arrive at the location.\n\n1. Tap on map to add location.\n2. Set a label for it.`
  String addLocationToolTipWithUsername(Object username) {
    return Intl.message(
      'Add location for <bold>$username</bold> to get notified when they arrive at the location.\n\n1. Tap on map to add location.\n2. Set a label for it.',
      name: 'addLocationToolTipWithUsername',
      desc: '',
      args: [username],
    );
  }

  /// `Request to share location`
  String get requestToShareLocation {
    return Intl.message(
      'Request to share location',
      name: 'requestToShareLocation',
      desc: '',
      args: [],
    );
  }

  /// `You can set {count} custom Location for each FnF and once they arrive their location you will get a notification.`
  String youCanAddUpToAddressWithCount(Object count) {
    return Intl.message(
      'You can set $count custom Location for each FnF and once they arrive their location you will get a notification.',
      name: 'youCanAddUpToAddressWithCount',
      desc: '',
      args: [count],
    );
  }

  /// `Unlock Pro {currency} {amount}`
  String unlockProWithCurrencyAndAmount(Object currency, Object amount) {
    return Intl.message(
      'Unlock Pro $currency $amount',
      name: 'unlockProWithCurrencyAndAmount',
      desc: '',
      args: [currency, amount],
    );
  }

  /// `Unlock PRO for {days} days {currency} {amount}`
  String unlockProWithCurrencyAndAmountAndDays(
    Object currency,
    Object amount,
    Object days,
  ) {
    return Intl.message(
      'Unlock PRO for $days days $currency $amount',
      name: 'unlockProWithCurrencyAndAmountAndDays',
      desc: '',
      args: [currency, amount, days],
    );
  }

  /// `You are not a premium user. Upgrade now to unlock premium features`
  String get youAreNotAPremiumUser {
    return Intl.message(
      'You are not a premium user. Upgrade now to unlock premium features',
      name: 'youAreNotAPremiumUser',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription status`
  String get yourSubscriptionStatus {
    return Intl.message(
      'Your subscription status',
      name: 'yourSubscriptionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Premium Features`
  String get premiumFeatures {
    return Intl.message(
      'Premium Features',
      name: 'premiumFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Renew Subscription`
  String get renewSubscription {
    return Intl.message(
      'Renew Subscription',
      name: 'renewSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription will be expire on {date}`
  String yourSubscriptionWillBeExpireOnWithDate(Object date) {
    return Intl.message(
      'Your subscription will be expire on $date',
      name: 'yourSubscriptionWillBeExpireOnWithDate',
      desc: '',
      args: [date],
    );
  }

  /// `Expires on {date}`
  String expireOn(Object date) {
    return Intl.message(
      'Expires on $date',
      name: 'expireOn',
      desc: '',
      args: [date],
    );
  }

  /// `Remaining : {days} days`
  String remainingDays(Object days) {
    return Intl.message(
      'Remaining : $days days',
      name: 'remainingDays',
      desc: '',
      args: [days],
    );
  }

  /// `{days} days left`
  String daysLeft(Object days) {
    return Intl.message(
      '$days days left',
      name: 'daysLeft',
      desc: '',
      args: [days],
    );
  }

  /// `Upgrade to unlock PRO features`
  String get upgradeToUnlockProFeatures {
    return Intl.message(
      'Upgrade to unlock PRO features',
      name: 'upgradeToUnlockProFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Your current subscription`
  String get yourCurrentSubscription {
    return Intl.message(
      'Your current subscription',
      name: 'yourCurrentSubscription',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message('Coming Soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `Your session has been expired!`
  String get yourSessionHasBeenExpired {
    return Intl.message(
      'Your session has been expired!',
      name: 'yourSessionHasBeenExpired',
      desc: '',
      args: [],
    );
  }

  /// `Login again to continue`
  String get loginAgainToContinue {
    return Intl.message(
      'Login again to continue',
      name: 'loginAgainToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Login Again`
  String get loginAgain {
    return Intl.message('Login Again', name: 'loginAgain', desc: '', args: []);
  }

  /// `If you find this alert/post/comments to be false, misleading, or inappropriate, please report it. Our team will review and take necessary actions.`
  String get ifYouFindThisAlertPostCommentMisleading {
    return Intl.message(
      'If you find this alert/post/comments to be false, misleading, or inappropriate, please report it. Our team will review and take necessary actions.',
      name: 'ifYouFindThisAlertPostCommentMisleading',
      desc: '',
      args: [],
    );
  }

  /// `Agree and Continue`
  String get agreeAndContinue {
    return Intl.message(
      'Agree and Continue',
      name: 'agreeAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Location access required`
  String get locationAccessRequired {
    return Intl.message(
      'Location access required',
      name: 'locationAccessRequired',
      desc: '',
      args: [],
    );
  }

  /// `Shojag collects your location data to:`
  String get shojagCollectsYourLocationDataTo {
    return Intl.message(
      'Shojag collects your location data to:',
      name: 'shojagCollectsYourLocationDataTo',
      desc: '',
      args: [],
    );
  }

  /// `<tab1/><icon/> Identify your current location.<br/><tab1/><icon/> Notify you about nearby alerts created by other users.<br/><tab1/><icon/> Notify your friends and family when you reach specific places.<br/><tab1/><icon/> Share your live location with selected contacts and your data will be securely stored and <bold>only</bold> shared with contacts you approve.<br/><br/><bold>This data is collected even when the app is closed or not in use</bold> to ensure accurate alerts and real-time updates.<br/><br/><red>⚠ <bold>Without this permission, Shojag cannot provide its core features.</bold></red>`
  String get shojagLocationDataUsageMessages {
    return Intl.message(
      '<tab1/><icon/> Identify your current location.<br/><tab1/><icon/> Notify you about nearby alerts created by other users.<br/><tab1/><icon/> Notify your friends and family when you reach specific places.<br/><tab1/><icon/> Share your live location with selected contacts and your data will be securely stored and <bold>only</bold> shared with contacts you approve.<br/><br/><bold>This data is collected even when the app is closed or not in use</bold> to ensure accurate alerts and real-time updates.<br/><br/><red>⚠ <bold>Without this permission, Shojag cannot provide its core features.</bold></red>',
      name: 'shojagLocationDataUsageMessages',
      desc: '',
      args: [],
    );
  }

  /// `Current Subscription`
  String get currentSubscription {
    return Intl.message(
      'Current Subscription',
      name: 'currentSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Try Premium Features`
  String get tryPremiumFeatures {
    return Intl.message(
      'Try Premium Features',
      name: 'tryPremiumFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Tour Again`
  String get tourAgain {
    return Intl.message('Tour Again', name: 'tourAgain', desc: '', args: []);
  }

  /// `Phone number is required`
  String get phoneNumberIsRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneNumberIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number should be 11 digits`
  String get phoneShouldBeElevenDigits {
    return Intl.message(
      'Phone number should be 11 digits',
      name: 'phoneShouldBeElevenDigits',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email should be valid`
  String get emailShouldBeValid {
    return Intl.message(
      'Email should be valid',
      name: 'emailShouldBeValid',
      desc: '',
      args: [],
    );
  }

  /// `First name is required`
  String get firstNameIsRequired {
    return Intl.message(
      'First name is required',
      name: 'firstNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Last name is required`
  String get lastNameIsRequired {
    return Intl.message(
      'Last name is required',
      name: 'lastNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gender is required`
  String get genderIsRequired {
    return Intl.message(
      'Gender is required',
      name: 'genderIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Police ID is required`
  String get policeIdIsRequired {
    return Intl.message(
      'Police ID is required',
      name: 'policeIdIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Thana is required`
  String get thanaIsRequired {
    return Intl.message(
      'Thana is required',
      name: 'thanaIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Fire station is required`
  String get fireStationIsRequired {
    return Intl.message(
      'Fire station is required',
      name: 'fireStationIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Hospital or Agency is required`
  String get hospitalOrAgencyIsRequired {
    return Intl.message(
      'Hospital or Agency is required',
      name: 'hospitalOrAgencyIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least {count} characters`
  String passwordShouldBeAtLeastCharacters(int count) {
    final NumberFormat countNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String countString = countNumberFormat.format(count);

    return Intl.message(
      'Password should be at least $countString characters',
      name: 'passwordShouldBeAtLeastCharacters',
      desc: '',
      args: [countString],
    );
  }

  /// `Repeat password is required`
  String get repeatPasswordIsRequired {
    return Intl.message(
      'Repeat password is required',
      name: 'repeatPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password didn't match`
  String get passwordDidNotMatch {
    return Intl.message(
      'Repeat password didn\'t match',
      name: 'passwordDidNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `{name} can't be empty`
  String canNotBeNullOrEmptyByField(Object name) {
    return Intl.message(
      '$name can\'t be empty',
      name: 'canNotBeNullOrEmptyByField',
      desc: '',
      args: [name],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
