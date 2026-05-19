import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/send_login_otp_usecase.dart';
import '../../domain/usecases/verify_login_otp_usecase.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SendLoginOtpUsecase sendLoginOtpUsecase;
  final VerifyLoginOtpUsecase verifyLoginOtpUsecase;

  LoginProvider({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.sendLoginOtpUsecase,
    required this.verifyLoginOtpUsecase,
  });

  LoginStatus _status = LoginStatus.initial;
  UserEntity? _user;
  String? _error;
  String _phone = '';

  LoginStatus get status => _status;
  UserEntity? get user => _user;
  String? get error => _error;
  String get phone => _phone;
  bool get isLoading => _status == LoginStatus.loading;

  Future<void> sendOtp({required String phone}) async {
    _phone = phone;
    _setLoading();
    await Future.delayed(Duration(seconds: 1), () {
      _setSuccess();
    });
    // try {
    //   await sendLoginOtpUsecase(phone: phone);
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
    //   _user = await verifyLoginOtpUsecase(phone: _phone, otp: otp);
    //   _setSuccess();
    // } catch (e) {
    //   _setFailure(_friendlyError(e));
    // }
  }

  Future<void> login({required String email, required String password}) async {
    _setLoading();
    try {
      _user = await loginUsecase(email: email, password: password);
      _setSuccess();
    } catch (e) {
      _setFailure(_friendlyError(e));
    }
  }

  Future<void> logout() async {
    await logoutUsecase();
    _user = null;
    _status = LoginStatus.initial;
    notifyListeners();
  }

  void resetError() {
    _error = null;
    if (_status == LoginStatus.failure) _status = LoginStatus.initial;
    notifyListeners();
  }

  void _setLoading() {
    _status = LoginStatus.loading;
    _error = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = LoginStatus.success;
    notifyListeners();
  }

  void _setFailure(String error) {
    _status = LoginStatus.failure;
    _error = error;
    notifyListeners();
  }

  String _friendlyError(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('401') || msg.contains('unauthorized')) {
      return 'Invalid credentials.';
    }
    if (msg.contains('socketexception') || msg.contains('network')) {
      return 'No internet connection.';
    }
    return 'Something went wrong. Please try again.';
  }
}
