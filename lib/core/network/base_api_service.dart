import 'dart:convert';
import 'dart:isolate';

import 'package:app/core/network/interceptor/logger_interceptor.dart';
import 'package:app/core/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../error/data_state.dart';
import '../error/exception_handler.dart';

/// [BaseApiService] is a class that provides methods to make HTTP requests to the API.
/// It handles the response and error handling.
/// [Options] can be added to the request.
/// [token] is a string that contains the token to be added to the request.
class BaseApiService {
  BaseApiService() {
    _dio = Dio(_option);
    _dio.interceptors.add(LoggerInterceptor());
  }

  final _option = BaseOptions(
    baseUrl: ApiConstants.apiBaseUrlWithHttps,
    headers: {'Content-Type': 'application/json'},
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 40),
    sendTimeout: const Duration(seconds: 30),
    followRedirects: false,
    validateStatus: (status) => status != null && status < 500,
  );

  late final Dio _dio;


  Options _optionGenerator(String? token,
      [Map<String, String> extraHeaders = const {}]) {
    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      ...extraHeaders,
    };
    return Options(headers: headers);
  }

  bool _isSuccess(Response response) {
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        response.data != null) {
      return true;
    }
    return false;
  }

  String _getErrorMessage(Response response) {
    if (response.data != null) {
      return _getMap(response.data)['message'] ?? response.data.toString();
    }
    return 'Something went wrong';
  }

  Map<String, dynamic> _getMap(dynamic data) {
    if (data == null) return {};
    return (data is Map<String, dynamic>) ? data : jsonDecode(data);
  }

  Failure _getLeft(Object e) {
    if (e is DioException) {
      return ServerFailure(ExceptionHandler.getDioError(e).msg);
    }
    return ServerFailure(e.toString());
  }

  // This method is for [POST] method to data to the API
  Future<Either<Failure, T>> post<T>(
      {required String? token,
      required String endPoint,
      required Map<String, dynamic> data,
      required T Function(Map<String, dynamic>) fromJson,
      bool useFormData = true,
      bool useIsolate = false}) async {
    try {
      final option = _optionGenerator(token);
      final payload = useFormData ? FormData.fromMap(data) : data;

      final response =
          await _dio.post(endPoint, data: payload, options: option);

      if (_isSuccess(response)) {
        final map = _getMap(response.data);
        if (useIsolate) {
          return await _parseJsonInIsolate(map, fromJson);
        }
        return Right(fromJson(map));
      } else {
        return Left(ServerFailure(_getErrorMessage(response)));
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      return Left(_getLeft(e));
    }
  }

  // This method is for [GET] method to getting data from the API
  Future<Either<Failure, T>> get<T>(
      {required String? token,
      required String endPoint,
      required T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic>? query,
      bool useIsolate = false}) async {
    try {
      final option = _optionGenerator(token);
      final response =
          await _dio.get(endPoint, options: option, queryParameters: query);
      if (_isSuccess(response)) {
        final map = _getMap(response.data);
        if (useIsolate) {
          return await _parseJsonInIsolate(map, fromJson);
        }
        return Right(fromJson(map));
      } else {
        return Left(ServerFailure(_getErrorMessage(response)));
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      return Left(_getLeft(e));
    }
  }

  // This method is for [DELETE] method to deleting data from the API
  Future<Either<Failure, T>> delete<T>(
      {required String? token,
      required String endPoint,
      required T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic>? query,
      bool useIsolate = false}) async {
    try {
      final option = _optionGenerator(token);
      final response =
          await _dio.delete(endPoint, options: option, queryParameters: query);
      if (_isSuccess(response)) {
        final map = _getMap(response.data);
        if (useIsolate) {
          return await _parseJsonInIsolate(map, fromJson);
        }
        return Right(fromJson(map));
      } else {
        return Left(ServerFailure(_getErrorMessage(response)));
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      return Left(_getLeft(e));
    }
  }

  // Top-level function for isolate-based parsing
  static Future<Either<Failure, T>> _parseJsonInIsolate<T>(
      Map<String, dynamic> data,
      T Function(Map<String, dynamic>) fromJson) async {
    final port = ReceivePort();
    await Isolate.spawn(_parseJson, [port.sendPort, data, fromJson]);

    final result = await port.first;

    if (result is T) {
      return Right(result); // Successful result
    } else if (result is Map<String, String> && result.containsKey('error')) {
      return Left(ServerFailure(result['error']!)); // Error from isolate
    } else {
      return const Left(ServerFailure('Unexpected error during JSON parsing'));
    }
  }

  // Helper method to run in isolate
  static void _parseJson(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final data = args[1] as Map<String, dynamic>;
    final fromJson = args[2] as Function(Map<String, dynamic>);
    try {
      final result = fromJson(data);
      sendPort.send(result);
    } catch (e, stackTrace) {
      sendPort.send({
        'error': 'Error during JSON parsing: $e',
        'stackTrace': stackTrace.toString()
      });
    }
  }
}
