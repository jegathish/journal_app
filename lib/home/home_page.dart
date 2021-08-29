import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_app/journal/journal.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/profile.png")),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Container(
              width: 40.0,
              height: 40.0,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Color(0xFFFAFAFA)),
              child: SvgPicture.asset("assets/icons/Setting_alt_fill.svg")),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    );
  }
}

class HomePageBody extends StatefulWidget {
  HomePageBody({Key? key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class JournalDetail {
  var name;
  var date;
  var imagePath;
  var details;
  JournalDetail(this.name, this.date, this.imagePath, this.details);
}

class _HomePageBodyState extends State<HomePageBody> {
  List<Widget> journalList = [];
  List<Widget> journal = [];
  final journalData = [
    new JournalDetail("Trip to Tokyo", "March 21, 2019", "assets/tokyo_bg.jpeg",
        "Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo"),
    new JournalDetail("Tokyo City", "March 21, 2019", "assets/tokyo_bg_1.png",
        "Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo comes to life at night. The best places to experience nightlife in Tokyo are shinjuku, shibuya, Ginza Roppongi and Tokyo Tower. In Tokyo"),
    new JournalDetail(
        "Tokyo Culture",
        "March 21, 2019",
        "assets/tokyo_bg_2.png",
        "The cultural side of Tokyo is famous for its numerous things to do and top attractions, including museums; festivals; internationally noted cuisine; and professional sports clubs, including baseball, football, and traditional Japanese pursuits like sumo wrestling.")
  ];

  setJournal(widthSize, heightSize) {
    this.journalData.forEach((item) {
      journal.add(
        GestureDetector(
          child: Container(
              height: heightSize / 100 * 55,
              width: widthSize / 100 * 75,
              child: Stack(children: [
                Container(
                    height: (heightSize) / 100 * 75,
                    width: widthSize,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          image: AssetImage(item.imagePath),
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
                  height: heightSize / 100 * 48,
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      child: Text(
                    item.name,
                    style: GoogleFonts.poppins(
                        fontSize: 35,
                        letterSpacing: .1,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Color(0xFFFAFAFA)),
                  )),
                ),
                Container(
                  height: heightSize / 100 * 51,
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      child: Text(
                    item.date,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        letterSpacing: .1,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        color: Color(0xFFFAFAFA)),
                  )),
                )
              ])),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JournalPage(
                        name: item.name,
                        date: item.date,
                        imagePath: item.imagePath,
                        details: item.details)));
          },
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    setJournal(size.width, size.height);

    return Container(
        height: (MediaQuery.of(context).size.height - 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      width: 250,
                      child: Text("Your Journals",
                          style: GoogleFonts.poppins(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A2F3D),
                              height: 1))),
                )),
            Container(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 55,
                    child: CarouselSlider(
                      items: this.journal,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 100 * 55,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.easeIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.7,
                      ),
                    ))),
            Container(
                width: (MediaQuery.of(context).size.width - 90),
                height: 50,
                decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10.0)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child:
                          SvgPicture.asset("assets/icons/Arhive_load_fill.svg"),
                    ),
                    Container(
                        width: 50,
                        child: OverflowBox(
                          minWidth: 0.0,
                          maxWidth: 150.0,
                          minHeight: 0.0,
                          maxHeight: 150.0,
                          alignment: Alignment(0, .5),
                          child: SvgPicture.asset(
                            "assets/icons/Add_round_fill.svg",
                            width: 85,
                            height: 85,
                          ),
                        )),
                    Container(
                      child: SvgPicture.asset("assets/icons/Img_box_fill.svg"),
                    )
                  ],
                ))
          ],
        ));
  }
}
