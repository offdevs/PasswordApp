import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Core/logger/AppLogger.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';

class PasswordCreateWidgetDialog extends StatefulWidget {
  const new({super.key});

  @override
  State<PasswordCreateWidgetDialog> createState() =>
      _PasswordCreateWidgetDialogState();
}

class _PasswordCreateWidgetDialogState
    extends State<PasswordCreateWidgetDialog> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Dialog(
      child: SizedBox(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [Expanded(child: TextField(controller: name))],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: password,
                      onChanged: (value) => AppLogger.info(value),
                    ),
                  ),
                  SizedBox(width: 30),
                  IconButton.filled(
                    onPressed: () async {
                      final String passwordGen = PasswordGenerator.generate(
                        length: 32,
                      );
                      password.text = passwordGen;
                    },
                    icon: Icon(Icons.autorenew),
                  ),
                ],
              ),
              SizedBox(height: 50),
              TextButton.icon(
                onPressed: () async {
                  final Map<String, String> newPassword = {
                    "name": name.text,
                    "value": password.text,
                  };
                  await StorageRepository.savePassword(password: newPassword);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                label: Text("Crear contraseña"),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
