import 'dart:io';
import 'dart:convert';

import 'package:passwords_application/Core/logger/AppLogger.dart';
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

  static Future<List<Map<String, dynamic>>> getFile() async {
    final File file = File("$path/$archiveName");
    final exist = await file.exists();
    AppLogger.info(exist.toString());
    AppLogger.info(file.path);
    AppLogger.info(File("$path/$file").toString());
    AppLogger.info(File("$path/$archiveName").exists().toString());
    if (await file.exists()) {
      final fileReaded = await file.readAsString();
      final data = jsonDecode(fileReaded);
      return (data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } else {
      return [];
      //throw Exception("Archive not exist or uri invalid.");
    }
  }

  static Future<void> saveFile(List<Map<String, dynamic>> rawData) async {
    final File file = File("$path/$archiveName");

    final String data = jsonEncode(rawData);

    await file.writeAsString(data);
    AppLogger.info("$path/$archiveName");
  }

  static Future<void> deleteFile() async {
    final File file = File("$path/$archiveName");
    if (await file.exists()) {
      await file.delete();
    }
  }
}
