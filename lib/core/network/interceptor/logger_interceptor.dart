import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// [LoggerInterceptor] is a class that intercepts requests and responses and logs them to the console.
/// It takes a [Logger] object as a parameter and uses it to log the requests and responses.
/// Its helpful for debugging and testing.
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
  ));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final options = err.requestOptions;
      final requestPath = '${options.baseUrl}${options.path}';
      logger.e(
          '❌ ERROR during ${options.method} => $requestPath\nMessage: ${err.message}\nError Body: ${_shorten(err.response?.data)}');
    }
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      final requestPath = '${options.baseUrl}${options.path}';
      logger.i(
          '🔼 ${options.method} request => $requestPath\b\nparams: ${(options.data as FormData?)?.fields.map((e) => '${e.key}: ${e.value}').join('\n')}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      logger.i(
          '✅ Response [${response.statusCode}] => ${response.requestOptions.uri}\nResponse Body: ${_shorten(response.data)}');
    }
    return super.onResponse(response, handler);
  }

  /// Utility: Truncate long bodies or map them nicely
  dynamic _shorten(dynamic data, {int max = 500}) {
    final str = data.toString();
    return str.length > max ? '${str.substring(0, max)}... (truncated)' : str;
  }
}
