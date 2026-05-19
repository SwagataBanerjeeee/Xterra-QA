abstract class RegisterRepository {
  Future<void> submitDetails({
    required String orgName,
    required String address,
  });

  Future<void> submitKyc({
    required String aadharPanPath,
    required String gstPath,
  });

  Future<void> submitBankDetails({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  });
}
