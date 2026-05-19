import 'package:dio/dio.dart';

abstract class SignUpRemoteDatasource {
  Future<void> sendOtp({required String phone});
  Future<void> verifyOtp({required String phone, required String otp});
  Future<void> createAccount({
    required String name,
    required String phone,
    required String password,
  });
}

class SignUpRemoteDatasourceImpl implements SignUpRemoteDatasource {
  final Dio dio;
  const SignUpRemoteDatasourceImpl({required this.dio});

  @override
  Future<void> sendOtp({required String phone}) async {
    await dio.post('/auth/send-otp', data: {'phone': phone});
  }

  @override
  Future<void> verifyOtp({required String phone, required String otp}) async {
    await dio.post('/auth/verify-otp', data: {'phone': phone, 'otp': otp});
  }

  @override
  Future<void> createAccount({
    required String name,
    required String phone,
    required String password,
  }) async {
    await dio.post('/auth/register', data: {
      'name': name,
      'phone': phone,
      'password': password,
    });
  }
}
