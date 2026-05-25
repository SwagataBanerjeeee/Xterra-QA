import '../repositories/register_repository.dart';

class SubmitKycUsecase {
  final RegisterRepository repository;
  const SubmitKycUsecase({required this.repository});

  Future<void> call({required String aadharPanPath, required String gstPath}) =>
      repository.submitKyc(aadharPanPath: aadharPanPath, gstPath: gstPath);
}
