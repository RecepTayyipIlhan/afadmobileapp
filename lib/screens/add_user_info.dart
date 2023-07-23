import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/screens/home/menu_page.dart';

class UserPage extends StatelessWidget {
  List? allData;
  TextEditingController blood_group_c = TextEditingController();
  TextEditingController tc_id_number_c = TextEditingController();
  TextEditingController phone_c = TextEditingController();
  TextEditingController relative_phone_c = TextEditingController();
  TextEditingController diseases_c = TextEditingController();
  TextEditingController medicines_c = TextEditingController();
  TextEditingController people_with_c = TextEditingController();

  TextEditingController address_c = TextEditingController();
  TextEditingController building_age_c = TextEditingController();
  TextEditingController building_durability_c = TextEditingController();

  UserPage(
    this.allData, {
    super.key,
  });

  void add_info(
    String bloodGroup,
    String phone,
    String tcIdNumber,
    String relativePhone,
    String diseases,
    String medicines,
    String peopleWith,
    String address,
    String buildingAge,
    String buildingDurability,
    List? allData,
  ) async {
    final id = allData?[0]["id"];

    debugPrint(id);

    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('People');

    /*QuerySnapshot querySnapshot2  = await db.collection("People").where("id", isEqualTo: id).get();/*.update({"blood_group": blood_group})*/
    final allDatam = querySnapshot2.docs.map((doc) => doc.data()).toList();
    debugPrint(allDatam);*/

    db.collection("People").doc(id).update({
      "blood_group": bloodGroup,
      "phone": phone,
      "tc_id_number": tcIdNumber,
      "relative_phone": relativePhone,
      'diseases': diseases,
      'medicines': medicines,
      'people_with': peopleWith,
      "address": address,
      'building_age': buildingAge,
      'building_durability': buildingDurability
    });

    //users_ref.add({'blood_group':blood_group, 'diseases':diseases,'medicines':medicines, 'people_with':people_with,'building_age':building_age,'building_durability':building_durability});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("*******");
    debugPrint((allData).toString());
    debugPrint("*******");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuScreen(),
                ));
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        //reverse: true,
        child: SizedBox(
          //height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Afet Bilgilerini Ekle",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Afet anında AFAD'ın size daha faydalı destek sunabilmesi için aşağıdaki bilgileri doğru giriniz",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Column(
                  children: <Widget>[
                    makeInput(
                      label: "Kan Grubunuz",
                      controller_name: blood_group_c,
                      hintText: allData?[0]["blood_group"],
                    ),
                    makeInput(
                      label: "Telefon Numaranız",
                      controller_name: phone_c,
                      hintText: allData?[0]["phone"],
                    ),
                    makeInput(
                      label: "Tc Kimlik Numaranız",
                      controller_name: tc_id_number_c,
                      hintText: allData?[0]["tc_id_number"],
                    ),
                    makeInput(
                      label: "Yakınınızın Numarası",
                      controller_name: relative_phone_c,
                      hintText: allData?[0]["relative_phone"],
                    ),
                    makeInput(
                      label: "Sahip Olduğunuz Hastalıklar",
                      controller_name: diseases_c,
                      hintText: allData?[0]["diseases"],
                    ),
                    makeInput(
                      label: "Düzenli Kullandığınız İlaçlar",
                      controller_name: medicines_c,
                      hintText: allData?[0]["medicines"],
                    ),
                    makeInput(
                      label: "Evinizde Yaşayan Kişi Sayısı",
                      controller_name: people_with_c,
                      hintText: allData?[0]["people_with"],
                    ),
                    makeInput(
                      label: "Adresiniz",
                      controller_name: address_c,
                      hintText: allData?[0]["address"],
                    ),
                    makeInput(
                      label: "Oturduğunuz binanın yaşı",
                      controller_name: building_age_c,
                      hintText: allData?[0]["building_age"],
                    ),
                    makeInput(
                      label: "Binanızın Tahmini Depreme Dayanaıklığı",
                      controller_name: building_durability_c,
                      hintText: allData?[0]["building_durability"],
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
                    //color: Colors.blueAccent.withOpacity(0.8),
                    color: const Color(0xFFE63946),
                    onPressed: () {
                      add_info(
                        blood_group_c.text,
                        phone_c.text,
                        tc_id_number_c.text,
                        relative_phone_c.text,
                        diseases_c.text,
                        medicines_c.text,
                        people_with_c.text,
                        address_c.text,
                        building_age_c.text,
                        building_durability_c.text,
                        allData,
                      );
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Afet Bilgilerini Ekle",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obscureText = false, controller_name, hintText}) {
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
        controller: controller_name,
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
        height: 20,
      ),
    ],
  );
}
