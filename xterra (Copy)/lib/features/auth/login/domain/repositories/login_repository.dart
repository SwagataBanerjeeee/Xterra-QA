import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<UserEntity> login({required String email, required String password});
  Future<void> sendLoginOtp({required String phone});
  Future<UserEntity> verifyLoginOtp({required String phone, required String otp});
  Future<void> logout();
  Future<bool> isLoggedIn();
}
