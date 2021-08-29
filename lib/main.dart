import 'package:flutter/material.dart';
import 'package:journal_app/home/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      home: MyHomePage(),
    );
  }
}
