import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[800],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
