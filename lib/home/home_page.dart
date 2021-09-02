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
        "The site of Tokyo has been inhabited since ancient times; the small fishing village of Edo existed there for centuries. Edo’s development into a city did not occur until the Tokugawa period (1603–1867), when it became the capital of the Tokugawa shogunate. During this period, however, the imperial family remained in Kyōto, the ancient imperial capital. With the Meiji Restoration of 1868, which ended the shogunate, the capital was moved to Edo. The city was renamed Tokyo, meaning “eastern capital.” Edo had been Japan’s largest city since the 17th century. Tokyo’s population exceeded one million in the late 19th century, and as Japan’s political, economic, and cultural centre it became one of the world’s most populous cities in the 20th century."),
    new JournalDetail(
        "Tokyo Culture",
        "March 21, 2019",
        "assets/tokyo_bg_2.png",
        "Tokyo is Japan’s major cultural centre. Displays depicting the art and history of Japan and Asia are featured at the Tokyo National Museum in Ueno Park. Ueno Park is also the site of a science museum, a zoological garden, and two major art museums. Art and science museums are located close to the Imperial Palace, and museums of various types are located elsewhere in the city. Theatrical works, including everything from traditional Kabuki to modern drama, are performed regularly, as are symphonic works, operas, and other Western forms of dance and music. The University of Tokyo heads a long list of major universities and colleges in the metropolitan area.Tokyo is the chief transportation hub for Japan, as well as an important international traffic centre. It is served by a dense network of electric railways, subways, bus lines, and highways. Tokyo station is the central railroad terminal for all of Japan, including the high-speed Shinkansen bullet trains from western Japan. Ueno Station is the terminus for rail lines running to northern Japan, and Shinjuku station is the terminus for trains from central Honshu and Tokyo’s western suburbs. Several privately owned electric rail lines provide interurban transit service. Tokyo’s international airport is at Narita, in Chiba prefecture, while the city’s Haneda airport on the bay provides domestic service. Area 240 square miles (621 square km). Pop. (2005) 8,489,653; (2010) 8,945,695.")
  ];

  List<Widget> getJournal() {
    print(MediaQuery.of(context).size);
    return this
        .journalData
        .map((element) => GestureDetector(
              child: Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height / 100 * 55,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          image: AssetImage(element.imagePath),
                          fit: BoxFit.cover,
                        ))),
                Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                    child: SvgPicture.asset("assets/icons/Favorite_fill.svg",
                        height: 25)),
                Container(
                  padding: EdgeInsets.fromLTRB(14, 0, 0, 48),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      child: Text(
                    element.name,
                    style: GoogleFonts.poppins(
                        fontSize: 35,
                        letterSpacing: .1,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Color(0xFFFAFAFA)),
                  )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(14, 0, 0, 25),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      child: Text(
                    element.date,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        letterSpacing: .1,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        color: Color(0xFFFAFAFA)),
                  )),
                )
              ]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JournalPage(
                            name: element.name,
                            date: element.date,
                            imagePath: element.imagePath,
                            details: element.details)));
              },
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 55,
                    child: CarouselSlider(
                      items: getJournal(),
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.easeIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: .7,
                          // aspectRatio: 16 / 200,
                          height:
                              MediaQuery.of(context).size.height / 100 * 55),
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
