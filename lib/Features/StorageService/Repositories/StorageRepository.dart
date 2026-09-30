import 'dart:convert';

import 'package:passwords_application/Core/Services/EncryptService/EncryptService.dart';
import 'package:passwords_application/Features/StorageService/Services/StorageService.dart';

class StorageRepository {
  static Future<void> savePasswords({
    required List<Map<String, String>> passwords,
  }) async {
    final List<Map<String, String>> encrypted = [];
    passwords.map((e) async {
      return e.map(((key, value) async {
        return MapEntry(key, await EncryptService.encrypt(value.toString())); //FIXME: Hacer que value (secretbox) guarte todos sus datos en Base64 y modificar todo el codigo para arreglarlo
      }));
    }).toList();
  }

  static Future<List<Map<String, String>>> getPasswords() async {
    final List<Map<String, dynamic>> obtainedPasswords =
        await StorageService.getFile();
    return obtainedPasswords
        .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
        .toList();
  }
}
