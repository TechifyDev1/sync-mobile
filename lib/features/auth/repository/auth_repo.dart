import 'package:sync_mobile/core/network/api_endpoints.dart';
import 'package:sync_mobile/core/network/dio_client.dart';
import 'package:sync_mobile/core/storage/hive/hive_storage.dart';
import 'package:sync_mobile/core/storage/hive/models/tokens.dart';
import 'package:sync_mobile/features/auth/repository/model/auth_response.dart';

class AuthRepo {
  final DioClient _dio;
  final HiveStorage _hiveStorage;
  AuthRepo._() : _dio = DioClient(), _hiveStorage = HiveStorage();
  static final AuthRepo _instance = AuthRepo._();
  factory AuthRepo() => _instance;

  Future<String> getOtp({
    required String email,
    required String phoneNumber,
  }) async {
    final res = await _dio.post(
      url: ApiEndpoints.requestOtp,
      body: {"email": email, "phoneNumber": phoneNumber},
    );
    final data = res.data as Map<String, String>;
    final parsedData = AuthResponse.fromJson(data);
    final authInfo = parsedData.getAuthInfo();
    final tokens = Tokens(
      accessToken: parsedData.accessToken,
      refreshToken: parsedData.refreshToken,
    );
    await _hiveStorage.save(
      boxName: "auth_box",
      keyName: "tokens",
      data: tokens.toJson(),
    );
    await _hiveStorage.save(
      boxName: "auth_box",
      keyName: "user_profile",
      data: authInfo.toJson(),
    );
    return authInfo.email;
  }
}
