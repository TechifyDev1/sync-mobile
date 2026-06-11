class Tokens {
  final String accessToken;

  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, String> json) {
    return Tokens(
      accessToken: json["accessToken"]!,
      refreshToken: json["refreshToken"]!,
    );
  }

  Map<String, String> toJson() {
    return {"accessToken": accessToken, "refreshToken": refreshToken};
  }
}
