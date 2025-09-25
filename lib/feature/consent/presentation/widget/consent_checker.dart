import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/helper/helper_functions.dart';
import '../../../../core/utils/helper/permission_helper.dart';
import 'always_location_consent_dialog.dart';
import 'location_consent_dialog.dart';

Future<bool> consentChecker(BuildContext context) async {
  // check if permission is granted
  bool hasPermission = await PermissionHelper.hasLocationPermission;

  if (!context.mounted) {
    return false;
  }
  final locationProvider = context.location;
  // check permission and enable location
  if (!hasPermission) {
    if (locationProvider.locationConsent) {
      // view consent dialog
      await showAppDialog(context, dialogWidget: const LocationConsentDialog());
    } else {
      // else navigate to consent page
      await context.pushNamed(Routes.locationServiceUsageConsent);
    }
    // check again if user grant the permission
    hasPermission = await PermissionHelper.hasLocationPermission;
  }
  return hasPermission;
}

Future<bool> alwaysPermissionChecker(BuildContext context) async {
  // check if permission is granted
  bool hasPermission = await PermissionHelper.hasAlwaysLocationPermission;
  if (!context.mounted) {
    return false;
  }
  if (!hasPermission) {
    // view always consent dialog
    await showAppDialog(context,
        dialogWidget: const AlwaysLocationConsentDialog());
    // check again if user grant the permission
    hasPermission = await PermissionHelper.hasAlwaysLocationPermission;
  }
  return hasPermission;
}
