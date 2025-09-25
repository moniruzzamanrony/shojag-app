import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/config/router/routes.dart';
import '../../../feature/premium/presentation/provider/premium_provider.dart';
import '../../../feature/profile/presentation/provider/profile_provider.dart';
import '../provider/location_provider.dart';
import '../provider/session_provider.dart';
import '../provider/tooltip_provider.dart';

/// logout and clear all session data
void logoutAll(BuildContext context, {bool fromRemote = true}) async {
  final sessionProvider = context.read<SessionProvider>();
  final profileProvider = context.read<ProfileProvider>();
  final locationProvider = context.read<LocationProvider>();
  final premiumProvider = context.read<PremiumProvider>();
  final tooltipProvider = context.read<TooltipProvider>();

  try {
    sessionProvider.deleteNotificationToken();
  } catch (_) {}

  try {
    sessionProvider.clearFcmToken();
  } catch (_) {}

  try {
    locationProvider.clearLastLocation();
  } catch (_) {}

  try {
    premiumProvider.clearPremiumInfo();
  } catch (_) {}

  if (fromRemote) {
    try {
      profileProvider.logoutRemote(context.apiToken);
    } catch (_) {}
  }

  try {
    tooltipProvider.clearTooltipViewDate();
  } catch (_) {}

  sessionProvider.clearSessionInfo().then(
    (isCleared) {
      if (context.mounted) {
        context.goNamed(Routes.login);
      }
    },
  );
}
