import 'package:flutter/material.dart';
import 'package:afad_app/screens/help_form.dart';
import 'package:afad_app/services/bluetooth/MainPage.dart';
//import 'package:afad_app/screens/mayday_call/ChatPage.dart';
class MenuCard extends StatelessWidget {
  final String title;
  final String path;

  const MenuCard({Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key) ;

  void card_pressed(var title,BuildContext context){
    switch(title){
      /*case  "Destek Talebi":
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        break;*/
      case "Cihazlarım" :
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        break;
    }

  }

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
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(path),
              ),
            ),
            Divider(color: Colors.black,thickness: 1,),
            Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 14 ),),
          ],
        ),
      ),
    );
  }
}