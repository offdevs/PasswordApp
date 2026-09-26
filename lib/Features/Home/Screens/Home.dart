import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Core/Services/StorageService/StorageService.dart';
import 'package:passwords_application/Features/Home/Widgets/PasswordWidget.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>>? passwords;

  List<Map<String, dynamic>> createPasswords() {
    final List<Map<String, dynamic>> gen = [];

    for (int i = 0; i < 3; i++) {
      final Map<String, dynamic> passGen = {
        "name": "$i",
        "value": PasswordGenerator.generate(length: 32),
      };
      gen.add(passGen);
    }
    return gen;
  }

  Future<void> getPasswords() async {
    final List<Map<String, dynamic>> files = await StorageService.getFile();
    setState(() {
      passwords = files;
    });
  }

  @override
  void initState() {
    getPasswords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<Map<String, dynamic>> gen = createPasswords();
          await StorageService.saveFile(gen);
          setState(() {
            passwords = gen;
          });
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: passwords?.length ?? 0,
        itemBuilder: (_, index) {
          final password = passwords![index];
          return PasswordWidget(
            label: password["name"],
            value: password["value"],
          );
        },
      ),
    );
  }
}
