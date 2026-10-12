import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';

class PasswordCreateWidgetDialog extends StatefulWidget {
  const new({super.key});

  @override
  State<PasswordCreateWidgetDialog> createState() =>
      _PasswordCreateWidgetDialogState();
}

class _PasswordCreateWidgetDialogState
    extends State<PasswordCreateWidgetDialog> {
  double lengthPassword = 32;
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 350,
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextField(controller: name, maxLength: 16)),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: TextField(controller: password, maxLength: 128),
                  ),
                  SizedBox(width: 30),
                  IconButton.filled(
                    onPressed: () async {
                      final String passwordGen = PasswordGenerator.generate(
                        length: lengthPassword.toInt(),
                      );
                      password.text = passwordGen;
                    },
                    icon: Icon(Icons.autorenew),
                  ),
                ],
              ),
              SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: lengthPassword,
                        min: 8,
                        max: 128,
                        divisions: 120,
                        onChanged: (value) {
                          setState(() {
                            lengthPassword = value;
                          });
                          password.text = PasswordGenerator.generate(
                            length: value.toInt(),
                          );
                        },
                      ),
                    ),
                    Text(
                      lengthPassword.toInt().toString(),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
