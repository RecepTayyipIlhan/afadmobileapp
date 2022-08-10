import 'package:flutter/material.dart';
import 'package:afad_app/screens/mayday_call/ChatPage.dart';
//import 'package:afad_app/screens/mayday_call/ChatPage.dart';

class RequestButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon_data;



  const RequestButton({Key key, @required this.title, @required this.subtitle, @required this.icon_data}) : super(key: key);


  static ChatPage chat = ChatPage();
  @override
  Widget build(BuildContext context) {
   // const ChatPage c = ChatPage();
    return Column(
      children: [

        MaterialButton(
          minWidth:double.infinity,
          padding: EdgeInsets.symmetric(vertical: 0),
          onPressed: (){
          },

          child: Container(

            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              //border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(
                icon_data,
                color: Color(0xFF003399),

              ),
              title: Text(
                title,
                style: TextStyle(color:Color(0xFF003399)),
              ),
              subtitle: Text(subtitle),
            ),
          ),
        ),
        SizedBox(height: 25,)
      ],
    );
  }
}
