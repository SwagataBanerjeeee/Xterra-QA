import '../repositories/register_repository.dart';

class SubmitDetailsUsecase {
  final RegisterRepository repository;
  const SubmitDetailsUsecase({required this.repository});

  Future<void> call({required String orgName, required String address}) =>
      repository.submitDetails(orgName: orgName, address: address);
}
