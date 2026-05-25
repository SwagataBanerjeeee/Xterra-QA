import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDatasource remoteDatasource;
  const RegisterRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> submitDetails({
    required String orgName,
    required String address,
  }) =>
      remoteDatasource.submitDetails(orgName: orgName, address: address);

  @override
  Future<void> submitKyc({
    required String aadharPanPath,
    required String gstPath,
  }) =>
      remoteDatasource.submitKyc(
        aadharPanPath: aadharPanPath,
        gstPath: gstPath,
      );

  @override
  Future<void> submitBankDetails({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  }) =>
      remoteDatasource.submitBankDetails(
        accountHolderName: accountHolderName,
        bankName: bankName,
        ifscCode: ifscCode,
        accountNumber: accountNumber,
      );
}
