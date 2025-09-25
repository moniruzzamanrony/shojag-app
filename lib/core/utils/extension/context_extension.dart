import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/presentation/provider/location_provider.dart';
import '../../../shared/presentation/provider/session_provider.dart';

/// extension for context
extension ContextExtension on BuildContext {
  /// get [T] provider from context
  T provider<T>() => Provider.of<T>(this, listen: false);

  /// get language from context
  AppLocalizations get language => AppLocalizations.of(this);

  /// check if language is bangla
  bool get isBangla => Localizations.localeOf(this).languageCode == 'bn';

  m.TextTheme get textTheme => m.Theme.of(this).textTheme;

  m.ThemeData get theme => m.Theme.of(this);

  bool get isDark => theme.brightness == m.Brightness.dark;

  m.ColorScheme get colorScheme => m.Theme.of(this).colorScheme;

  SessionProvider get session => provider<SessionProvider>();

  LocationProvider get location => provider<LocationProvider>();

  PremiumProvider get premium => provider<PremiumProvider>();

  bool get isLoggedIn => session.isLoggedIn;

  int get userId => session.userId;

  String get firstName => session.firstName;

  String get lastName => session.lastName;

  String get name => '$firstName $lastName';

  String? get email => session.email;

  String? get phone => session.phone;

  String? get photo => session.photo;

  User? get user => session.getUser;

  UserType? get userType => session.userType;

  bool get isCitizen => userType == UserType.citizen;

  bool get isPolice => userType == UserType.police;

  bool get isFireService => userType == UserType.fireService;

  bool get isAmbulance => userType == UserType.ambulance;

  bool get isAPoliceOrFireServiceOrAmbulance =>
      isPolice || isFireService || isAmbulance;

  String get apiToken => session.apiToken;

  bool get isEmailVerified => session.isEmailVerified;

  bool get isValidPremiumUser => premium.premiumEntity.isValidPremiumUser;


  Future<bool> remoteUpdateUserLatLng(
          LatLng loc, int userId, String apiToken) async =>
      await location.updateUserLocation(
          latitude: loc.latitude,
          longitude: loc.longitude,
          userId: userId,
          apiToken: apiToken);

  LatLng get lastSavedLocationLatLng => location.lastSavedLocationLatLng;
}
