import 'package:afad_app/features/home/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final List? allData;

  const UserPage(
    this.allData, {
    super.key,
  });

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController bloodGroupC = TextEditingController();

  TextEditingController tcIdNumberC = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  TextEditingController relativePhoneC = TextEditingController();

  TextEditingController diseasesC = TextEditingController();

  TextEditingController medicinesC = TextEditingController();

  TextEditingController peopleWithC = TextEditingController();

  TextEditingController addressC = TextEditingController();

  TextEditingController buildingAgeC = TextEditingController();

  TextEditingController buildingDurabilityC = TextEditingController();

  void addInfo(
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

    print(id.toString());

    FirebaseFirestore db = FirebaseFirestore.instance;

    // CollectionReference usersRef =
    //     FirebaseFirestore.instance.collection('People');

    /*QuerySnapshot querySnapshot2  = await db.collection("People").where("id", isEqualTo: id).get();/*.update({"blood_group": blood_group})*/
    final allDatam = querySnapshot2.docs.map((doc) => doc.data()).toList();
    print(allDatam.toString());*/

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
    print("*******");
    print((widget.allData).toString());
    print("*******");
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
                  builder: (context) => const HomeScreen(),
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
                      controllerName: bloodGroupC,
                      hintText: widget.allData?[0]["blood_group"],
                    ),
                    makeInput(
                      label: "Telefon Numaranız",
                      controllerName: phoneC,
                      hintText: widget.allData?[0]["phone"],
                    ),
                    makeInput(
                      label: "Tc Kimlik Numaranız",
                      controllerName: tcIdNumberC,
                      hintText: widget.allData?[0]["tc_id_number"],
                    ),
                    makeInput(
                      label: "Yakınınızın Numarası",
                      controllerName: relativePhoneC,
                      hintText: widget.allData?[0]["relative_phone"],
                    ),
                    makeInput(
                      label: "Sahip Olduğunuz Hastalıklar",
                      controllerName: diseasesC,
                      hintText: widget.allData?[0]["diseases"],
                    ),
                    makeInput(
                      label: "Düzenli Kullandığınız İlaçlar",
                      controllerName: medicinesC,
                      hintText: widget.allData?[0]["medicines"],
                    ),
                    makeInput(
                      label: "Evinizde Yaşayan Kişi Sayısı",
                      controllerName: peopleWithC,
                      hintText: widget.allData?[0]["people_with"],
                    ),
                    makeInput(
                      label: "Adresiniz",
                      controllerName: addressC,
                      hintText: widget.allData?[0]["address"],
                    ),
                    makeInput(
                      label: "Oturduğunuz binanın yaşı",
                      controllerName: buildingAgeC,
                      hintText: widget.allData?[0]["building_age"],
                    ),
                    makeInput(
                      label: "Binanızın Tahmini Depreme Dayanaıklığı",
                      controllerName: buildingDurabilityC,
                      hintText: widget.allData?[0]["building_durability"],
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
                      addInfo(
                        bloodGroupC.text,
                        phoneC.text,
                        tcIdNumberC.text,
                        relativePhoneC.text,
                        diseasesC.text,
                        medicinesC.text,
                        peopleWithC.text,
                        addressC.text,
                        buildingAgeC.text,
                        buildingDurabilityC.text,
                        widget.allData,
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

Widget makeInput({
  label,
  obscureText = false,
  controllerName,
  hintText,
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
        height: 20,
      ),
    ],
  );
}
