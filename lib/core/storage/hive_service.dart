import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _tokenBox = 'token_box';
  static const String _cacheBox = 'cache_box';

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_tokenBox);
    await Hive.openBox<String>(_cacheBox);
  }

  // ── Token helpers ─────────────────────────────────────────────
  Future<void> saveAccessToken(String token) =>
      Hive.box<String>(_tokenBox).put(_accessTokenKey, token);

  String? getAccessToken() =>
      Hive.box<String>(_tokenBox).get(_accessTokenKey);

  Future<void> saveRefreshToken(String token) =>
      Hive.box<String>(_tokenBox).put(_refreshTokenKey, token);

  String? getRefreshToken() =>
      Hive.box<String>(_tokenBox).get(_refreshTokenKey);

  Future<void> clearTokens() => Hive.box<String>(_tokenBox).clear();

  // ── Cache helpers ─────────────────────────────────────────────
  Future<void> cacheData(String key, String value) =>
      Hive.box<String>(_cacheBox).put(key, value);

  String? getCachedData(String key) =>
      Hive.box<String>(_cacheBox).get(key);

  Future<void> clearCache() => Hive.box<String>(_cacheBox).clear();
}
