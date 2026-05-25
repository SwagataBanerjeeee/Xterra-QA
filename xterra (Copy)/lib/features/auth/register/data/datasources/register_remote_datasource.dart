import 'package:dio/dio.dart';

abstract class RegisterRemoteDatasource {
  Future<void> submitDetails({required String orgName, required String address});
  Future<void> submitKyc({required String aadharPanPath, required String gstPath});
  Future<void> submitBankDetails({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  });
}

class RegisterRemoteDatasourceImpl implements RegisterRemoteDatasource {
  final Dio dio;
  const RegisterRemoteDatasourceImpl({required this.dio});

  @override
  Future<void> submitDetails({
    required String orgName,
    required String address,
  }) async {
    await dio.post('/register/details', data: {
      'org_name': orgName,
      'address': address,
    });
  }

  @override
  Future<void> submitKyc({
    required String aadharPanPath,
    required String gstPath,
  }) async {
    final formData = FormData.fromMap({
      'aadhar_pan': await MultipartFile.fromFile(aadharPanPath),
      'gst': await MultipartFile.fromFile(gstPath),
    });
    await dio.post('/register/kyc', data: formData);
  }

  @override
  Future<void> submitBankDetails({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  }) async {
    await dio.post('/register/bank', data: {
      'account_holder_name': accountHolderName,
      'bank_name': bankName,
      'ifsc_code': ifscCode,
      'account_number': accountNumber,
    });
  }
}
