import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/login.dart';
import 'package:afad_app/screens/start_page.dart';


class SignupPage extends StatelessWidget {


  TextEditingController name_c = TextEditingController();
  TextEditingController surname_c = TextEditingController();
  TextEditingController email_c = TextEditingController();
  TextEditingController phone_c = TextEditingController();
  TextEditingController password_c = TextEditingController();

  /*CollectionReference<Object?> firestore_test(){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users_ref = FirebaseFirestore.instance.collection('user');
    return users_ref;
  }*/

  void login_(String username, String surname, String password, String email, String phone ){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users_ref = FirebaseFirestore.instance.collection('user');
    //CollectionReference users_ref= firestore_test();
    users_ref.add({'username':username, 'surname':surname,'phone':password, 'password':email,'email':phone});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        //reverse: true,
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Kayıt",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Yeni Bir Afet Koordinasyon Uygulaması Hesabı Oluşturun",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                child: Column(
                  children: <Widget>[
                    makeInput(label: "Name",controller_name: name_c),
                    makeInput(label: "Surname",controller_name: surname_c),
                    makeInput(label: "Email",controller_name: email_c),
                    makeInput(label: "Telefon Numarası",controller_name: phone_c),
                    makeInput(label: "Şifre", obscureText: true,controller_name: password_c),
                    makeInput(label: "Şifreyi Doğrula", obscureText: true,controller_name: password_c),
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
                    onPressed: () {
                      print(name_c.text);
                      login_(name_c.text, surname_c.text, password_c.text, email_c.text, phone_c.text);
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
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
                  Text("Eğer hesabınız varsa giriş yapınız."),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => LoginPage(),));
                      },
                      child: Text(
                        "Giriş",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obscureText = false,controller_name}) {
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
        height: 20,
      ),
    ],
  );
}
