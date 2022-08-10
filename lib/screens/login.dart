//import 'package:afad_application/services/auth.dart';
import 'package:afad_app/screens/home/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/start_page.dart';
import 'package:afad_app/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afad_app/services/locaiton/location_louncher.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  Requests req = Requests();
  List lat_lon;
  //LoginPage(this.lat_lon);

  //var allData = {};

  void login_(context)async{
    //final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.setString('email', email_c.text);


    QuerySnapshot querySnapshot = await users_ref.where("email",isEqualTo: email_c.text).where("password",isEqualTo: password_c.text).get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);

    if(allData.length == 0){
        print("User can not found");
    }else if(allData.length==1){
      Navigator.of(context).pushReplacement(

          MaterialPageRoute(
            builder: (context) => MenuScreen(allData : allData),
          ));

      req.request_service();
      req.request_permission();

    }else{
      print("Unexpected error occured");
    }

  }

  /*Map get_person(){
    return allData;
  }*/


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users_ref = FirebaseFirestore.instance.collection('People');
  final TextEditingController email_c= TextEditingController();
  final TextEditingController password_c= TextEditingController();


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
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
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
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  makeInput(label: "Email", hint_text: "e.g ornek@mail.com",controller_name: email_c),
                  makeInput(
                      label: "Şifre",
                      obscureText: true,
                      hint_text: "*********",
                      controller_name: password_c,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  color: Colors.blueAccent.withOpacity(0.8),
                  onPressed: (){
                    login_(context);
                  },
                  minWidth: double.infinity,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
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
                Text("Eğer hesabınız yoksa kayıt olunuz."),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ));
                    },
                    child: Text(
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
              decoration: BoxDecoration(
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

Widget makeInput(
    {label, obscureText = false, hint_text = "", controller_name})
   {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller_name,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint_text,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
