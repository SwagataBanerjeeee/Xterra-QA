abstract class SignUpRepository {
  Future<void> sendOtp({required String phone});
  Future<void> verifyOtp({required String phone, required String otp});
  Future<void> createAccount({
    required String name,
    required String phone,
    required String password,
  });
}
