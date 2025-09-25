/*
* main function,
* where app start
* it contains dependency injection / service locator (setup)
* and app run
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/utils/resource/dependency_injection.dart';

/// [main] function where app start
/// ```
/// WidgetsFlutterBinding.ensureInitialized(); // should be called before runApp
/// DartPluginRegistrant.ensureInitialized(); // should be called before runApp
///
/// await setup();
/// runApp(const ProviderScope(child: App()));
/// ```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  //setup and dependency injection
  await setup();

  // runApp([App]) with ProviderScope[Riverpod]
  runApp(const ProviderScope(child: App()));
}

