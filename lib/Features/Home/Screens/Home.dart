import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';
import 'package:passwords_application/Features/Home/Widgets/PasswordWidget.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>>? passwords;

  Future<void> getPasswords() async {
    final List<Map<String, String>> obtainedPasswords =
        await StorageRepository.getPasswords();

    setState(() {
      passwords = obtainedPasswords;
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
        onPressed: () async {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: passwords?.length ?? 0,
        itemBuilder: (_, index) {
          final password = passwords![index];
          return PasswordWidget(
            label: password["name"]!,
            value: password["value"]!,
          );
        },
      ),
    );
  }
}
