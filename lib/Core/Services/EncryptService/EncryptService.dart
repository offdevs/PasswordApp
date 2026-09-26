import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:passwords_application/Core/Data/AppData.dart';

class EncryptService {
  static Future<SecretBox> encrypt(String text) async {
    final algorithm = AesGcm.with256bits();
    final data = utf8.encode(text);

    return algorithm.encrypt(data, secretKey: AppData.secretKey!);
  }

  static Future<String> decrypt(SecretBox secret) async {
    final algorithm = AesGcm.with256bits();
    final data = await algorithm.decrypt(secret, secretKey: AppData.secretKey!);

    return utf8.decode(data);
  }
}
