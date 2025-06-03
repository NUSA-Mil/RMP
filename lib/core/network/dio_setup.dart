import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/api_constants.dart';
import 'package:flutter_application_1/core/network/dio_interceptors.dart';

Dio setupDio() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.addAll([AppInterceptors(), prettyDioLogger]);
  return dio;
}