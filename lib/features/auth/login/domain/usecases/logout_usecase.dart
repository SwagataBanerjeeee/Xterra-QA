import '../repositories/login_repository.dart';

class LogoutUsecase {
  final LoginRepository repository;

  const LogoutUsecase({required this.repository});

  Future<void> call() => repository.logout();
}
