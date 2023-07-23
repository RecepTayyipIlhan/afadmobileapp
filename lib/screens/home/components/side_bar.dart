import 'package:afad_app/screens/login.dart';
import 'package:afad_app/screens/add_user_info.dart';
//import 'package:afad_app/screens/login.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  String email = "ilhanreceptayyip@gmail.com";
  String username = "Recep Tayyip İlhan";
  List? allData;
  SideBar(this.email, this.username, this.allData);

  @override
  Widget build(BuildContext context) {
    // debugPrint(allData);
    //LoginPage log = LoginPage();
    //debugPrint(log.get_person());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              username,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white70,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/tc.png",
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFE63946),
              image: DecorationImage(
                image: AssetImage("assets/images/sidebar.jpg"),
                colorFilter:
                    ColorFilter.mode(Color(0xFFE63946), BlendMode.modulate),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Afet Bilgilerimi Güncelle"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(
                    allData,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Çıkış Yap"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
