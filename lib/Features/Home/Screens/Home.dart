import 'package:flutter/material.dart';
import 'package:passwords_application/Core/Theme/AppThemes.dart';
import 'package:passwords_application/Features/Home/Dialogs/DeletePasswordsDialog.dart';
import 'package:passwords_application/Features/Home/Dialogs/PasswordCreateWidgetDialog.dart';
import 'package:passwords_application/Features/StorageService/Repositories/StorageRepository.dart';
import 'package:passwords_application/Features/Home/Widgets/PasswordWidget.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>>? passwords;

  Future<void> getPasswords() async {
    final List<Map<String, String>> obtainedPasswords =
        await StorageRepository.getPasswords();

    setState(() {
      passwords = obtainedPasswords;
    });
  }

  @override
  void initState() {
    getPasswords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: AppThemes.iconAndText,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => PasswordCreateWidgetDialog(),
          );
          await getPasswords();
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: passwords?.length ?? 0,
                  itemBuilder: (_, index) {
                    final password = passwords![index];
                    return PasswordWidget(
                      id: password["id"]!,
                      label: password["name"]!,
                      value: password["value"]!,
                      refresh: getPasswords,
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              foregroundColor: AppThemes.iconAndText,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) =>
                      DeletePasswordsDialog(reloadFunc: getPasswords),
                );
              },
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
