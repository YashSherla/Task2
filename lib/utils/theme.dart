import 'package:flutter/material.dart';

class CustomTheme {

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
    ),
    cardColor: Colors.grey[800],
  );
}
