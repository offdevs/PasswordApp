import 'package:flutter/material.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';

class DeletePasswordsDialog extends StatefulWidget {
  final VoidCallback reloadFunc;
  const new({super.key, required this.reloadFunc});

  @override
  State<DeletePasswordsDialog> createState() => _DeletePasswordsDialogState();
}

class _DeletePasswordsDialogState extends State<DeletePasswordsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 180,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Estas seguro de que quieres borrar las contraseñas?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Este proceso es irreversible.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await StorageRepository.deletePasswords();
                      widget.reloadFunc();
                      if (context.mounted) Navigator.pop(context);
                    },
                    label: Text("Confirmar"),
                    icon: Icon(Icons.check),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (context.mounted) Navigator.pop(context);
                    },
                    label: Text("Cancelar"),
                    icon: Icon(Icons.cancel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
