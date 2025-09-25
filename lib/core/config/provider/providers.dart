// This file [providers.dart] contains all providers that are used in the app.
// Providers are used to store data/state that is used in multiple
// places in the app.

import 'package:app/feature/alert/presentation/create/provider/alert_add_provider.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:app/feature/app_tour_tutorial/presentation/provider/app_tour_provider.dart';
import 'package:app/feature/auth/presentation/provider/login_provider.dart';
import 'package:app/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:app/shared/presentation/provider/tooltip_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../feature/alert/presentation/incident_provider.dart';
import '../../../feature/alert/presentation/list/provider/list_sort_type_provider.dart';
import '../../../feature/alert_map/presentation/provider/alert_map_provider.dart';
import '../../../feature/auth/presentation/provider/auth_provider.dart';
import '../../../feature/auth/presentation/provider/forgot_password_provider.dart';
import '../../../feature/auth/presentation/provider/registration_provider.dart';
import '../../../feature/dashboard/presentation/provider/nav_menu_provider.dart';
import '../../../feature/home/presentation/provider/home_provider.dart';
import '../../../feature/premium/presentation/provider/premium_provider.dart';
import '../../../feature/settings/presentation/provider/settings_provider.dart';
import '../../../shared/presentation/provider/location_provider.dart';
import '../../../shared/presentation/provider/session_provider.dart';

abstract class AppProvider {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => SessionProvider()),
    ChangeNotifierProvider(create: (_) => PremiumProvider(), lazy: false),
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(create: (_) => LocationProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => RegistrationProvider()),
    ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => ListSortTypeProvider()),
    ChangeNotifierProvider(create: (context) => HomeProvider(context)),
    ChangeNotifierProvider(create: (_) => NavMenuProvider()),
    ChangeNotifierProvider(create: (_) => IncidentProvider()),
    ChangeNotifierProvider(create: (_) => AlertAddProvider()),
    ChangeNotifierProvider(create: (context) => AlertListProvider(context)),
    ChangeNotifierProvider(create: (_) => AlertDetailsProvider()),
    ChangeNotifierProxyProvider<LocationProvider, AlertMapProvider>(
        update: (context, locationProvider, previous) {
          final latLng = locationProvider.lastSavedLocationLatLng;
          if (previous == null) {
            return AlertMapProvider(latLng);
          }
          if (previous.center != latLng) {
            previous.center = latLng;
          }
          return previous;
        },
        create: (context) => AlertMapProvider(
            context.read<LocationProvider>().lastSavedLocationLatLng)),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    Provider(create: (_) => TooltipProvider()),
    Provider(create: (_) => AppTourProvider()),
  ];

  AppProvider._();
}
