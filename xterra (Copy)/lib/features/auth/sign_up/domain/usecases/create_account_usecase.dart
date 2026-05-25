import '../repositories/sign_up_repository.dart';

class CreateAccountUsecase {
  final SignUpRepository repository;
  const CreateAccountUsecase({required this.repository});

  Future<void> call({
    required String name,
    required String phone,
    required String password,
  }) => repository.createAccount(name: name, phone: phone, password: password);
}
