import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      Container(
          child: SvgPicture.asset(
            "assets/icons/home_bg.svg",
            fit: BoxFit.fill,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height),
      Container(
          child: Column(
            children: [HomeTopSection(), HomePageBody()],
          ),
          color: Color(0xFFFFFFFF).withOpacity(0),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20))
    ]));
  }
}
