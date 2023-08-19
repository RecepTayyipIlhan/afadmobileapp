import 'package:flutter/material.dart';
import 'info_card.dart';

class InfoCards extends StatelessWidget {
  const InfoCards({Key? key}) : super(key: key);

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
                value: "Recep Tayyip İlhan",
              ),
              InfoCard(
                text: "Tc",
                value: "14249420994",
              ),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "Kan Grubu",
                value: "A rh+",
              ),
              InfoCard(
                text: "Adres",
                value: "Mevlana mahallesi 901sk no:4d daire:10",
              ),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoCard(
                text: "İl",
                value: "İstanbul",
              ),
              InfoCard(text: "İlçe", value: "Gaziosmanpaşa"),
            ],
          ),
          SizedBox(height: screen.height * 0.03),
          Row(
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
