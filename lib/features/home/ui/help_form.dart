import 'package:flutter/material.dart';

class MessageForm extends StatelessWidget {
  const MessageForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print((size.height * .25).toString());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * .25,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              color: Color(0xFFE63946),
            ),
            child: const SafeArea(
              child: BackButton(),
            ),
          ),
          Row(
            //padding:EdgeInsets.symmetric(horizontal: size.width*0.1),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                width: size.width * 0.4,
                child: Column(
                  children: <Widget>[
                    const ListTile(
                      tileColor: Color(0xFF212F3C),
                      title: Text("Deneme"),
                    ),
                    const ListTile(
                      tileColor: Color(0xFF212F3C),
                      title: Text("Deneme"),
                    ),
                    ListTile(
                      tileColor: const Color(0xFF212F3C).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                    ListTile(
                      tileColor: const Color(0xFF212F3C).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.20),
              SizedBox(
                width: size.width * 0.38,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      tileColor: const Color(0xFFECF0F1).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                    ListTile(
                      tileColor: const Color(0xFFECF0F1).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                    ListTile(
                      tileColor: const Color(0xFF212F3C).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                    ListTile(
                      tileColor: const Color(0xFF212F3C).withOpacity(0.5),
                      title: const Text("Deneme"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
