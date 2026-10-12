import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';

class PasswordEditWidgetDialog extends StatefulWidget {
  final String id;
  final String name;
  final String value;
  final VoidCallback onSaved;
  const new({
    super.key,
    required this.id,
    required this.name,
    required this.value,
    required this.onSaved,
  });

  @override
  State<PasswordEditWidgetDialog> createState() =>
      _PasswordEditWidgetDialogState();
}

class _PasswordEditWidgetDialogState extends State<PasswordEditWidgetDialog> {
  late double lengthPassword;
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    lengthPassword = widget.value.length.toDouble();
    name.text = widget.name;
    password.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 375,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        label: Text("Cancelar"),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          await StorageRepository.editPassword(
                            id: widget.id,
                            name: name.text,
                            value: password.text,
                          );
                          widget.onSaved();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        label: Text("Guardar"),
                        icon: Icon(Icons.save),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
