import 'package:flutter/material.dart';
import 'package:passwords_application/loader.dart';

import 'Core/Theme/AppThemes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: LoaderScreen()),
      theme: AppThemes.theme,
    );
  }
}
