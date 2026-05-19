import '../../domain/repositories/sign_up_repository.dart';
import '../datasources/sign_up_remote_datasource.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDatasource remoteDatasource;
  const SignUpRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> sendOtp({required String phone}) =>
      remoteDatasource.sendOtp(phone: phone);

  @override
  Future<void> verifyOtp({required String phone, required String otp}) =>
      remoteDatasource.verifyOtp(phone: phone, otp: otp);

  @override
  Future<void> createAccount({
    required String name,
    required String phone,
    required String password,
  }) => remoteDatasource.createAccount(name: name, phone: phone, password: password);
}
