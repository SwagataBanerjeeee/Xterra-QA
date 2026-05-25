import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  const LoginUsecase({required this.repository});

  Future<UserEntity> call({
    required String email,
    required String password,
  }) =>
      repository.login(email: email, password: password);
}
