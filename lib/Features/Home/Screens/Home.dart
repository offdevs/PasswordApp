import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Features/Home/Widgets/PasswordWidget.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(PasswordGenerator.generate(length: 35));
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [PasswordWidget(label: "Test", value: "FAJFJ23549__@")],
      ),
    );
  }
}
