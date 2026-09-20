import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordWidget extends StatefulWidget {
  final String label;
  final String value;
  const new({super.key, required this.label, required this.value});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Clipboard.setData(ClipboardData(text: widget.value)),
      child: SizedBox(
        height: 150,
        width: 200,
        child: Card(child: Column(children: [Text(widget.label)])),
      ),
    );
  }
}
