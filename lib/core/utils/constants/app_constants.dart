import 'dart:io';

import 'package:latlong2/latlong.dart';

/// [AppConstants] is a class that contains all the constants used in the app
/// It contains the following constants:
/// appBaseUrl, appImageLoadBaseUrl, privacyPolicyUrl, appName, appPackageName,
/// appVersion, rootDirectoryDatabase, rootDirectoryImages, subdirectoryUser,
/// subdirectoryCategories, subdirectoryItems, dhakaLatLng, currencyShortForm
/// etc.
abstract class AppConstants {
  static const String appBaseUrl = 'https://shojag.com/';
  static const String appImageLoadBaseUrl = 'https://shojag.com/';
  static const String privacyPolicyUrl = 'https://shojag.com/privacy-policy';

  static const String appName = 'Shojag';
  static const String appPackageName = 'com.shojag.app';

  static const String _appVersionAndroid = '1.1.7';
  static const String _appVersionIOS = '1.2.0';

  static String get appVersion => Platform.isAndroid
      ? _appVersionAndroid
      : Platform.isIOS
          ? _appVersionIOS
          : '0.0.0';

  static const String rootDirectoryDatabase = 'database';
  static const String rootDirectoryImages = 'images';
  static const String subdirectoryUser = 'user';
  static const String subdirectoryCategories = 'categories';
  static const String subdirectoryItems = 'items';

  static const LatLng dhakaLatLng = LatLng(23.8356, 90.3730);

  static const String currencyShortForm = 'BDT';
  static const String currencySymbolBn = '৳';
  static const String currencySymbolEn = 'BDT';

  static const double minimumDistanceToUpdateInMeter = 30.0;
  static const num maxAreaRadius = 5000;

  static const int alertImagePreferredHeight = 300;
  static const int alertImagePreferredWidth = 300;
  static const int alertImagePreferredQuality = 80;

  static const String arraySplitter = ',';

  static const int maxFnfCount = 5;
  static const int maxFnfAddressLocationCount = 2;

  static const String defaultLanguageLocale = 'en';
  static const String defaultLanguageName = 'English';
  static const String defaultCountry = 'BD';

  static const String mapboxAccessTokenEnvKey = 'MAPBOX_ACCESS_TOKEN';
  static const String sslcommerzStoreIdEnvKey = 'SSLCOMMERZ_STORE_ID';
  static const String sslcommerzStorePasswordEnvKey =
      'SSLCOMMERZ_STORE_PASSWORD';

  // pusher project[app] name shojag
  static const String pusherAppId = '1999187';
  static const String pusherAPIKey = '1f0e458fb8e48ff9c055';
  static const String pusherSecretKey = 'be588125914f20e7d46c';
  static const String pusherClusterKey = 'ap2';

  static const String mapboxStyleForFnf =
      'mapbox://styles/shojagapp/cm4ba57sp000z01pi780ofnmj';
  static const String mapboxStyleForBasic =
      'mapbox://styles/shojagapp/cm3n4u7c8002n01qw1vmp4x6p';
}
