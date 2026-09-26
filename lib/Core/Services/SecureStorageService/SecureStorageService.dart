import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cryptography/cryptography.dart';
import 'package:passwords_application/Core/Data/AppData.dart';

class SecureStorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> init() async {
    if (!await _storage.containsKey(key: "key")) {
      final algorithm = AesGcm.with256bits();
      final secretKey = await algorithm.newSecretKey();
      final bytes = await secretKey.extractBytes();
      final newKey = base64Encode(bytes);
      await _saveKey(newKey);
      _saveKeyInMemory(newKey);
    } else {
      await _saveKeyInMemory(await _getKey());
    }
  }

  static Future<void> _saveKeyInMemory(String key) async {
    final decode = base64Decode(key);
    final SecretKey secretKey = SecretKey(decode);
    AppData.secretKey = secretKey;
  }

  static Future<void> _saveKey(String key) async {
    await _storage.write(key: "key", value: key);
  }

  static Future<String> _getKey() async {
    final String key;

    if (await _storage.containsKey(key: "key")) {
      key = await _storage.read(key: "key") as String;
      return key;
    } else {
      return "";
    }
  }

  static Future<void> deleteKey() async {
    await _storage.delete(key: "key");
  }
}
