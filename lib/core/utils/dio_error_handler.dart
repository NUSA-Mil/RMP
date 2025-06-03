import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';
    case DioExceptionType.sendTimeout:
      return 'Send timeout';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout';
    case DioExceptionType.badCertificate:
      return 'Bad certificate';
    case DioExceptionType.badResponse:
      return 'Bad response: ${error.response?.statusCode}';
    case DioExceptionType.cancel:
      return 'Request canceled';
    case DioExceptionType.connectionError:
      return 'Connection error';
    case DioExceptionType.unknown:
      return 'Unknown error: ${error.message}';
  }
}