import 'package:flutter/material.dart';

class RequestButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon_data;

  const RequestButton({Key key, @required this.title, @required this.subtitle, @required this.icon_data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MaterialButton(
          minWidth:double.infinity,
          padding: EdgeInsets.symmetric(vertical: 0),
          //padding: EdgeInsets.all(8.0),
          onPressed: (){
            print("dss");

            },
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(
                icon_data,
                color: Colors.redAccent,

              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.redAccent),
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
