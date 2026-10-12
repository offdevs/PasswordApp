import 'package:flutter/material.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';

class DeleteOnlyPasswordDialog extends StatefulWidget {
  final String id;
  final VoidCallback reloadFunc;
  const new({super.key, required this.id, required this.reloadFunc});

  @override
  State<DeleteOnlyPasswordDialog> createState() =>
      _DeleteOnlyPasswordDialogState();
}

class _DeleteOnlyPasswordDialogState extends State<DeleteOnlyPasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 180,
        width: 300,
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Text(
                "Estas seguro de que quieres borrar esta contraseña?",
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
                      await StorageRepository.deletePassword(id: widget.id);
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
