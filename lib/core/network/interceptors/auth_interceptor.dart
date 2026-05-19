import 'package:dio/dio.dart';
import '../../storage/hive_service.dart';

class AuthInterceptor extends Interceptor {
  final HiveService hiveService;
  final String refreshTokenEndpoint;
  final String baseUrl;

  bool _isRefreshing = false;
  final List<_PendingRequest> _pending = [];

  AuthInterceptor({
    required this.hiveService,
    required this.refreshTokenEndpoint,
    required this.baseUrl,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = hiveService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      _pending.add(_PendingRequest(err.requestOptions, handler));
      return;
    }

    await _refreshAndRetry(err, handler);
  }

  Future<void> _refreshAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _isRefreshing = true;
    final refreshToken = hiveService.getRefreshToken();

    if (refreshToken == null) {
      _isRefreshing = false;
      _rejectAll(err);
      handler.next(err);
      return;
    }

    try {
      // Use a fresh Dio to avoid re-entering this interceptor
      final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
      final response = await refreshDio.post(
        refreshTokenEndpoint,
        data: {'refresh_token': refreshToken},
      );

      final newAccess = response.data['access_token'] as String;
      final newRefresh = response.data['refresh_token'] as String;

      await hiveService.saveAccessToken(newAccess);
      await hiveService.saveRefreshToken(newRefresh);

      handler.resolve(await _retry(err.requestOptions, newAccess));

      for (final p in _pending) {
        try {
          p.handler.resolve(await _retry(p.options, newAccess));
        } catch (_) {
          p.handler.next(err);
        }
      }
    } catch (_) {
      await hiveService.clearTokens();
      _rejectAll(err);
      handler.next(err);
    } finally {
      _pending.clear();
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String token) {
    final retryDio = Dio(BaseOptions(baseUrl: baseUrl));
    options.headers['Authorization'] = 'Bearer $token';
    return retryDio.fetch(options);
  }

  void _rejectAll(DioException err) {
    for (final p in _pending) {
      p.handler.next(err);
    }
  }
}

class _PendingRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  _PendingRequest(this.options, this.handler);
}
