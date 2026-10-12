import 'package:flutter/material.dart';

class AppThemes {
  static Color background = Color(0xFF393952);
  static Color card = Color(0xFF2828DF);
  static Color dialog = Color(0xFF595994);
  static Color button = Color(0xFFDEFF66);
  static Color floatingButton = Color(0xD4FCA656);
  static Color iconAndText = Colors.black;

  static final theme = ThemeData(
    cardColor: card,
    scaffoldBackgroundColor: background,
    dialogTheme: DialogThemeData(backgroundColor: dialog),
    buttonTheme: ButtonThemeData(buttonColor: button),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: floatingButton,
    ),
    iconTheme: IconThemeData(color: iconAndText),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(color: iconAndText)),
      ),
    ),
    textTheme: TextTheme(),
    sliderTheme: SliderThemeData(
      thumbColor: Color(0xD4FCA656),
      activeTrackColor: Color(0xD4FCA656),
      inactiveTrackColor: Colors.blueGrey,
    ),
  );
}
