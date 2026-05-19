import 'package:flutter/foundation.dart';
import '../../domain/usecases/create_account_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpProvider extends ChangeNotifier {
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final CreateAccountUsecase createAccountUsecase;

  SignUpProvider({
    required this.sendOtpUsecase,
    required this.verifyOtpUsecase,
    required this.createAccountUsecase,
  });

  SignUpStatus _status = SignUpStatus.initial;
  String? _error;
  String _name = '';
  String _phone = '';

  SignUpStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == SignUpStatus.loading;
  String get name => _name;
  String get phone => _phone;

  Future<void> sendOtp({required String name, required String phone}) async {
    _name = name;
    _phone = phone;
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await sendOtpUsecase(phone: phone);
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(_friendlyError(e));
    // }
  }

  Future<void> verifyOtp({required String otp}) async {
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await verifyOtpUsecase(phone: _phone, otp: otp);
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(_friendlyError(e));
    // }
  }

  Future<void> createAccount({required String password}) async {
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await createAccountUsecase(
    //     name: _name,
    //     phone: _phone,
    //     password: password,
    //   );
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(_friendlyError(e));
    // }
  }

  void reset() {
    _status = SignUpStatus.initial;
    _error = null;
    _name = '';
    _phone = '';
    notifyListeners();
  }

  void resetError() {
    _error = null;
    if (_status == SignUpStatus.failure) _status = SignUpStatus.initial;
    notifyListeners();
  }

  void _setLoading() {
    _status = SignUpStatus.loading;
    _error = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = SignUpStatus.success;
    notifyListeners();
  }

  void _setFailure(String message) {
    _error = message;
    _status = SignUpStatus.failure;
    notifyListeners();
  }

  String _friendlyError(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('socketexception') || msg.contains('network')) {
      return 'No internet connection.';
    }
    if (msg.contains('400'))
      return 'Invalid request. Please check your details.';
    if (msg.contains('409')) return 'This phone number is already registered.';
    return 'Something went wrong. Please try again.';
  }
}
