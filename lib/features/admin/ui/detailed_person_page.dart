import 'package:flutter/material.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'components/side_of_info_screen.dart';
import 'components/info_cards.dart';

class DetailedPersonPage extends StatelessWidget {
  final AppUser user;
  const DetailedPersonPage({Key? key, required this.user}) : super(key: key);

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
              SideScreen(
                user_d: user,
              ),
              InfoCards(
                user_d: user,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
