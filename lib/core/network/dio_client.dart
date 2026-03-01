import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_constants.dart';

Dio createDio({
  required Future<String?> Function() getAccessToken,
  required Future<bool> Function() refreshToken,
  required Future<void> Function() logout,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getAccessToken();
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await refreshToken();
          if (refreshed) {
            final retry = await dio.fetch(error.requestOptions);
            return handler.resolve(retry);
          }
          await logout();
        }
        handler.next(error);
      },
    ),
  );

  dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
  return dio;
}
