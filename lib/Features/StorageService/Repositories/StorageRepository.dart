import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:passwords_application/Core/Services/EncryptService/EncryptService.dart';
import 'package:passwords_application/Features/StorageService/Services/StorageService.dart';
import 'package:uuid_type/uuid_type.dart';

class StorageRepository {
  static Future<void> savePassword({
    required Map<String, String> password,
  }) async {
    final List<Map<String, String>> encrypt = [];
    final data = await StorageService.getFile();
    if (data != "") {
      final passwords = jsonDecode(data);
      if (passwords != "") {
        encrypt.addAll(
          (passwords as List).map((e) {
            e as Map<String, dynamic>;
            return e.map((key, value) => MapEntry(key, value.toString()));
          }).toList(),
        );
      }
    }

    final SecretBox encryptedPassword = await EncryptService.encrypt(
      password["value"]!,
    );

    final cipherText = base64Encode(encryptedPassword.cipherText);
    final nonce = base64Encode(encryptedPassword.nonce);
    final mac = base64Encode(encryptedPassword.mac.bytes);

    encrypt.add({
      "id": RandomUuidGenerator().generate().toString(),
      "name": password["name"]!,
      "ciphertext": cipherText,
      "nonce": nonce,
      "mac": mac,
    });

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
        obtainedPasswords.add({
          "id": password["id"],
          "name": password["name"],
          "value": decode,
        });
      }
      final List<Map<String, String>> obtained = obtainedPasswords
          .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
          .toList();

      return obtained;
    } else {
      return [];
    }
  }

  static Future<void> editPassword({
    required String id,
    String name = "",
    String value = "",
  }) async {
    List<Map<String, dynamic>> passwords = [];
    final data = await StorageService.getFile();
    if (data != "") {
      final decode = jsonDecode(data);
      if (decode != "") {
        passwords.addAll(
          (decode as List).map((e) {
            e as Map<String, dynamic>;
            return e.map(((key, value) => MapEntry(key, value.toString())));
          }).toList(),
        );
      }
    }
    for (int i = 0; i < passwords.length; i++) {
      if (passwords[i]["id"]! == id) {
        final encryptPass = value != ""
            ? await EncryptService.encrypt(value)
            : "";

        final cipherText = encryptPass != ""
            ? base64Encode((encryptPass as SecretBox).cipherText)
            : "";
        final nonce = encryptPass != ""
            ? base64Encode((encryptPass as SecretBox).nonce)
            : "";
        final mac = encryptPass != ""
            ? base64Encode((encryptPass as SecretBox).mac.bytes)
            : "";

        passwords[i] = {
          "id": id,
          "name": name != "" ? name : passwords[i]["name"],
          "ciphertext": cipherText != ""
              ? cipherText
              : passwords[i]["ciphertext"],
          "nonce": nonce != "" ? nonce : passwords[i]["nonce"],
          "mac": mac != "" ? mac : passwords[i]["mac"],
        };
        await StorageService.saveFile(jsonEncode(passwords));
        break;
      }
    }
  }

  static Future<void> deletePassword({required String id}) async {
    List<Map<String, dynamic>> passwords = [];
    final data = await StorageService.getFile();
    if (data != "") {
      final decode = jsonDecode(data);
      if (decode != "") {
        passwords.addAll(
          (decode as List).map((e) {
            e as Map<String, dynamic>;
            return e.map(((key, value) => MapEntry(key, value.toString())));
          }).toList(),
        );
      }
    }

    for (int i = 0; i < passwords.length; i++) {
      if (passwords[i]["id"] == id) {
        passwords.removeAt(i);
        break;
      }
    }
    await StorageService.saveFile(jsonEncode(passwords));
  }

  static Future<void> deletePasswords() async {
    await StorageService.deleteFile();
  }
}
