import 'dart:developer';
import 'package:apidemo/constants/constants.dart';
import 'package:apidemo/network/api_exception.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;
  final String baseUrl;
  DioClient({required this.baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseUrl: false,
        responseHeader: false,
        responseBody: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["x-api-key"] = Constants.apiKey;
          return handler.next(options);
        },
        onError: (error, handler) {
          log('❌ ERROR');
          log('Status: ${error.response?.statusCode}');
          handler.next(error);
        },
      ),
    ]);
  }

  Future<Response> get(String url) async {
    try {
      return await dio.get(url);
    } on DioException catch (e) {
      throw ApiException(handleDioError(e)).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
