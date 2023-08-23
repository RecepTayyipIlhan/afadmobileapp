import 'package:flutter/material.dart';
import 'package:afad_app/features/auth/models/app_user.dart';

class SideScreen extends StatelessWidget {
  final AppUser user_d;
  const SideScreen({Key? key, required this.user_d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.25,
      height: screen.height * 0.88,
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              user_d.profilePicUrl.toString(),
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            user_d.fullName,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user_d.email,
            style: TextStyle(fontFamily: "Roboto", color: Colors.black26),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
