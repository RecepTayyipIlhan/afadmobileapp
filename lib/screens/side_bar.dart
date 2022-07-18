import 'package:afad_app/screens/login.dart';
import 'package:afad_app/screens/add_user_info.dart';

import 'package:flutter/material.dart';
//import 'package:afad_app/screens/login.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Recep Tayyip İlhan",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              accountEmail: Text("ilhanreceptayyip@gmail.com",style: TextStyle(color: Colors.white,fontSize: 15,),),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white70,
                child: ClipOval(
                  child: Image.asset("assets/images/tc.png",),
                ),
              ),
            decoration: BoxDecoration(
              color: Color(0xFFE63946),
              image: DecorationImage(
                image: NetworkImage("https://cdn.pixabay.com/photo/2017/02/26/04/47/cracks-2099531__340.jpg"),
                colorFilter: ColorFilter.mode(Color(0xFFE63946), BlendMode.modulate),
                fit:BoxFit.cover,
              ),

            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Afet Bilgilerimi Güncelle"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Çıkış Yap"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),

        ],

      ),

    );
  }
}
