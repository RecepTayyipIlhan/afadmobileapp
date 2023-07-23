import 'package:afad_app/screens/login.dart';
import 'package:afad_app/screens/add_user_info.dart';
//import 'package:afad_app/screens/login.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  String email = "ilhanreceptayyip@gmail.com";
  String username = "Recep Tayyip İlhan";
  List? allData;
  SideBar(this.email, this.username, this.allData, {super.key});

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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              email,
              style: const TextStyle(
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
            decoration: const BoxDecoration(
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
            leading: const Icon(Icons.person),
            title: const Text("Afet Bilgilerimi Güncelle"),
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
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Çıkış Yap"),
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
