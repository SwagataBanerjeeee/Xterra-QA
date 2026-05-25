import '../repositories/sign_up_repository.dart';

class SendOtpUsecase {
  final SignUpRepository repository;
  const SendOtpUsecase({required this.repository});

  Future<void> call({required String phone}) =>
      repository.sendOtp(phone: phone);
}
