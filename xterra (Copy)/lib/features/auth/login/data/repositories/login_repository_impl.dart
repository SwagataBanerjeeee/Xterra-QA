import '../../../../../core/storage/hive_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource remoteDatasource;
  final HiveService hiveService;

  const LoginRepositoryImpl({
    required this.remoteDatasource,
    required this.hiveService,
  });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDatasource.login(email: email, password: password);
    await hiveService.saveAccessToken(user.accessToken);
    await hiveService.saveRefreshToken(user.refreshToken);
    return user;
  }

  @override
  Future<void> sendLoginOtp({required String phone}) =>
      remoteDatasource.sendLoginOtp(phone: phone);

  @override
  Future<UserEntity> verifyLoginOtp({
    required String phone,
    required String otp,
  }) async {
    final user = await remoteDatasource.verifyLoginOtp(phone: phone, otp: otp);
    await hiveService.saveAccessToken(user.accessToken);
    await hiveService.saveRefreshToken(user.refreshToken);
    return user;
  }

  @override
  Future<void> logout() async {
    await hiveService.clearTokens();
    await hiveService.clearCache();
  }

  @override
  Future<bool> isLoggedIn() async {
    return hiveService.getAccessToken() != null;
  }
}
