import '../repositories/register_repository.dart';

class SubmitBankUsecase {
  final RegisterRepository repository;
  const SubmitBankUsecase({required this.repository});

  Future<void> call({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  }) =>
      repository.submitBankDetails(
        accountHolderName: accountHolderName,
        bankName: bankName,
        ifscCode: ifscCode,
        accountNumber: accountNumber,
      );
}
