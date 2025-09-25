import 'package:app/core/utils/helper/network_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// [ErrorReporting] is a class that handles crash and error reports.
/// It uses Firebase Crashlytics to send reports to the Firebase console.

class ErrorReporting {
  static void handleCrashAndErrorReports() {
    FlutterError.onError = (errorDetails) async {
      await _safeRecordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      _safeRecordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> _safeRecordFlutterFatalError(
      FlutterErrorDetails details) async {
    try {
      if (await isNetworkAvailable) {
        await FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      }
    } catch (e) {
      debugPrint("Crashlytics error (recordFlutterFatalError): $e");
    }
  }

  static Future<void> _safeRecordError(Object error, StackTrace stackTrace,
      {bool fatal = false}) async {
    try {
      if (await isNetworkAvailable) {
        await FirebaseCrashlytics.instance.recordError(
          error,
          _trimStack(stackTrace),
          fatal: fatal,
        );
      }
    } catch (e) {
      debugPrint("Crashlytics error (recordError): $e");
    }
  }

  static StackTrace _trimStack(StackTrace stack) {
    final lines = stack.toString().split('\n');
    final trimmed = lines.take(40).join('\n');
    return StackTrace.fromString(trimmed);
  }
}
