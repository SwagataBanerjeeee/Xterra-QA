import '../repositories/login_repository.dart';

class SendLoginOtpUsecase {
  final LoginRepository repository;
  const SendLoginOtpUsecase({required this.repository});

  Future<void> call({required String phone}) =>
      repository.sendLoginOtp(phone: phone);
}
