import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class LoginRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<void> sendLoginOtp({required String phone});
  Future<UserModel> verifyLoginOtp({required String phone, required String otp});
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final Dio dio;

  const LoginRemoteDatasourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> sendLoginOtp({required String phone}) async {
    await dio.post('/auth/login/send-otp', data: {'phone': phone});
  }

  @override
  Future<UserModel> verifyLoginOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await dio.post(
      '/auth/login/verify-otp',
      data: {'phone': phone, 'otp': otp},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
