import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Services/GenPasswords/PasswordGenerator.dart';
import 'package:passwords_application/Core/Theme/AppThemes.dart';
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: name,
                        maxLength: 16,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          helperText: "Nombre de la contraseña",
                          helperStyle: TextStyle(color: AppThemes.iconAndText),
                        ),
                        style: TextStyle(color: AppThemes.iconAndText),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: password,
                        maxLength: 128,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          helperText: "Contraseña",
                          helperStyle: TextStyle(color: AppThemes.iconAndText),
                        ),
                        style: TextStyle(color: AppThemes.iconAndText),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: FloatingActionButton.small(
                      onPressed: () async {
                        final String passwordGen = PasswordGenerator.generate(
                          length: lengthPassword.toInt(),
                        );
                        password.text = passwordGen;
                      },
                      child: Icon(
                        Icons.autorenew,
                        color: AppThemes.iconAndText,
                      ),
                    ),
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
                    SizedBox(
                      height: 50,
                      width: 65,
                      child: Text(
                        lengthPassword.toInt().toString(),
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.iconAndText,
                        ),
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
                        label: Text(
                          "Cancelar",

                          style: TextStyle(
                            color: AppThemes.iconAndText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(Icons.cancel, color: Colors.red),
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
                        label: Text(
                          "Guardar",

                          style: TextStyle(
                            color: AppThemes.iconAndText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(Icons.save, color: Colors.blue),
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
