import 'dart:convert';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:sync_mobile/core/storage/secure_storage_service.dart';

class HiveStorage {
  HiveStorage._internal();
  static final HiveStorage _instance = HiveStorage._internal();
  factory HiveStorage() => _instance;

  final SecureStorageService _storageService = SecureStorageService();
  static const _keyName = "hive_encryption_key";

  Future<void> initAndOpenAllBoxes() async {
    await Hive.initFlutter();
    final containsKey = await _storageService.contains(key: _keyName);
    if (!containsKey) {
      final newKey = Hive.generateSecureKey();
      _storageService.save(key: _keyName, value: base64Url.encode(newKey));
    }
    final key = await _storageService.get(key: _keyName);
    await Hive.openBox(
      "auth_box",
      encryptionCipher: HiveAesCipher(base64Url.decode(key!)),
    );
  }

  Future<void> save({
    required String boxName,
    required String keyName,
    required dynamic data,
  }) async {
    final box = Hive.box(boxName);
    return await box.put(keyName, data);
  }

  dynamic get({required String boxName, required String keyName}) {
    final box = Hive.box(boxName);
    return box.get(keyName);
  }

  Future<void> delete({required String boxName, required keyName}) async {
    final box = Hive.box(boxName);
    return await box.delete(keyName);
  }
}
