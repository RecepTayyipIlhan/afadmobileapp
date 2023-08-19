import 'package:flutter/material.dart';

class SideScreen extends StatelessWidget {
  const SideScreen({Key? key}) : super(key: key);

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
              "https://media.licdn.com/dms/image/D5603AQFhFYfRpuFVVg/profile-displayphoto-shrink_800_800/0/1678191317751?e=1697673600&v=beta&t=dzwuirGJaMZ68dWm27TQSS7YRbGVxBd4k8cbHxhdIWk",
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recep Tayyip İlhan",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "ilhanreceptayyip@gmail.com",
            style: TextStyle(fontFamily: "Roboto",color: Colors.black26),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
