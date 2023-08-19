import 'package:flutter/material.dart';
import 'components/side_of_info_screen.dart';
import 'components/info_cards.dart';

class DetailedPersonPage extends StatelessWidget {
  const DetailedPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text('Kullanıcı Bilgileri'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SideScreen(),
              InfoCards(),
            ],
          ),
        ],
      ),
    );
  }
}
