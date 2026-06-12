class AuthInfo {
  final String email;
  final String displayName;
  final String publicKey;
  final String? profilePicUrl;
  final String? bio;
  final String phoneNumber;

  AuthInfo({
    required this.email,
    required this.displayName,
    required this.publicKey,
    this.profilePicUrl,
    this.bio,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "displayName": displayName,
      "publicKey": publicKey,
      "profilePicUrl": profilePicUrl,
      "bio": bio,
      "phoneNumber": phoneNumber,
    };
  }
}
