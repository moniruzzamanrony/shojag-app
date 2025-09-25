// this file [app_router.dart] is used for routing in this application.
// this file is used for routing in this application.

import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/enums/notification_type.dart';
import 'package:app/feature/alert/presentation/create/page/alert_add_page.dart';
import 'package:app/feature/alert/presentation/details/page/alert_details_page.dart';
import 'package:app/feature/alert/presentation/details/page/alert_details_page_from_notification.dart';
import 'package:app/feature/alert/presentation/list/page/alert_list_page.dart';
import 'package:app/feature/alert/presentation/update/page/alert_update_page.dart';
import 'package:app/feature/alert/presentation/update/provider/alert_update_provider.dart';
import 'package:app/feature/auth/presentation/page/forgot_password/forgot_password_input_page.dart';
import 'package:app/feature/auth/presentation/page/forgot_password/otp_verify_page.dart';
import 'package:app/feature/auth/presentation/page/forgot_password/reset_password_page.dart';
import 'package:app/feature/auth/presentation/page/getting_started_page.dart';
import 'package:app/feature/auth/presentation/page/login/login_page.dart';
import 'package:app/feature/auth/presentation/page/registration/registration_page.dart';
import 'package:app/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:app/feature/feedback/presentation/page/feedback_page.dart';
import 'package:app/feature/fnf/presentation/search/page/fnf_search_page.dart';
import 'package:app/feature/premium/presentation/page/package_selection_page.dart';
import 'package:app/feature/premium/presentation/page/subscription_home_page.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/feature/settings/presentation/page/change_password_page.dart';
import 'package:app/feature/settings/presentation/page/location_settings_page.dart';
import 'package:app/feature/settings/presentation/page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../feature/alert/domain/entity/alert_entity.dart';
import '../../../feature/alert/presentation/details/provider/alert_details_provider.dart';
import '../../../feature/consent/presentation/page/location_consent_screen.dart';
import '../../../feature/fnf/presentation/home/page/fnf_home_page.dart';
import '../../../shared/presentation/provider/session_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// This [AppRouter] is used for routing in this application.
/// It has the configuration for all the routes in the application.
///
/// For auth middleware, it redirects the user to the login page if not logged in.
///
/// It has custom transitions for all the routes.
abstract class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/dashboard',
    redirect: (context, state) {
      if (state.fullPath?.contains('/dashboard') ?? false) {
        final isLoggedIn =
            Provider.of<SessionProvider>(context, listen: false).isLoggedIn;

        if (!isLoggedIn) {
          return '/getting-started-page';
        }
      }

      if (state.fullPath?.contains('fnf-home') ?? false) {
        final isValidPremium =
            Provider.of<PremiumProvider>(context, listen: false)
                .premiumEntity
                .isValidPremiumUser;
        if (!isValidPremium) {
          return '/dashboard';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
          name: Routes.dashboard,
          path: '/dashboard',
          pageBuilder: (context, state) => const CustomTransitionPage(
                child: DashboardPage(),
                transitionsBuilder: _slideFromRightTransition,
              ),
          routes: [
            GoRoute(
              name: Routes.alertAdd,
              path: 'alert-add',
              pageBuilder: (_, state) {
                final type = state.extra as AlertType;
                return CustomTransitionPage(
                  child: AlertAddPage(type: type),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
                name: Routes.alertDetails,
                path: 'alert-details',
                pageBuilder: (context, state) {
                  context.read<AlertDetailsProvider>().currentAlert =
                      state.extra as AlertEntity;
                  return const CustomTransitionPage(
                    child: AlertDetailsPage(),
                    transitionsBuilder: _slideFromRightTransition,
                  );
                },
                routes: [
                  GoRoute(
                    name: Routes.alertUpdate,
                    path: 'alert-update',
                    pageBuilder: (_, state) {
                      state.extra as AlertEntity;
                      return CustomTransitionPage(
                        child: ChangeNotifierProvider(
                            create: (context) =>
                                AlertUpdateProvider(state.extra as AlertEntity),
                            child: const AlertUpdatePage()),
                        transitionsBuilder: _slideFromRightTransition,
                      );
                    },
                  ),
                ]),
            GoRoute(
              name: Routes.alertDetailsFromNotification,
              path: 'alert-details-from-notification',
              pageBuilder: (context, state) {
                final alertId = state.extra as int;
                return CustomTransitionPage(
                  child: AlertDetailsPageFromNotification(alertId: alertId),
                  transitionsBuilder: _fadeInTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.alertList,
              path: 'alert-list',
              pageBuilder: (_, __) {
                return const CustomTransitionPage(
                  child: AlertListPage(),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
                name: Routes.settings,
                path: 'settings',
                pageBuilder: (_, __) {
                  return const CustomTransitionPage(
                    child: SettingsPage(),
                    transitionsBuilder: _slideFromRightTransition,
                  );
                },
                routes: [
                  GoRoute(
                    name: Routes.changePassword,
                    path: 'change-password',
                    pageBuilder: (_, __) => const CustomTransitionPage(
                      child: ChangePasswordPage(),
                      transitionsBuilder: _slideFromRightTransition,
                    ),
                  ),
                ]),
            GoRoute(
              name: Routes.subscriptionHome,
              path: 'subscription-home',
              pageBuilder: (_, __) {
                return const CustomTransitionPage(
                  child: SubscriptionHomePage(),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.locationSettings,
              path: 'location-settings',
              pageBuilder: (_, __) {
                return const CustomTransitionPage(
                  child: LocationSettingsPage(),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.fnfSearch,
              path: 'fnf-search',
              pageBuilder: (context, state) {
                return const CustomTransitionPage(
                  child: FnfSearchPage(),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.fnfHome,
              path: 'fnf-home',
              pageBuilder: (context, state) {
                Map<String, dynamic> data = {};
                if (state.extra != null) {
                  data = state.extra as Map<String, dynamic>;
                }
                final notificationType =
                    data['notification_type'] as NotificationType? ??
                        NotificationType.none;
                final fnfId = data['fnf_id'] as int?;
                final isFromNotification =
                    data['is_from_notification'] as bool? ?? false;

                return CustomTransitionPage(
                  child: Material(
                      color: Colors.white,
                      child: FnfHomePage(
                        fromNotification: isFromNotification,
                        notificationType: notificationType,
                        fnfId: fnfId,
                      )),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.feedback,
              path: 'feedback',
              pageBuilder: (context, state) {
                return const CustomTransitionPage(
                  child: FeedbackPage(),
                  transitionsBuilder: _slideFromRightTransition,
                );
              },
            ),
            GoRoute(
              name: Routes.premiumPackageSelection,
              path: 'premium_package_selection',
              pageBuilder: (context, state) {
                return const CustomTransitionPage(
                  child: PackageSelectionPage(),
                  transitionsBuilder: _slideFromBottomTransition,
                );
              },
            ),
          ]),
      GoRoute(
        name: Routes.gettingStarted,
        path: '/getting-started-page',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: GettingStartedPage(),
          transitionsBuilder: _fadeInTransition,
        ),
      ),
      GoRoute(
        name: Routes.locationServiceUsageConsent,
        path: '/location-service-usage-consent',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: LocationConsentScreen(),
          transitionsBuilder: _noTransition,
        ),
      ),
      GoRoute(
        name: Routes.login,
        path: '/login',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: LoginPage(),
          transitionsBuilder: _slideFromRightTransition,
        ),
      ),
      GoRoute(
        name: Routes.registration,
        path: '/registration',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: RegistrationPage(),
          transitionsBuilder: _slideFromRightTransition,
        ),
      ),
      GoRoute(
        name: Routes.forgotPassword,
        path: '/forgot-password',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: ForgotPasswordInputPage(),
          transitionsBuilder: _slideFromRightTransition,
        ),
      ),
      GoRoute(
        name: Routes.otpVerify,
        path: '/otp-verify',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: OtpVerifyPage(),
          transitionsBuilder: _slideFromRightTransition,
        ),
      ),
      GoRoute(
        name: Routes.resetPassword,
        path: '/reset-password',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: ResetPasswordPage(),
          transitionsBuilder: _slideFromRightTransition,
        ),
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text('Error: ${state.error?.message}'),
          ),
        ),
      );
    },
  );

  static Widget _fadeInTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget _noTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  static Widget _slideFromBottomTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.linear;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget _slideFromRightTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  AppRouter._();
}
