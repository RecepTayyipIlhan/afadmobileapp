import 'package:flutter/material.dart';
import 'package:afad_app/screens/login.dart';
import 'package:afad_app/screens/signup.dart';

import '../services/location/get_loc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Loc latLon = Loc();
    //get location from gps
    List loc = latLon.get_location();
    debugPrint("***");
    debugPrint((loc).toString());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Wrap(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Acil Durum Haberleşme Uygulaması",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Afet Anında Kesintisiz Ve Hızlı İlteşim ",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/afad.jpg'),
                ),
              ),
              //child: Image.asset("assets/images/afad.jpg"),
            ),
            Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  minWidth: double.infinity,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Giriş",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                    color: const Color.fromARGB(150, 234, 117, 38)
                        .withOpacity(0.8),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
