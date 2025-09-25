import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'core/config/provider/providers.dart';
import 'core/config/router/app_router.dart';
import 'core/config/theme/app_theme.dart';
import 'core/utils/constants/app_constants.dart';
import 'feature/settings/presentation/provider/settings_provider.dart';
import 'l10n/app_localizations.dart';

/// [App] is the root widget of the app
/// It is the main entry point of the app
/// It ScreenUtilInit is used to set the design size of the app
/// and ensure that the app is responsive
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (_, child) => MultiProvider(
        providers: AppProvider.providers,
        child: const _AppConfig(),
      ),
    );
  }
}

/// [_AppConfig] is the root widget of the app
/// MaterialApp.router is used to configure the app
class _AppConfig extends StatelessWidget {
  const _AppConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      routerConfig: AppRouter.router,
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
      themeMode: ThemeMode.light,
      locale: context.watch<SettingsProvider>().locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => UpgradeAlert(
        navigatorKey: AppRouter.router.routerDelegate.navigatorKey,
        child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: child!),
      ),
    );
  }
}
