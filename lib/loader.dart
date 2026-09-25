import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passwords_application/Core/Services/StorageService/StorageService.dart';
import 'package:passwords_application/Features/Home/Screens/Home.dart';

class LoaderScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  bool loaded = false;

  Future<void> init() async {
    await StorageService.init();
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    if (!loaded) init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loaded ? HomeScreen() : Center(child: CircularProgressIndicator());
  }
}
