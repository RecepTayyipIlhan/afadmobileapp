//import 'package:afad_application/services/auth.dart';
import 'package:afad_app/screens/home/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afad_app/services/location/location_louncher.dart';

import '../global_data.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Requests req = Requests();

  //var allData = {};
  void login_(context) async {
    if (isDebugging) {
      final allData = [
        {
          "name": "Mehmet",
          "surname": "Kaya",
          "email": "mehmet.kaya@gmail.com",
        },
      ];

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MenuScreen(allData: allData),
        ),
      );

      return;
    }

    //final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.setString('email', email_c.text);

    QuerySnapshot querySnapshot = await usersRef
        .where("email", isEqualTo: emailC.text)
        .where("password", isEqualTo: passwordC.text)
        .get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print((allData).toString());

    if (allData.isEmpty) {
      print("User can not found");
    } else if (allData.length == 1) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MenuScreen(allData: allData),
      ));

      req.requestService();
      req.requestPermission();
    } else {
      print("Unexpected error occured");
    }
  }

  /*Map get_person(){
    return allData;
  }*/
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usersRef =
      FirebaseFirestore.instance.collection('People');

  final TextEditingController emailC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()));*/
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    "Giriş",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //SizedBox(height: 20,),
                  Text(
                    "Hesabınıza Giriş Yapınız",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  makeInput(
                      label: "Email",
                      hintText: "e.g ornek@mail.com",
                      controllerName: emailC),
                  makeInput(
                    label: "Şifre",
                    obscureText: true,
                    hintText: "*********",
                    controllerName: passwordC,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  color: Colors.blueAccent.withOpacity(0.8),
                  onPressed: () {
                    login_(context);
                  },
                  minWidth: double.infinity,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Giriş",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Eğer hesabınız yoksa kayıt olunuz."),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Kayıt",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/afad.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget makeInput({
  label,
  obscureText = false,
  hintText = "",
  controllerName,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        controller: controllerName,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
