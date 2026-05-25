import 'package:flutter/material.dart';
import '../../domain/entities/picked_file_info.dart';
import '../../domain/usecases/submit_details_usecase.dart';
import '../../domain/usecases/submit_kyc_usecase.dart';
import '../../domain/usecases/submit_bank_usecase.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterProvider extends ChangeNotifier {
  final SubmitDetailsUsecase submitDetailsUsecase;
  final SubmitKycUsecase submitKycUsecase;
  final SubmitBankUsecase submitBankUsecase;

  RegisterProvider({
    required this.submitDetailsUsecase,
    required this.submitKycUsecase,
    required this.submitBankUsecase,
  });

  RegisterStatus _status = RegisterStatus.initial;
  String? _error;

  PickedFileInfo? _aadharPanFile;
  PickedFileInfo? _gstFile;

  RegisterStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == RegisterStatus.loading;

  PickedFileInfo? get aadharPanFile => _aadharPanFile;
  PickedFileInfo? get gstFile => _gstFile;

  void setAadharPanFile(PickedFileInfo? file) {
    _aadharPanFile = file;
    notifyListeners();
  }

  void setGstFile(PickedFileInfo? file) {
    _gstFile = file;
    notifyListeners();
  }

  Future<void> submitDetails({
    required String orgName,
    required String address,
  }) async {
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await submitDetailsUsecase(orgName: orgName, address: address);
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(e.toString());
    // }
  }

  Future<void> submitKyc() async {
    if (_aadharPanFile == null || _gstFile == null) return;
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await submitKycUsecase(
    //     aadharPanPath: _aadharPanFile!.path,
    //     gstPath: _gstFile!.path,
    //   );
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(e.toString());
    // }
  }

  Future<void> submitBankDetails({
    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
  }) async {
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await submitBankUsecase(
    //     accountHolderName: accountHolderName,
    //     bankName: bankName,
    //     ifscCode: ifscCode,
    //     accountNumber: accountNumber,
    //   );
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(e.toString());
    // }
  }

  void resetError() {
    _error = null;
    _status = RegisterStatus.initial;
    notifyListeners();
  }

  void _setLoading() {
    _status = RegisterStatus.loading;
    _error = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = RegisterStatus.success;
    notifyListeners();
  }

  void _setFailure(String error) {
    _status = RegisterStatus.failure;
    _error = error;
    notifyListeners();
  }
}
