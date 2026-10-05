import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwords_application/Features/Home/Widgets/PasswordEditWidgetDialog.dart';

class PasswordWidget extends StatefulWidget {
  final String id;
  final String label;
  final String value;
  final VoidCallback refresh;
  const new({
    super.key,
    required this.id,
    required this.label,
    required this.value,
    required this.refresh,
  });

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: 200,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () =>
                    Clipboard.setData(ClipboardData(text: widget.value)),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        "Click para copiar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => PasswordEditWidgetDialog(
                        id: widget.id,
                        name: widget.label,
                        value: widget.value,
                        onSaved: widget.refresh,
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 150,
                    width: 80,
                    child: Icon(Icons.edit, size: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
