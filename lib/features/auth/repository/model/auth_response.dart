import 'package:sync_mobile/features/auth/repository/model/auth_info.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String email;
  final String displayName;
  final String publicKey;
  final String? profilePicUrl;
  final String? bio;
  final String phoneNumber;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
    required this.displayName,
    required this.publicKey,
    this.profilePicUrl,
    this.bio,
    required this.phoneNumber,
  });

  factory AuthResponse.fromJson(Map<String, String> json) {
    return AuthResponse(
      accessToken: json["accessToken"]!,
      refreshToken: json["refreshToken"]!,
      email: json["email"]!,
      displayName: json["displayName"]!,
      publicKey: json["publicKey"]!,
      profilePicUrl: json["profilePicUrl"],
      bio: json["about"],
      phoneNumber: json["phoneNumber"]!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "email": email,
      "displayName": displayName,
      "publicKey": publicKey,
      "profilePicUrl": profilePicUrl,
      "about": bio,
      "phoneNumber": phoneNumber,
    };
  }

  AuthInfo getAuthInfo() {
    return AuthInfo(
      email: email,
      displayName: displayName,
      publicKey: publicKey,
      profilePicUrl: profilePicUrl,
      bio: bio,
      phoneNumber: phoneNumber,
    );
  }
}
