/*
* ui : dashboard main page, contains drawer, bottom navigation and pages
*/

import 'dart:async';

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/notification/firebase_notification_manager.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:app/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:app/feature/dashboard/presentation/provider/nav_menu_provider.dart';
import 'package:app/feature/dashboard/presentation/widget/bottom_nav_app_bar.dart';
import 'package:app/feature/dashboard/presentation/widget/emergency_page.dart';
import 'package:app/feature/home/presentation/page/home_page.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:app/shared/presentation/provider/location_provider.dart';
import 'package:app/shared/presentation/provider/session_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/helper/background_location_helper.dart';
import '../../../../core/utils/helper/location_helper.dart';
import '../../../../core/utils/helper/permission_helper.dart';
import '../../../alert_map/presentation/page/alert_map_page.dart';
import '../../../app_tour_tutorial/presentation/provider/app_tour_provider.dart';
import '../../../app_tour_tutorial/presentation/utils/dashboard_tutorial.dart';
import '../../../auth/presentation/widget/token_expire_widget.dart';
import '../../../home/presentation/provider/home_provider.dart';
import '../../../profile/presentation/page/profile/profile_page.dart';
import '../widget/app_nav_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  StreamSubscription<LatLng>? locationStream;

  Timer? _authorizationCheckTimer;

  @override
  void initState() {
    super.initState();
    toggleBackgroundTracking(context.location.hasBackgroundLocationPermission);

    // initial index of bottomNav and fetch incident list
    context.read<DashboardProvider>()
      ..setCurrentIndex(0)
      ..fetchIncidentList(token: context.apiToken);

    // initial list type as active list
    context.read<AlertListProvider>().listType = ListType.active;

    FirebaseNotificationManager.instance.messageClick();

    _initLocationStream();
    _syncCurrentLocation();



    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //showPremiumUpgradePopup(context);
      _appTourOrTutorial(context);
      _fetchDashboardAlertList();
      _checkAuthorization(context);
      _updateFirebaseDeviceToken(context);
    });
  }

  @override
  void deactivate() {
    toggleBackgroundTracking(false);
    super.deactivate();
  }

  @override
  void dispose() {
    _authorizationCheckTimer?.cancel();
    _authorizationCheckTimer = null;
    locationStream?.cancel();
    locationStream = null;

    super.dispose();
  }

  Future<void> _fetchDashboardAlertList() async {
    Future.microtask(() {
      if (mounted) {
        context
            .read<HomeProvider>()
            .getDashboardData(token: context.apiToken, userId: context.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerKey = context.read<NavMenuProvider>().drawerKey;

    return HomeBackground(
      hasBottomCurve: true,
      child: Scaffold(
        key: drawerKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.scaffoldBackgroundColorPaleMintOpacity,
        drawer: AppNavDrawer(drawerKey: drawerKey),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            Column(
              children: [
                Selector<DashboardProvider, int>(
                  selector: (_, provider) => provider.currentIndex,
                  builder: (_, value, __) => CustomAppBar(
                    title: _getDashboardTitle(context, value),
                    leading: InkWell(
                      onTap: () {
                        drawerKey.currentState?.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: AppColors.colorBlack,
                        size: Dimens.iconSize20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Selector<DashboardProvider, int>(
                    selector: (_, provider) => provider.currentIndex,
                    builder: (_, value, __) => PageView(
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      controller:
                          context.read<DashboardProvider>().pageController,
                      onPageChanged: (value) {
                        context.read<DashboardProvider>().currentIndex = value;
                      },
                      children: const [
                        HomePage(),
                        AlertMapPage(),
                        ProfilePage(),
                        EmergencyPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const BottomNavAppBar(),
          ],
        ),
      ),
    );
  }

  // get dashboard title based on index
  String _getDashboardTitle(BuildContext ctx, int index) {
    switch (index) {
      case 0:
        return ctx.language.welcome;
      case 1:
        return ctx.language.alerts;
      case 2:
        return ctx.language.profile;
      case 3:
        return ctx.language.emergencyService;
      default:
        return '';
    }
  }

  void _updateFirebaseDeviceToken(BuildContext ctx) async {
    final isNotificationIsOn = ctx.read<SettingsProvider>().isNotificationOn;

    if (isNotificationIsOn) {
      final deviceToken = await FirebaseNotificationManager.instance.getToken();
      if (deviceToken == null) {
        return;
      }
      if (!ctx.mounted) {
        return;
      }

      // check if device token is already updated with remote
      final savedDeviceToken = ctx.read<SessionProvider>().getFcmToken();
      if (deviceToken == savedDeviceToken) {
        return;
      }

      // check if token is updated in remote or not
      final isRemoteTokenUpdated = await ctx
          .read<DashboardProvider>()
          .updateDeviceToken(ctx.userId, ctx.apiToken,
              deviceToken: deviceToken);

      if (!ctx.mounted) {
        return;
      }

      if (isRemoteTokenUpdated) {
        ctx.read<SessionProvider>().saveFcmToken(deviceToken);
      }
    } else {
      ctx.read<SessionProvider>().deleteNotificationToken();
    }
  }

  // initialize location stream
  void _initLocationStream() async {
    try {
      final hasPermission = await PermissionHelper.hasLocationPermission;
      if (!hasPermission || !mounted) {
        return;
      }
      locationStream ??=
          context.location.locationStream?.listen(_syncLastLocation);
    } catch (_) {}
  }

  // sync current location
  void _syncCurrentLocation() async {
    if (!await PermissionHelper.isLocationServiceEnabled()) {
      return;
    }
    if (!await PermissionHelper.hasLocationPermission) {
      return;
    }
    if (!mounted || !context.isLoggedIn) {
      return;
    }

    final currentLatLng = await context.location.getCurrentLatLng;
    if (currentLatLng != null) {
      _syncLastLocation(currentLatLng);
    }
  }

  // sync last location
  bool updateLocationOnce = false;

  void _syncLastLocation(LatLng currentLatLng) async {
    if (!mounted || !context.isLoggedIn) {
      return;
    }
    final locationProvider = context.location;
    final userId = context.userId;
    final token = context.apiToken;

    if (!updateLocationOnce) {
      _updateToRemoteAndLocal(locationProvider,
          userId: userId, token: token, latLng: currentLatLng);
      updateLocationOnce = true;
    } else {
      final lastSavedLocation = context.lastSavedLocationLatLng;
      final distanceUpdatedFromLastTime = LocationHelper.getDistanceInMeter(
          from: lastSavedLocation, to: currentLatLng);
      if (distanceUpdatedFromLastTime >=
          AppConstants.minimumDistanceToUpdateInMeter) {
        _updateToRemoteAndLocal(locationProvider,
            userId: userId, token: token, latLng: currentLatLng);
      }
    }
  }

  // update location in local and remote
  bool isLocationUpdating = false;

  void _updateToRemoteAndLocal(LocationProvider locationProvider,
      {required int userId,
      required String token,
      required LatLng latLng}) async {
    if (isLocationUpdating) return;
    try {
      isLocationUpdating = true;
      final isRemoteUpdated = await locationProvider.updateUserLocation(
          userId: userId,
          apiToken: token,
          latitude: latLng.latitude,
          longitude: latLng.longitude);
      if (isRemoteUpdated) {
        await locationProvider.saveLastLocation(
            latitude: latLng.latitude, longitude: latLng.longitude);
      }
    } finally {
      isLocationUpdating = false;
    }
  }

  //check authorization immediately and every 5 minutes
  void _checkAuthorization(BuildContext context) async {
    if (context.mounted == false) return;
    checkAuthorization(context);
    _authorizationCheckTimer ??=
        Timer.periodic(const Duration(minutes: 5), (_) {
      if (!context.mounted) return;
      checkAuthorization(context);
    });
  }

  void _appTourOrTutorial(BuildContext context) {
    final tourProvider = Provider.of<AppTourProvider>(context, listen: false);
    if (tourProvider.isAppTourCompleted) return;
    createTutorial(context);
    Future.microtask(
      () {
        if (!context.mounted) return;
        tutorialCoachMark?.show(context: context);
      },
    );
  }
}
