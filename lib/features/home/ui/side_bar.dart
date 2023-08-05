//import 'package:afad_app/screens/login.dart';
import 'package:afad_app/features/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';

import 'add_user_info.dart';

class SideBar extends StatefulWidget {
  // "ilhanreceptayyip@gmail.com"
  final String email;
  // "Recep Tayyip İlhan"
  final String username;
  final List? allData;
  const SideBar(this.email, this.username, this.allData, {super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    // print(allData.toString());
    //LoginPage log = LoginPage();
    //print(log.get_person().toString());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              widget.email,
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
                    widget.allData,
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
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
