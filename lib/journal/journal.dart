import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class JournalPage extends StatefulWidget {
  var name;
  var date;
  var imagePath;
  var details;
  JournalPage(
      {Key? key,
      required this.name,
      required this.date,
      required this.imagePath,
      required this.details})
      : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with SingleTickerProviderStateMixin {
  // JournalDetail journal;
  // _JournalPageState(this.);
  late ScrollController _scrollController;
  late AnimationController _hideFabAnimController;
  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 12,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: FadeTransition(
                  opacity: _hideFabAnimController,
                  child: ScaleTransition(
                    scale: _hideFabAnimController,
                    child: FloatingActionButton(
                      shape: Border(),
                      backgroundColor: Color(0xFF2A2F3D),
                      isExtended: true,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Edit Journal',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Color(0xFFFFFFFF),
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.w500,
                                      height: 1),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 6),
                                    child: SvgPicture.asset(
                                      "assets/icons/Edit_fill.svg",
                                      color: Color(0xFFFFFFFF),
                                    )),
                              ])),
                      onPressed: () {
                        // print("hellos");
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ))),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: Stack(children: [
          Container(
              padding: EdgeInsets.fromLTRB(7, 7, 7, 0),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Container(
                        child: Stack(children: [
                      Container(
                          height:
                              (MediaQuery.of(context).size.height) / 100 * 75,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image(
                                image: AssetImage(widget.imagePath),
                                fit: BoxFit.cover,
                              ))),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            "assets/icons/Favorite_fill.svg",
                            height: 25,
                          )),
                      Container(
                        height: MediaQuery.of(context).size.height / 100 * 69,
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            child: Text(
                          widget.name,
                          style: GoogleFonts.poppins(
                              fontSize: 45,
                              letterSpacing: .1,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: Color(0xFFFAFAFA)),
                        )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 100 * 73,
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            child: Text(
                          widget.date,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              letterSpacing: .1,
                              fontWeight: FontWeight.w400,
                              height: 1,
                              color: Color(0xFFFAFAFA)),
                        )),
                      )
                    ])),
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 5, 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Journal",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.bold,
                                      height: 1)),
                              Container(
                                  child: Row(children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 7, 0),
                                    child: SvgPicture.asset(
                                      "assets/icons/up_arrow.svg",
                                      height: 18,
                                      color: Color(0xFF818899),
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 3, 0),
                                    child: Text(
                                      "Swipe up to Read",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          letterSpacing: .1,
                                          color: Color(0xFF818899),
                                          height: 1),
                                    ))
                              ]))
                            ])),
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.details,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0xFF818899),
                                  height: 1.5,
                                  letterSpacing: .3,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            )))
                  ],
                ),
              )),
          GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: SvgPicture.asset(
                  "assets/icons/Expand_left.svg",
                  height: 35,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              onTap: () {
                print('hello');
                Navigator.pop(context);
              })
        ]));
  }
}
