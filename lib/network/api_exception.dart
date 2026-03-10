import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

String handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';
    case DioExceptionType.receiveTimeout:
      return 'Server timeout';
    case DioExceptionType.badResponse:
      return e.response!.data["message"] ??
          e.response!.data["error"] ??
          'Server error';
    case DioExceptionType.unknown:
      return 'No internet connection';
    case DioExceptionType.connectionError:
      return 'Connection error';
    default:
      return 'Something went wrong';
  }
}
