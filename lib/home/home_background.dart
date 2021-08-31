import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HompageBackgroud extends StatelessWidget {
  const HompageBackgroud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 275,
                  height: 275,
                  child: SvgPicture.asset(
                    "assets/icons/home_top_bg.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 380,
                      height: 258.81,
                      child: SvgPicture.asset(
                        "assets/icons/home_bottom_bg.svg",
                        fit: BoxFit.fill,
                      ))),
            ]));
  }
}
