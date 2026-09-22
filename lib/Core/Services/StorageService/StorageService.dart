import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class StorageService {
  static late Directory? directory;
  static late String path;
  static final String archiveName = "passwords.json";

  static Future<void> init() async {
    directory = await getApplicationSupportDirectory();
    path = directory!.path;
    directory = null;
  }

  static Future<File> getFile() async {
    final File file = File("$path/$archiveName");
    if (await file.exists()) {
      return file;
    } else {
      throw Exception("Archive not exist or uri invalid.");
    }
  }

  static Future<void> saveFile(Map<String, dynamic> rawData) async {
    final File file = File("$path/$archiveName");

    final String data = jsonEncode(rawData);

    await file.writeAsString(data);
  }

  static Future<void> deleteFile() async {
    final File file = File("$path/$archiveName");
    if (await file.exists()) {
      await file.delete();
    }
  }
}
