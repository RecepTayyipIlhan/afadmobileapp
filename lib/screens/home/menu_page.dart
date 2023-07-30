import 'package:afad_app/screens/home/components/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/constants.dart';
import 'package:afad_app/services/location/location_louncher.dart';
import 'package:afad_app/screens/home/components/help_card.dart';

import '../../global_data.dart';
//import '../../services/location/get_loc.dart';

/*class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: background_color_1,
        textTheme: Theme.of(context).textTheme.apply(displayColor: text_color),
      ),
      home: MenuScreen(),
    );
  }
}*/

class MenuScreen extends StatefulWidget {
  final List? allData;
  final List? latLon;

  const MenuScreen({
    super.key,
    this.allData,
    this.latLon,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Requests r = Requests();

  final _scafflodKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //get location from gps
    /*List loc = lat_lon.get_location();
    debugPrint("***");
    debugPrint(loc.toString());*/
    personList = widget.allData;
    debugPrint("alahukeber");
    debugPrint((personList).toString());

    String username =
        widget.allData?[0]["name"] + " " + widget.allData?[0]["surname"];
    String email = widget.allData?[0]["email"];
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scafflodKey,
      drawer: SideBar(username, email, widget.allData),
      backgroundColor: backgroundColor1,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            width: size.width,
            decoration: BoxDecoration(
              color: const Color(0xFF003399).withOpacity(0.9),
              //color : Colors.blue,
              image: const DecorationImage(
                scale: 0.8,
                alignment: Alignment.topCenter,
                image: AssetImage("assets/images/white_logo.png"),
                // opacity: 0.8,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: button(_scafflodKey),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 7,
                  ),
                  Container(
                    height: size.height / 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            "assets/icons/search.png",
                            width: 5,
                            height: 5,
                            fit: BoxFit.fill,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Arama",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 25,
                      children: const <Widget>[
                        MenuCard(
                            title: "Eğitim Videoları",
                            path: "assets/icons/2.png"),
                        MenuCard(
                            title: "Cihazlarım", path: "assets/icons/1.png"),
                        //koyu yeşil 3ea69b
                        //açık yeşil 44c4a1
                        //kırmızı ec7d83
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(GlobalKey<ScaffoldState> scafflodKey) {
    return IconButton(
      onPressed: () {
        scafflodKey.currentState?.openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
