import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._internal();
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> save({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    return await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    return await _storage.deleteAll();
  }

  Future<bool> contains({required String key}) async {
    return await _storage.containsKey(key: key);
  }
}
