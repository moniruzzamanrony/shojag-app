import 'dart:io';

/// [MyHttpOverrides] is a class that overrides the default HTTP client
/// It is used to ignore SSL certificates
///
/// [Caution]: This is not secure
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
