import 'package:afad_app/screens/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size.height * .25);
    return Scaffold(
      body: Container(
        //alignment: Alignment.center,
        child: Stack(

          children: <Widget>[

            Container(
              width: size.width,
              height: size.height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                color: Color(0xFFE63946),
              ),
              child: SafeArea(
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  alignment: Alignment.topLeft,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuPage(),
                        ));
                  },
                ),
              ),
            ),
            Row(
              //padding:EdgeInsets.symmetric(horizontal: size.width*0.1),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  width: size.width*0.4,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        tileColor: Color(0xFF212F3C),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFF212F3C),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFF212F3C).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFF212F3C).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                    ],
                  ),
                ),
                SizedBox(width:size.width*0.20),
                Container(
                  width: size.width*0.38,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        tileColor: Color(0xFFECF0F1).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFFECF0F1).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFF212F3C).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                      ListTile(
                        tileColor: Color(0xFF212F3C).withOpacity(0.5),
                        title: Text("Deneme"),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
