import 'package:afad_app/screens/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/constants.dart';
import 'package:afad_app/screens/help_form.dart';

class MenuPage extends StatelessWidget {

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
}

class MenuScreen extends StatelessWidget {
  GlobalKey<ScaffoldState>_scafflodKey=GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scafflodKey,
      drawer: SideBar(),

      backgroundColor: background_color_1,
      body: Container(

        child: Stack(
          children: <Widget>[
            Container(

              height: size.height * .45,
              width: size.width,

              decoration: BoxDecoration(
                color: Color(0xFFE63946),
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
                        childAspectRatio: .85,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 13,
                        children: <Widget>[
                          Card(title: "Destek Talebi",path: "assets/images/emergency-call.png"),
                          Card(title: "Cihazlarım",path: "assets/images/lora.png"),
                          Card(title: "En Yakın Toplanma Alanı",path: "assets/images/map.png"),
                          Card(title: "Enkaz Altındayım Butonu",path: "assets/images/earthquake.png"),
                          Card(title: "Afet Talimatları",path: "assets/images/info.png"),
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

class Card extends StatelessWidget {
  final String title;
  final String path;

  void card_pressed(var title,BuildContext context){
    switch(title){
      case  "Destek Talebi":
        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageForm(),));

    }


  }

  const Card({Key? key, required this.title, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed:() => card_pressed(title,context),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(path),
              ),
            ),
            Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 17 ),),
          ],
        ),
      ),
    );
  }
}

