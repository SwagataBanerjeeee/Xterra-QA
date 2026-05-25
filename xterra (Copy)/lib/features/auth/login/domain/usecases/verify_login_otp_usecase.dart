import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

class VerifyLoginOtpUsecase {
  final LoginRepository repository;
  const VerifyLoginOtpUsecase({required this.repository});

  Future<UserEntity> call({required String phone, required String otp}) =>
      repository.verifyLoginOtp(phone: phone, otp: otp);
}
