import 'package:flutter/material.dart';
import 'MyApp.dart';

void main() {
  runApp(MaterialApp(
    title: 'Transaction app',
    theme: ThemeData(
        primaryColor: Colors.green[300],
      accentColor: Colors.pink[200],
    ),
    home: MyApp(),
  ));
}