class AuthService {
  Future<bool> sendOtp(String phone) async {
    // Simulate API call with delay
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
