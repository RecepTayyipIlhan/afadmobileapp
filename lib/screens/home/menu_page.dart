import 'package:afad_app/screens/home/components/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/constants.dart';
import 'package:afad_app/services/locaiton/location_louncher.dart';
import 'package:afad_app/screens/home/components/help_card.dart';
import 'package:afad_app/person.dart';
//import '../../services/locaiton/get_loc.dart';

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

  List allData;
  List lat_lon;


  MenuScreen({Key key,this.allData,this.lat_lon}): super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  List emptyList;

  Requests r = Requests();




  GlobalKey<ScaffoldState>_scafflodKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    //get locaiton from gps
    /*List loc = lat_lon.get_location();
    print("***");
    print(loc);*/
    person_list = widget.allData;
    print("alahukeber");
    print(person_list);

    String username=widget.allData[0]["name"]+" "+widget.allData[0]["surname"];
    String email=widget.allData[0]["email"];
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scafflodKey,
      drawer: SideBar(username,email,widget.allData),

      backgroundColor: background_color_1,
      body: Container(

        child: Stack(
          children: <Widget>[
            Container(

              height: size.height * .45,
              width: size.width,

              decoration: BoxDecoration(
                color: Color(0xFF003399).withOpacity(0.9),
                //color : Colors.blue,
                image: DecorationImage(
                  scale: 0.8,
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/images/white_logo.png"),
                  // opacity: 0.8,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 45,
                        height: 45,
                        child: button(_scafflodKey),
                      ),
                    ),
                    SizedBox(height: size.height/7,),
                    Container(
                      height: size.height/15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: EdgeInsets.all(8),
                            child: Image.asset("assets/icons/search.png",
                              width: 5,
                              height: 5,
                              fit: BoxFit.fill,
                            ),
                          ) ,
                          border: InputBorder.none,
                          hintText: "Arama",
                        ),

                      ),
                    ),
                    SizedBox(height: 30,),
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .65,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 25,
                        children: <Widget>[
                          MenuCard(title:"Eğitim Videoları", path:"assets/icons/2.png"),
                          MenuCard(title: "Cihazlarım",path: "assets/icons/1.png"),

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
      ),
    );
  }

  Widget button(GlobalKey<ScaffoldState>_scafflodKey){
    return IconButton(
      onPressed: (){
        _scafflodKey.currentState?.openDrawer();
      },
      icon: Icon(Icons.menu,color: Colors.white,size: 30,),
    );
  }
}
