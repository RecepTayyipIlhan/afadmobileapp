import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/home/menu_page.dart';


class UserPage extends StatelessWidget {


  TextEditingController blood_group_c = TextEditingController();
  TextEditingController diseases_c= TextEditingController();
  TextEditingController medicines_c = TextEditingController();
  TextEditingController people_with_c = TextEditingController();
  TextEditingController building_age_c = TextEditingController();
  TextEditingController building_durability_c = TextEditingController();



  void add_info(String blood_group, String diseases, String medicines, String people_with, String building_age, String building_durability ){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users_ref = FirebaseFirestore.instance.collection('UserInfos');
    users_ref.add({'blood_group':blood_group, 'diseases':diseases,'medicines':medicines, 'people_with':people_with,'building_age':building_age,'building_durability':building_durability});
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
            Navigator.pop(context,MaterialPageRoute(builder: (context) => MenuScreen(),));

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
                    "Afet Bilgilerini Ekle",
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
                        "Afet anında AFAD'ın size daha faydalı destek sunabilmesi için aşağıdaki bilgileri doğru giriniz",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                child: Column(
                  children: <Widget>[
                    makeInput(label: "Kan Grubunuz",controller_name: blood_group_c),
                    makeInput(label: "Sahip Olduğunuz Hastalıklar",controller_name: diseases_c),
                    makeInput(label: "Düzenli Kullandığınız İlaçlar",controller_name: medicines_c),
                    makeInput(label: "Evinizde Yaşayan Kişi Sayısı",controller_name: people_with_c),
                    makeInput(label: "Oturduğunuz Binanın Yapılış Yılı",controller_name: building_age_c),
                    makeInput(label: "Binanızın Tahmini Deprem Dayanıklığı",controller_name: building_durability_c ),
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
                    //color: Colors.blueAccent.withOpacity(0.8),
                    color: Color(0xFFE63946),
                    onPressed: () {
                      add_info(blood_group_c.text, diseases_c.text, medicines_c.text, people_with_c.text, building_age_c.text, building_durability_c.text);
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Afet Bilgilerini Ekle",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)
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
