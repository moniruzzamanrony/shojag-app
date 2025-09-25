// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bn locale. All the
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
  String get localeName => 'bn';

  static String m0(username) =>
      "<bold>${username}</bold> এর লোকেশন নোটিফিকেশন পেতে লোকেশন যুক্ত করুন।\n\n১. ম্যাপে ট্যাপ করুন।\n২. লোকেশন লেবেল সেট করুন।";

  static String m1(user_type) => "ইতোমধ্যেই ${user_type} রেসপন্স করেছেন";

  static String m2(name) => "আপনি ${name} কে এফএফএন এর জন্য অনুরোধ পাঠাতে চান?";

  static String m3(name) => "দ্বারা ${name}";

  static String m4(name) => "${name} অবশ্যই দিতে হবে";

  static String m5(type) => "নতুন ${type} এ্যালার্ট";

  static String m6(days) => "${days} দিন বাকি";

  static String m7(name) => "${name} আপনার সাথে লোকেশন শেয়ার চালু করেননি";

  static String m8(name) => "${name} কে বার্তা পাঠান";

  static String m9(date) => "মেয়াদ শেষ হবে ${date}";

  static String m10(hour) => "${hour} ঘণ্টার জন্য";

  static String m11(name) => "${name}\'s লোকেশন";

  static String m12(name) => "${name} থেকে বার্তাঃ";

  static String m13(type) =>
      "কোন ${type} এ্যালার্ট পাওয়া যায়নি অথবা ইন্টারনেট চেক করুন";

  static String m14(count) => "পাসওয়ার্ড কমপক্ষে ${count} সংখ্যার হতে হবে";

  static String m15(days) => "অবশিষ্ট : ${days} দিন";

  static String m16(name) => "${name} এর সাথে আপনার লোকেশন শেয়ার করুন";

  static String m17(unit, distance) =>
      "${distance} ${Intl.select(unit, {'km': 'কি.মি', 'meter': 'মিটার', 'other': 'n/a'})}";

  static String m18(currency, amount) => "আনলক প্রো ${currency} ${amount}";

  static String m19(currency, amount, days) =>
      "আনলক প্রো ${days} দিন ${currency} ${amount}";

  static String m20(time) => "${time} পর্যন্ত";

  static String m21(count) =>
      "প্রতিটি এফএনএফ এ আপনি সর্বোচ্চ ${count} টি লোকেশন যুক্ত করতে পারবেন এবং তারা যখন লোকেশনে পৌঁছাবে, আপনি একটি নোটিফিকেশন পাবেন।";

  static String m22(date) => "সাবস্ক্রিপশন এর মেয়াদ শেষ হবে ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("গ্রহণ করুন"),
    "accessToYourLocationWhenTheAppIsInBackground":
        MessageLookupByLibrary.simpleMessage(
          "অ্যাপ ব্যাকগ্রাউন্ড অবস্থায় লোকেশন শেয়ার করুন",
        ),
    "active": MessageLookupByLibrary.simpleMessage("সক্রিয়"),
    "activeAlerts": MessageLookupByLibrary.simpleMessage("সক্রিয় এ্যালার্ট"),
    "add": MessageLookupByLibrary.simpleMessage("যোগ"),
    "addCustomLocation": MessageLookupByLibrary.simpleMessage(
      "এফএনএফ লোকেশন যুক্ত করুন",
    ),
    "addFnf": MessageLookupByLibrary.simpleMessage("এফএনএফ যুক্ত করুন"),
    "addLocationToolTipWithUsername": m0,
    "addNewFnF": MessageLookupByLibrary.simpleMessage("নতুন এফএনএফ যোগ করুন"),
    "addToFnfList": MessageLookupByLibrary.simpleMessage("এফএনএফ যোগ করুন"),
    "address": MessageLookupByLibrary.simpleMessage("ঠিকানা"),
    "addressAddedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "ঠিকানা সফলভাবে যুক্ত হয়েছে",
    ),
    "addressDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "ঠিকানা সফলভাবে মুছে ফেলা হয়েছে",
    ),
    "addressOptional": MessageLookupByLibrary.simpleMessage("ঠিকানা (ঐচ্ছিক)"),
    "agreeAndContinue": MessageLookupByLibrary.simpleMessage("সম্মতি দিলাম"),
    "alert": MessageLookupByLibrary.simpleMessage("এ্যালার্ট"),
    "alertClosedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "এ্যালার্ট সফলভাবে বন্ধ করা হয়েছে",
    ),
    "alertDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "এ্যালার্ট মুছে ফেলা হয়েছে",
    ),
    "alertDescription": MessageLookupByLibrary.simpleMessage(
      "এ্যালার্ট এর বিবরণ",
    ),
    "alertDetails": MessageLookupByLibrary.simpleMessage("এ্যালার্ট বিবরণ"),
    "alertList": MessageLookupByLibrary.simpleMessage("এ্যালার্ট তালিকা"),
    "alertMap": MessageLookupByLibrary.simpleMessage("এ্যালার্ট ম্যাপ"),
    "alertResponseCancelSuccessfully": MessageLookupByLibrary.simpleMessage(
      "এ্যালার্ট রেসপন্স বাতিল করা হয়েছে",
    ),
    "alertUpdate": MessageLookupByLibrary.simpleMessage("এ্যালার্ট আপডেট করুন"),
    "alerts": MessageLookupByLibrary.simpleMessage("এ্যালার্ট"),
    "allYourDataWillBeDeleted": MessageLookupByLibrary.simpleMessage(
      "আপনার সমস্ত এ্যালার্ট, প্রতিক্রিয়া, এফএনএফ এবং প্রোফাইল ডেটা মুছে ফেলা হবে। একবার আপনি মুছে ফেললে আপনি স্বজাগে আপনার অ্যাক্সেস হারাবেন।",
    ),
    "allowShojagToAccessYourBackgroundLocationToShare":
        MessageLookupByLibrary.simpleMessage(
          "স্বজাগ\'এর এই ফিচারটি ব্যবহার করতে আপনার ব্যাকগ্রাউন্ড লোকেশন পার্মিশন দিন।",
        ),
    "alreadyAMember": MessageLookupByLibrary.simpleMessage(
      "একটি অ্যাকাউন্ট আছে?",
    ),
    "alreadyInFnfList": MessageLookupByLibrary.simpleMessage(
      "এফএনএফ ইতিমধ্যে আছে",
    ),
    "alreadyRespondedByUserType": m1,
    "alsoShareThisAlertWith": MessageLookupByLibrary.simpleMessage(
      "এই এ্যালার্টটি শেয়ার করুন",
    ),
    "ambulance": MessageLookupByLibrary.simpleMessage("আম্বুলেন্স"),
    "app_title": MessageLookupByLibrary.simpleMessage("সজাগ"),
    "areYouSureYouWantToAcceptThisRequest":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি এই রিকুয়েস্ট গ্রহণ করতে চান?",
        ),
    "areYouSureYouWantToCancelFnFRequest": MessageLookupByLibrary.simpleMessage(
      "আপনি কি এই এফএনএফ রিকুয়েস্ট বাতিল করতে চান?",
    ),
    "areYouSureYouWantToCancelThisResponse":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি এই প্রতিক্রিয়া বাতিল করতে চান?",
        ),
    "areYouSureYouWantToCloseThisAlert": MessageLookupByLibrary.simpleMessage(
      "আপনি কি এই এ্যালার্ট বন্ধ করতে চান?",
    ),
    "areYouSureYouWantToDeclineThisRequest":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি এই রিকুয়েস্ট অস্বীকার করতে চান?",
        ),
    "areYouSureYouWantToDeleteThisAlert": MessageLookupByLibrary.simpleMessage(
      "আপনি কি এই এ্যালার্ট মুছতে চান?",
    ),
    "areYouSureYouWantToDeleteThisResponse":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি এই প্রতিক্রিয়া মুছতে চান?",
        ),
    "areYouSureYouWantToDeleteYourAccount":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি আপনার অ্যাকাউন্ট মুছে ফেলতে চান?",
        ),
    "areYouSureYouWantToRemoveAddress": MessageLookupByLibrary.simpleMessage(
      "আপনি কি এই ঠিকানা বাদ দিতে চান?",
    ),
    "areYouSureYouWantToRemoveFromYourFnfList":
        MessageLookupByLibrary.simpleMessage(
          "আপনার কি আপনার এফএনএফ লিস্ট থেকে বাদ দিতে চান?",
        ),
    "areYouSureYouWantToRespondToThisAlert":
        MessageLookupByLibrary.simpleMessage(
          "আপনি কি এই এ্যালার্ট প্রতিক্রিয়া করতে চান?",
        ),
    "areYouSureYouWantToSendRequestToUserName": m2,
    "areYouSureYouWantToUpdateThisAlert": MessageLookupByLibrary.simpleMessage(
      "আপনি কি এই এ্যালার্ট আপডেট করতে চান?",
    ),
    "backgroundLocation": MessageLookupByLibrary.simpleMessage(
      "ব্যাকগ্রাউন্ড লোকেশন",
    ),
    "bangla": MessageLookupByLibrary.simpleMessage("বাংলা"),
    "byWithName": m3,
    "call": MessageLookupByLibrary.simpleMessage("কল"),
    "callNowToTalk": MessageLookupByLibrary.simpleMessage(
      "কথা বলতে <call>৯৯৯</call> কল করুন",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("ক্যামেরা"),
    "canNotBeNullOrEmptyByField": m4,
    "cancel": MessageLookupByLibrary.simpleMessage("বাতিল"),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("অনুরোধ বাতিল"),
    "captureOrUploadImage": MessageLookupByLibrary.simpleMessage(
      "ছবি তুলুন বা আপলোড করুন",
    ),
    "change": MessageLookupByLibrary.simpleMessage("পরিবর্তন"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড পরিবর্তন",
    ),
    "changePermission": MessageLookupByLibrary.simpleMessage(
      "পার্মিশন পরিবর্তন",
    ),
    "changeYourAccountPassword": MessageLookupByLibrary.simpleMessage(
      "অ্যাকাউন্ট পাসওয়ার্ড পরিবর্তন করুন",
    ),
    "citizen": MessageLookupByLibrary.simpleMessage("সিটিজেন"),
    "close": MessageLookupByLibrary.simpleMessage("বন্ধ"),
    "closed": MessageLookupByLibrary.simpleMessage("বন্ধ"),
    "closedAlerts": MessageLookupByLibrary.simpleMessage("বন্ধ এ্যালার্ট"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("শীঘ্রই আসছে"),
    "community": MessageLookupByLibrary.simpleMessage("কমিউনিটি"),
    "communityAlertCreateInfoNotice": MessageLookupByLibrary.simpleMessage(
      "বর্তমানে অল্পসংখ্যক কমিউনিটি এই অ্যাপটি ব্যবহার করায়, কমিউনিটি সহায়তা পেতে সাময়িক বিলম্ব হতে পারে। তবে আমরা ক্রমাগত সম্প্রসারিত হচ্ছি, এবং বিশ্বাস করি, সময়ের সঙ্গে এই সহায়তা আরও দ্রুত ও কার্যকর হয়ে উঠবে।",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("নিশ্চিত"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "নতুন পাসওয়ার্ড নিশ্চিত করুন",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড নিশ্চিত করুন",
    ),
    "confirmation": MessageLookupByLibrary.simpleMessage("নিশ্চিত করুন"),
    "congratulationsWithQuotes": MessageLookupByLibrary.simpleMessage(
      "অভিনন্দন!",
    ),
    "contacts": MessageLookupByLibrary.simpleMessage("কন্ট্যাক্টস"),
    "createAlert": MessageLookupByLibrary.simpleMessage("এ্যালার্ট তৈরি করুন"),
    "createTypeNewAlert": m5,
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "বর্তমান পাসওয়ার্ড",
    ),
    "currentSubscription": MessageLookupByLibrary.simpleMessage(
      "বর্তমান সাবস্ক্রিপশন",
    ),
    "date": MessageLookupByLibrary.simpleMessage("তারিখ"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("জন্ম তারিখ"),
    "daysLeft": m6,
    "decline": MessageLookupByLibrary.simpleMessage("অস্বীকার"),
    "delete": MessageLookupByLibrary.simpleMessage("মুছুন"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("অ্যাকাউন্ট মুছুন"),
    "deletePermanently": MessageLookupByLibrary.simpleMessage(
      "স্থায়ীভাবে মুছুন",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "আপনার অ্যাকাউন্ট মুছুন",
    ),
    "describeYourIncident": MessageLookupByLibrary.simpleMessage(
      "আপনার ঘটনার বিবরণ লিখুন",
    ),
    "didNotReceivedCode": MessageLookupByLibrary.simpleMessage("কোড পাননি?"),
    "didNotSharedLocationWithYouUserName": m7,
    "district": MessageLookupByLibrary.simpleMessage("জেলা"),
    "dob": MessageLookupByLibrary.simpleMessage("জন্ম তারিখ"),
    "dropAMessageForUserName": m8,
    "edit": MessageLookupByLibrary.simpleMessage("সম্পাদনা"),
    "editProfile": MessageLookupByLibrary.simpleMessage("প্রোফাইল সম্পাদনা"),
    "egFlatNoRoadNo": MessageLookupByLibrary.simpleMessage(
      "উদাঃ ফ্ল্যাট নং, রোড নং",
    ),
    "email": MessageLookupByLibrary.simpleMessage("ইমেইল"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage("ইমেইল লিখুন"),
    "emailShouldBeValid": MessageLookupByLibrary.simpleMessage(
      "সঠিক ইমেইল লিখুন",
    ),
    "emergency": MessageLookupByLibrary.simpleMessage("জরুরী"),
    "emergencyService": MessageLookupByLibrary.simpleMessage("জরুরী সেবা"),
    "enableBackgroundLocationToShareYourLocation":
        MessageLookupByLibrary.simpleMessage(
          "অ্যাপ চালু না থাকলেও লোকেশন শেয়ার অব্যাহত রাখতে ব্যাকগ্রাউন্ড লোকেশন চালু করুন",
        ),
    "english": MessageLookupByLibrary.simpleMessage("ইংরেজি"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("পাসওয়ার্ড লিখুন"),
    "enterPlaceName": MessageLookupByLibrary.simpleMessage("স্থানের নাম লিখুন"),
    "enterTheOtpSentToTheNumber": MessageLookupByLibrary.simpleMessage(
      "আপনার নাম্বারে পাঠানো OTP লিখুন",
    ),
    "enterYourPasswordToProceed": MessageLookupByLibrary.simpleMessage(
      "এগিয়ে যেতে আপনার পাসওয়ার্ড লিখুন",
    ),
    "expireOn": m9,
    "feedback": MessageLookupByLibrary.simpleMessage("ফিডব্যাক"),
    "feedbackSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "মতামত সফলভাবে প্রেরণ করা হয়েছে",
    ),
    "female": MessageLookupByLibrary.simpleMessage("মহিলা"),
    "finish": MessageLookupByLibrary.simpleMessage("শেষ করুন"),
    "fireStation": MessageLookupByLibrary.simpleMessage("ফায়ার স্টেশন"),
    "fireStationIsRequired": MessageLookupByLibrary.simpleMessage(
      "ফাইর স্টেশন নির্বাচন করুন",
    ),
    "fire_service": MessageLookupByLibrary.simpleMessage("ফায়ার সার্ভিস"),
    "firstName": MessageLookupByLibrary.simpleMessage("প্রথম নাম"),
    "firstNameIsRequired": MessageLookupByLibrary.simpleMessage(
      "ফার্স্ট নাম লিখুন",
    ),
    "fnf": MessageLookupByLibrary.simpleMessage("এফএনএফ"),
    "fnfLocator": MessageLookupByLibrary.simpleMessage("এফএনএফ লোকেটর"),
    "forWithHour": m10,
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড ভুলে গেছেন",
    ),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড ভুলে গেছেন?",
    ),
    "gallery": MessageLookupByLibrary.simpleMessage("গ্যালারি"),
    "gender": MessageLookupByLibrary.simpleMessage("লিঙ্গ"),
    "genderIsRequired": MessageLookupByLibrary.simpleMessage(
      "লিঙ্গ নির্বাচন করুন",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("শুরু করুন"),
    "home": MessageLookupByLibrary.simpleMessage("হোম"),
    "hospitalAgency": MessageLookupByLibrary.simpleMessage("হাসপাতাল/এজেন্সি"),
    "hospitalOrAgencyIsRequired": MessageLookupByLibrary.simpleMessage(
      "হাসপাতাল অথবা এজেন্সি নির্বাচন করুন",
    ),
    "iAgreeToThe": MessageLookupByLibrary.simpleMessage(
      "আমি সম্মতি প্রদান করছি",
    ),
    "iAmSure": MessageLookupByLibrary.simpleMessage("আমি নিশ্চিত"),
    "iAmSureAboutTheAlert": MessageLookupByLibrary.simpleMessage(
      "আপনি কি নিশ্চিত, এ্যালার্টটি তৈরী করতে চাচ্ছেন? অসত্য এ্যালার্ট আইনি ব্যবস্থা ও অ্যাকাউন্ট বাতিলের কারন হতে পারে।",
    ),
    "ifYouFindThisAlertPostCommentMisleading": MessageLookupByLibrary.simpleMessage(
      "আপনি যদি এই এ্যালার্ট/পোস্ট/মন্তব্যগুলিকে মিথ্যা, বিভ্রান্তিকর বা অনুপযুক্ত বলে মনে করেন, তাহলে অনুগ্রহ করে রিপোর্ট করুন। আমাদের টীম তা পর্যালোচনা করবে এবং প্রয়োজনীয় ব্যবস্থা নেবে।",
    ),
    "invite": MessageLookupByLibrary.simpleMessage("আমন্ত্রণ জানান"),
    "joinNow": MessageLookupByLibrary.simpleMessage("যোগ দিন"),
    "language": MessageLookupByLibrary.simpleMessage("ভাষা"),
    "lastName": MessageLookupByLibrary.simpleMessage("শেষ নাম"),
    "lastNameIsRequired": MessageLookupByLibrary.simpleMessage(
      "লাস্ট নাম লিখুন",
    ),
    "latestAlerts": MessageLookupByLibrary.simpleMessage("সর্বশেষ এ্যালার্ট"),
    "loading": MessageLookupByLibrary.simpleMessage("লোড হচ্ছে"),
    "locateYourFnf": MessageLookupByLibrary.simpleMessage("এফএনএফ লোকেশন"),
    "locateYourFnfLiveLocation": MessageLookupByLibrary.simpleMessage(
      "আপনি বিশ্বের যেকোনো জায়গায় আপনার FnF এর অবস্থান দেখতে পারবেন এবং তাদের লাইভ লোকেশন ট্র্যাক করতে পারবেন।",
    ),
    "location": MessageLookupByLibrary.simpleMessage("স্থান"),
    "locationAccessRequired": MessageLookupByLibrary.simpleMessage(
      "লোকেশন অ্যাক্সেস প্রয়োজন",
    ),
    "locationSettings": MessageLookupByLibrary.simpleMessage("লোকেশন সেটিংস"),
    "locationWithUserName": m11,
    "login": MessageLookupByLibrary.simpleMessage("লগইন"),
    "loginAgain": MessageLookupByLibrary.simpleMessage("আবার লগিন করুন"),
    "loginAgainToContinue": MessageLookupByLibrary.simpleMessage(
      "অ্যাপ ব্যবহার আবার লগিন করুন",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("লগ আউট"),
    "male": MessageLookupByLibrary.simpleMessage("পুরুষ"),
    "map": MessageLookupByLibrary.simpleMessage("ম্যাপ"),
    "message": MessageLookupByLibrary.simpleMessage("বার্তা"),
    "messageFromUserName": m12,
    "messageSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "বার্তা সফলভাবে পাঠানো হয়েছে",
    ),
    "myAlerts": MessageLookupByLibrary.simpleMessage("আমার এ্যালার্ট"),
    "name": MessageLookupByLibrary.simpleMessage("নাম"),
    "nameIsRequired": MessageLookupByLibrary.simpleMessage("নাম লিখুন"),
    "newAlert": MessageLookupByLibrary.simpleMessage("নতুন এ্যালার্ট"),
    "newPassword": MessageLookupByLibrary.simpleMessage("নতুন পাসওয়ার্ড"),
    "newPlace": MessageLookupByLibrary.simpleMessage("নতুন লোকেশন"),
    "next": MessageLookupByLibrary.simpleMessage("পরবর্তী"),
    "nid": MessageLookupByLibrary.simpleMessage("এন আই ডি"),
    "no": MessageLookupByLibrary.simpleMessage("না"),
    "noAlertFound": MessageLookupByLibrary.simpleMessage("কোন এ্যালার্ট নেই"),
    "noAlertsFoundTypeOrCheckInternet": m13,
    "noContactsFound": MessageLookupByLibrary.simpleMessage(
      "কন্ট্যাক্টস পাওয়া যায়নি",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "ইন্টারনেট সংযোগ নেই",
    ),
    "noMessagesFound": MessageLookupByLibrary.simpleMessage(
      "এখনো কোন বার্তা পাঠানো হয়নি",
    ),
    "noResponsesYet": MessageLookupByLibrary.simpleMessage(
      "কোনো প্রতিক্রিয়া নেই",
    ),
    "noUserFound": MessageLookupByLibrary.simpleMessage(
      "কোন ব্যবহারকারী পাওয়া যায়নি। সঠিক নাম্বার দিয়ে আবার চেষ্টা করুন",
    ),
    "notAMember": MessageLookupByLibrary.simpleMessage("অ্যাকাউন্ট নেই?"),
    "notification": MessageLookupByLibrary.simpleMessage("নোটিফিকেশন"),
    "off": MessageLookupByLibrary.simpleMessage("বন্ধ"),
    "ok": MessageLookupByLibrary.simpleMessage("ওকে"),
    "on": MessageLookupByLibrary.simpleMessage("চালু"),
    "organization": MessageLookupByLibrary.simpleMessage("সংস্থা"),
    "other": MessageLookupByLibrary.simpleMessage("অন্যান্য"),
    "otpVerification": MessageLookupByLibrary.simpleMessage("OTP ভেরিফিকেশন"),
    "password": MessageLookupByLibrary.simpleMessage("পাসওয়ার্ড"),
    "passwordDidNotMatch": MessageLookupByLibrary.simpleMessage(
      "একই পাসওয়ার্ড লিখুন",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড লিখুন",
    ),
    "passwordShouldBeAtLeastCharacters": m14,
    "pending": MessageLookupByLibrary.simpleMessage("পেন্ডিং"),
    "permissionLocationSettings": MessageLookupByLibrary.simpleMessage(
      "অ্যাপ সেটিংস > পার্মিশন > লোকেশন > অ্যালাউ অল দ্যা টাইম",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("ফোন"),
    "phoneNumberIsRequired": MessageLookupByLibrary.simpleMessage(
      "ফোন নাম্বার লিখুন",
    ),
    "phoneShouldBeElevenDigits": MessageLookupByLibrary.simpleMessage(
      "ফোন নাম্বার ১১ ডিজিট হতে হবে",
    ),
    "pleaseEnter4DigitOtp": MessageLookupByLibrary.simpleMessage(
      "আপনাকে পাঠানো 4 ডিজিট OTP লিখুন",
    ),
    "pleaseExplainInDetailWhyYouWantToReportAnIssue":
        MessageLookupByLibrary.simpleMessage(
          "দয়া করে আপনি রিপোর্ট করার কারন বিস্তারিত বলুন এবং প্রয়োজনীয় তথ্য দিন যাতে আমাদের টিম দ্রুত ব্যবস্থা নিতে পারে।",
        ),
    "pleaseProvideYourValuableFeedback": MessageLookupByLibrary.simpleMessage(
      "অ্যাপ ও সার্ভিস সম্পর্কে আপনার মূল্যবান মতামত দিন, এটি আমরা আমাদের উন্নত সেবা প্রদানে সাহায্য করবে।",
    ),
    "pleaseSelectAnIncidentType": MessageLookupByLibrary.simpleMessage(
      "ঘটনার ধরণ নির্বাচন করুন",
    ),
    "pleaseUpgradeToProToUnlockAllFeatures":
        MessageLookupByLibrary.simpleMessage(
          "সকল ফিচার ব্যবহার করতে অনুগ্রহ করে \'প্রো\' তে আপগ্রেড করুন\'",
        ),
    "police": MessageLookupByLibrary.simpleMessage("পুলিশ"),
    "policeId": MessageLookupByLibrary.simpleMessage("পুলিশ আইডি"),
    "policeIdIsRequired": MessageLookupByLibrary.simpleMessage(
      "পুলিশ আইডি লিখুন",
    ),
    "postAlert": MessageLookupByLibrary.simpleMessage("এ্যালার্ট তৈরী করুন"),
    "premiumFeatures": MessageLookupByLibrary.simpleMessage(
      "প্রিমিয়াম সেবাসমূহ",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("পূর্ববর্তী"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("প্রাইভেসি পলিসি"),
    "pro": MessageLookupByLibrary.simpleMessage("প্রো"),
    "profile": MessageLookupByLibrary.simpleMessage("প্রোফাইল"),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "প্রোফাইল সফলভাবে আপডেট হয়েছে",
    ),
    "radius": MessageLookupByLibrary.simpleMessage("পরিক্ষেপ"),
    "register": MessageLookupByLibrary.simpleMessage("রেজিস্টার"),
    "registration": MessageLookupByLibrary.simpleMessage("রেজিস্ট্রেশন"),
    "remainingDays": m15,
    "renewSubscription": MessageLookupByLibrary.simpleMessage(
      "সাবস্ক্রিপশন রিনিউ করুন",
    ),
    "repeatPassword": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড নিশ্চিত করুন",
    ),
    "repeatPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "পুনরায় পাসওয়ার্ড লিখুন",
    ),
    "reportAnIssue": MessageLookupByLibrary.simpleMessage(
      "সমস্যা রিপোর্ট করুন",
    ),
    "reportSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "রিপোর্ট সফলভাবে পাঠানো হয়েছে",
    ),
    "requestSent": MessageLookupByLibrary.simpleMessage("অনুরোধ পাঠানো হয়েছে"),
    "requestSentWaitForAccept": MessageLookupByLibrary.simpleMessage(
      "অনুরোধ পাঠানো হয়েছে।",
    ),
    "requestToShareLocation": MessageLookupByLibrary.simpleMessage(
      "লোকেশন শেয়ার করতে অনুরোধ করুন",
    ),
    "resend": MessageLookupByLibrary.simpleMessage("পুনরায় পাঠান"),
    "resendOtp": MessageLookupByLibrary.simpleMessage("পুনরায় OTP পাঠান"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড রিসেট করুন",
    ),
    "resetYourAccountPasswordAndAccess": MessageLookupByLibrary.simpleMessage(
      "আপনার অ্যাকাউন্ট এর পাসওয়ার্ড রিসেট করুন",
    ),
    "responded": MessageLookupByLibrary.simpleMessage("প্রতিক্রিয়া"),
    "respondedAlerts": MessageLookupByLibrary.simpleMessage(
      "প্রতিক্রিয়া এ্যালার্ট",
    ),
    "response": MessageLookupByLibrary.simpleMessage("প্রতিক্রিয়া"),
    "responseSent": MessageLookupByLibrary.simpleMessage(
      "প্রতিক্রিয়া পাঠানো হয়েছে",
    ),
    "responses": MessageLookupByLibrary.simpleMessage("প্রতিক্রিয়া সমুহ"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("সংরক্ষণ করুন"),
    "search": MessageLookupByLibrary.simpleMessage("অনুসন্ধান"),
    "searchFnf": MessageLookupByLibrary.simpleMessage("এফএনএফ খুঁজুন"),
    "searchNumber": MessageLookupByLibrary.simpleMessage("ফোন নাম্বার খুঁজুন"),
    "searchResults": MessageLookupByLibrary.simpleMessage("অনুসন্ধান তালিকা"),
    "seeAll": MessageLookupByLibrary.simpleMessage("সব দেখুন"),
    "selectALocation": MessageLookupByLibrary.simpleMessage(
      "লোকেশন নির্বাচন করুন",
    ),
    "selectAlertLocation": MessageLookupByLibrary.simpleMessage(
      "ঘটনার স্থান নির্বাচন করুন",
    ),
    "selectAnOption": MessageLookupByLibrary.simpleMessage("নির্বাচন করুন"),
    "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
      "অ্যাপের ভাষা নির্বাচন করুন",
    ),
    "selectDistrict": MessageLookupByLibrary.simpleMessage(
      "জেলা নির্বাচন করুন",
    ),
    "selectHowYouWantToJoinWith": MessageLookupByLibrary.simpleMessage(
      "কিভাবে যোগ দিতে চান?",
    ),
    "selectIncidentType": MessageLookupByLibrary.simpleMessage(
      "ঘটনার ধরণ নির্বাচন করুন",
    ),
    "selectThana": MessageLookupByLibrary.simpleMessage("থানা নির্বাচন করুন"),
    "selectYourAreaRadius": MessageLookupByLibrary.simpleMessage(
      "আপনার সীমানা নির্বাচন করুন",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("কোড পাঠান"),
    "setANewPassword": MessageLookupByLibrary.simpleMessage(
      "একটি নতুন পাসওয়ার্ড সেট করুন",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("সেটিংস"),
    "shareLocation": MessageLookupByLibrary.simpleMessage(
      "লোকেশন শেয়ার করুন",
    ),
    "shareYourRealTimeLocationWithName": m16,
    "sharingPermission": MessageLookupByLibrary.simpleMessage(
      "শেয়ারিং পার্মিশন",
    ),
    "sharingWithYou": MessageLookupByLibrary.simpleMessage(
      "আপনাকে শেয়ার করা হচ্ছে",
    ),
    "shojagCollectsBackgroundLocationToShareWithFnF":
        MessageLookupByLibrary.simpleMessage(
          "স্বজাগ আপনার ব্যাকগ্রাউন্ড লোকেশন এফএনএফ দের সাথে শেয়ার করতে ব্যবহার করে, এমনকি যখন অ্যাপ বন্ধ বা নিষ্ক্রিয় থাকে",
        ),
    "shojagCollectsYourLocationDataTo": MessageLookupByLibrary.simpleMessage(
      "সজাগ আপনার লোকেশন ডেটা সংগ্রহ করেঃ",
    ),
    "shojagLocationDataUsageMessages": MessageLookupByLibrary.simpleMessage(
      "<tab1/><icon/> আপনার বর্তমান অবস্থান সনাক্ত করতে।<br/><tab1/><icon/> অন্যান্য ব্যবহারকারীদের দ্বারা তৈরি কাছাকাছি সতর্কতা সম্পর্কে আপনাকে অবহিত করতে।<br/><tab1/><icon/> আপনি নির্দিষ্ট জায়গায় পৌঁছলে আপনার বন্ধু এবং পরিবারকে অবহিত করতে।<br/><tab1/><icon/> নির্বাচিত পরিচিতিদের সাথে আপনার লাইভ অবস্থান শেয়ার করতে, আপনার ডেটা নিরাপদে সংরক্ষণ করা হবে এবং আপনার অনুমোদিত পরিচিতির সাথে <bold>শুধু</bold> শেয়ার করা হবে।<br/><br/><bold>সঠিক এ্যালার্ট এবং রিয়েল-টাইম আপডেট নিশ্চিত করতে </bold>অ্যাপ্লিকেশানটি বন্ধ থাকা বা ব্যবহার না করা অবস্থায়ও এই ডেটা সংগ্রহ করা হতে পারে।<br/><br/><red>⚠ <bold>এই অনুমতি ছাড়া, Shojag এর মূল বৈশিষ্ট্যগুলি প্রদান করতে পারবে না।</bold></red>",
    ),
    "shortDescription": MessageLookupByLibrary.simpleMessage("সংক্ষিপ্ত বিবরণ"),
    "skip": MessageLookupByLibrary.simpleMessage("স্কিপ করুন"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "কিছু ভুল হয়েছে",
    ),
    "starRequired": MessageLookupByLibrary.simpleMessage("* আবশ্যক"),
    "status": MessageLookupByLibrary.simpleMessage("স্থিতি"),
    "submit": MessageLookupByLibrary.simpleMessage("সাবমিট"),
    "submitReport": MessageLookupByLibrary.simpleMessage("সাবমিট রিপোর্ট"),
    "subscription": MessageLookupByLibrary.simpleMessage("সাবস্ক্রিপশন"),
    "successWithQuotes": MessageLookupByLibrary.simpleMessage("সফল!"),
    "tapOnMapToAddALocationAddSetALabel": MessageLookupByLibrary.simpleMessage(
      "লোকেশন যোগ করার জন্য ম্যাপে ট্যাপ করুন",
    ),
    "tapToSendMessage": MessageLookupByLibrary.simpleMessage(
      "বার্তা পাঠাতে ট্যাপ করুন",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage("শর্তাবলী"),
    "thana": MessageLookupByLibrary.simpleMessage("থানা"),
    "thanaIsRequired": MessageLookupByLibrary.simpleMessage(
      "থানা নির্বাচন করুন",
    ),
    "thisActionCannotBeUndone": MessageLookupByLibrary.simpleMessage(
      "এটি স্থায়ী এবং পূর্বাবস্থায় ফেরানো যাবে না",
    ),
    "toKMConverter": m17,
    "toShareYourLocationEvenTheApp": MessageLookupByLibrary.simpleMessage(
      "অ্যাপ বন্ধ বা নিষ্ক্রিয় থাকা অবস্থায়ও লোকেশন শেয়ার করতে অ্যাপের লোকেশন সেটিংস থেকে \'অ্যালাউ অল দ্যা টাইম\' নির্বাচন করুন",
    ),
    "togetherWeConnectTogetherWeProtect": MessageLookupByLibrary.simpleMessage(
      "সংযোগেই  সুরক্ষা",
    ),
    "tourAgain": MessageLookupByLibrary.simpleMessage("পুনরায় দেখুন"),
    "tripleNine": MessageLookupByLibrary.simpleMessage("৯৯৯"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("আবার চেষ্টা করুন"),
    "tryPremiumFeatures": MessageLookupByLibrary.simpleMessage(
      "প্রিমিয়াম ফিচারসমূহ দেখুন",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("বন্ধ করুন"),
    "turnOn": MessageLookupByLibrary.simpleMessage("চালু করুন"),
    "turnOnToGetNotifications": MessageLookupByLibrary.simpleMessage(
      "নোটিফিকেশন সক্রিয় করুন",
    ),
    "typeOfIncident": MessageLookupByLibrary.simpleMessage("এ্যালার্ট এর ধরণ"),
    "unlockProWithCurrencyAndAmount": m18,
    "unlockProWithCurrencyAndAmountAndDays": m19,
    "untilITurnThisOff": MessageLookupByLibrary.simpleMessage(
      "বন্ধ না করা পর্যন্ত",
    ),
    "untilWithTime": m20,
    "update": MessageLookupByLibrary.simpleMessage("আপডেট"),
    "updatePermissionAndService": MessageLookupByLibrary.simpleMessage(
      "পার্মিশন এবং সার্ভিস পরিবর্তন করুন",
    ),
    "upgrade": MessageLookupByLibrary.simpleMessage("আপগ্রেড"),
    "upgradeNow": MessageLookupByLibrary.simpleMessage("আপগ্রেড করুন"),
    "upgradeToPro": MessageLookupByLibrary.simpleMessage("প্রো তে আপগ্রেড"),
    "upgradeToShojagPro": MessageLookupByLibrary.simpleMessage(
      "স্বজাগ প্রো তে আপগ্রেড",
    ),
    "upgradeToUnlockProFeatures": MessageLookupByLibrary.simpleMessage(
      "প্রো সুবিধা পেতে আপগ্রেড করুন",
    ),
    "verification": MessageLookupByLibrary.simpleMessage("ভেরিফিকেশন"),
    "verify": MessageLookupByLibrary.simpleMessage("ভেরিফাই"),
    "version": MessageLookupByLibrary.simpleMessage("ভার্সন"),
    "viewImage": MessageLookupByLibrary.simpleMessage("ছবি দেখুন"),
    "viewMap": MessageLookupByLibrary.simpleMessage("ম্যাপ দেখুন"),
    "viewOnMap": MessageLookupByLibrary.simpleMessage("ম্যাপ এ দেখুন"),
    "wantToGetDirectHelp": MessageLookupByLibrary.simpleMessage(
      "জরুরি সাহায্য চান?",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("সতর্কতা!"),
    "welcome": MessageLookupByLibrary.simpleMessage("স্বাগতম"),
    "writeAMessage": MessageLookupByLibrary.simpleMessage("বার্তা লিখুন"),
    "writeShortDescriptionAboutTheIncident":
        MessageLookupByLibrary.simpleMessage("ঘটনার বিবরণ লিখুন"),
    "writeYourFeedbackHere": MessageLookupByLibrary.simpleMessage(
      "আপনার মতামত লিখুন...",
    ),
    "writeYourIssue": MessageLookupByLibrary.simpleMessage(
      "আপনার সমস্যা লিখুন",
    ),
    "writeYourMessageHere": MessageLookupByLibrary.simpleMessage(
      "আপনার মন্তব্য লিখুন",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("হ্যাঁ"),
    "you": MessageLookupByLibrary.simpleMessage("আপনি"),
    "youAreNotAPremiumUser": MessageLookupByLibrary.simpleMessage(
      "আপনার প্রিমিয়াম সাবস্ক্রিপশন নেই, প্রিমিয়াম সেবাসমূহ উপভোগ করতে আপগ্রেড করুন",
    ),
    "youAreSharing": MessageLookupByLibrary.simpleMessage("আপনি শেয়ার করছেন"),
    "youCanAddUnlimitedFnfWithPremiumUser": MessageLookupByLibrary.simpleMessage(
      "আপনি যত খুশি FnF যোগ করতে পারেন, তবে তাদেরও প্রিমিয়াম ইউজার হতে হবে।",
    ),
    "youCanAddUpToAddressWithCount": m21,
    "yourActiveAlerts": MessageLookupByLibrary.simpleMessage(
      "আপনার সক্রিয় এ্যালার্ট",
    ),
    "yourAlertHasBeenCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "আপনার এ্যালার্ট সফলভাবে তৈরী হয়েছে",
    ),
    "yourAlertHasBeenUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "আপনার এ্যালার্ট সফলভাবে আপডেট হয়েছে",
    ),
    "yourCurrentSubscription": MessageLookupByLibrary.simpleMessage(
      "আপনার বর্তমান সাবস্ক্রিপশন",
    ),
    "yourLifeLIneInEmergencies": MessageLookupByLibrary.simpleMessage(
      "জরুরি সময়ে আপনার প্রিয় সাথী, আপনার পাশেই",
    ),
    "yourSessionHasBeenExpired": MessageLookupByLibrary.simpleMessage(
      "আপনার সেশন এক্সপায়ার হয়ে গেছে!",
    ),
    "yourSubscriptionStatus": MessageLookupByLibrary.simpleMessage(
      "আপনার সাবস্ক্রিপশন স্ট্যাটাস",
    ),
    "yourSubscriptionWillBeExpireOnWithDate": m22,
  };
}
