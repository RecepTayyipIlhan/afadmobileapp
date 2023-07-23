import 'package:flutter/material.dart';
import 'package:afad_app/services/bluetooth/MainPage.dart';

//import 'package:afad_app/screens/mayday_call/ChatPage.dart';
class MenuCard extends StatelessWidget {
  final String title;
  final String path;

  const MenuCard({
    super.key,
    required this.title,
    required this.path,
  });

  void card_pressed(var title, BuildContext context) {
    switch (title) {
      /*case  "Destek Talebi":
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        break;*/
      case "Cihazlarım":
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed: () => card_pressed(title, context),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Image.asset(path),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
