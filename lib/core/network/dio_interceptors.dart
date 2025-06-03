import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = ApiConstants.apiKey;
    super.onRequest(options, handler);
  }
}

final prettyDioLogger = PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: true,
);