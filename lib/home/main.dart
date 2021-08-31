import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/home/home_background.dart';
import 'package:journal_app/home/home_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      HompageBackgroud(),
      Container(
          child: Column(
            children: [HomeTopSection(), HomePageBody()],
          ),
          color: Color(0xFFFFFFFF).withOpacity(0),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20))
    ]));
  }
}
