import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:passwords_application/Core/Services/EncryptService/EncryptService.dart';
import 'package:passwords_application/Features/StorageService/Services/StorageService.dart';

class StorageRepository {
  static Future<void> savePasswords({
    required List<Map<String, String>> passwords,
  }) async {
    final List<Map<String, String>> encrypt = [];
    for (final password in passwords) {
      final SecretBox encryptedPassword = await EncryptService.encrypt(
        password["value"]!,
      );

      final cipherText = base64Encode(encryptedPassword.cipherText);
      final nonce = base64Encode(encryptedPassword.nonce);
      final mac = base64Encode(encryptedPassword.mac.bytes);

      encrypt.add({
        "name": password["name"]!,
        "ciphertext": cipherText,
        "nonce": nonce,
        "mac": mac,
      });
    }
    await StorageService.saveFile(jsonEncode(encrypt));
  }

  static Future<List<Map<String, String>>> getPasswords() async {
    final List<Map<String, dynamic>> obtainedPasswords = [];
    final String data = await StorageService.getFile();
    if (data != "") {
      final List<Map<String, dynamic>> passwords = (await jsonDecode(
        data,
      ) as List).map((e) => e as Map<String, dynamic>).toList();
      for (final password in passwords) {
        final cipherText = base64Decode(password["ciphertext"]!);
        final nonce = base64Decode(password["nonce"]!);
        final mac = Mac(base64Decode(password["mac"]!));

        final SecretBox secretBox = SecretBox(
          cipherText,
          nonce: nonce,
          mac: mac,
        );
        final decode = await EncryptService.decrypt(secretBox);
        obtainedPasswords.add({"name": password["name"], "value": decode});
      }
      final List<Map<String, String>> obtained = obtainedPasswords
          .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
          .toList();

      return obtained;
    } else {
      return [];
    }
  }
}
