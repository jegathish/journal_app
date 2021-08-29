import 'package:flutter/cupertino.dart';

class HompageBackgroud extends StatelessWidget {
  const HompageBackgroud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Color(0xFFFFFFFFF),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     child: Wrap(
            //         // alignment: WrapAlignment(),
            //         children: [
            //       SvgPicture.asset(
            //         "assets/icons/circle_bg.svg",
            //         // height: 1800,
            //         // width: 1800,
            //         alignment: Alignment.topRight,
            //       )
            //     ])),
            // Container(
            //   child: Text('hello'),
            // )
          ],
        ),
      ),
    );
  }
}
