import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.70,
      height: screen.height * 0.70,
      child: ListView(
        children: const <Widget>[
          // Mesajları buraya ekleyin, her bir mesaj için ListTile kullanabilirsiniz.
          ListTile(
            leading: Icon(Icons.message), // Mesaj ikonu
            title: Text("Ambulans"),
            subtitle: Text("Konuma Acil Ambulans"),
          ),
          ListTile(
            leading: Icon(Icons.message), // Mesaj ikonu
            title: Text("Kurtarma Ekibi"),
            subtitle: Text("Enkaz Altında İnsanlar Var"),
          ),
          // İsterseniz daha fazla mesaj ekleyebilirsiniz.
        ],
      ),
    );
  }
}
