import 'package:flutter/material.dart';
import 'info_card.dart';
import 'package:afad_app/features/auth/models/app_user.dart';

class InfoCards extends StatelessWidget {
  final AppUser user_d;
  const InfoCards({Key? key, required this.user_d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.70,
      height: screen.height * 0.70,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "İsim",
                value: user_d.fullName,
              ),
              InfoCard(
                text: "Tc",
                value: user_d.idNumber,
              ),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "Kan Grubu",
                value: user_d.bloodGroup.toString(),
              ),
              InfoCard(
                text: "Adres",
                value: user_d.address.toString(),
              ),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "İl",
                value: user_d.birthDate.toString(),
              ),
              const InfoCard(text: "İlçe", value: "Gaziosmanpaşa"),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "Aile üyesi sayısı",
                value: "3",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
