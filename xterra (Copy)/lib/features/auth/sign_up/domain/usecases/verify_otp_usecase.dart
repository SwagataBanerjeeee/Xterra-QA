import '../repositories/sign_up_repository.dart';

class VerifyOtpUsecase {
  final SignUpRepository repository;
  const VerifyOtpUsecase({required this.repository});

  Future<void> call({required String phone, required String otp}) =>
      repository.verifyOtp(phone: phone, otp: otp);
}
