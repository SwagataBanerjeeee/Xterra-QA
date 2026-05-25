import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../storage/hive_service.dart';
import 'interceptors/auth_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient({required AppConfig config, required HiveService hiveService}) {
    dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(
        hiveService: hiveService,
        refreshTokenEndpoint: '/auth/refresh',
        baseUrl: config.baseUrl,
      ),
      if (!config.isProd)
        LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
