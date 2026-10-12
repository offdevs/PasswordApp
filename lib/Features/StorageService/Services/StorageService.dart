import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  static Directory? directory;
  static String? path;
  static final String archiveName = "passwords.json";

  static Future<void> init() async {
    directory = await getApplicationSupportDirectory();
    path = directory!.path;
    directory = null;
  }

  static Future<String> getFile() async {
    final File file = File("$path/$archiveName");
    if (await file.exists()) {
      final fileReaded = await file.readAsString();
      return fileReaded;
    } else {
      return "";
    }
  }

  static Future<void> saveFile(String data) async {
    final File file = File("$path/$archiveName");

    await file.writeAsString(data);
  }

  static Future<void> deleteFile() async {
    final File file = File("$path/$archiveName");
    if (await file.exists()) {
      await file.delete();
    }
  }
}
