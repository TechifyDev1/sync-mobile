class ApiEndpoints {
  static const baseUrl = "http://192.168.0.164:8080/api";
  static const authBaseUrl = "/auth";
  static final requestOtp = "$authBaseUrl/request-otp";
  static final verifyOtp = "$authBaseUrl/authenticate";
  static final refreshTokens = "$authBaseUrl/refresh";
}
