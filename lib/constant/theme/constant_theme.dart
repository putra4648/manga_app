import 'package:flutter/material.dart';

final theme = ThemeData(
  canvasColor: Color(0xff17181c),
  textTheme: TextTheme(),
  appBarTheme: AppBarTheme(
    color: Color(0xff17181c),
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: Colors.white,
    ),
  ),
);

