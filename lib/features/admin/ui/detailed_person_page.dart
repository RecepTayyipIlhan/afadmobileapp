import 'package:afad_app/features/admin/prov/admin_map_prov.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/side_of_info_screen.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'components/info_cards.dart';

class DetailedPersonPage extends StatelessWidget {
  final AppUser user_d;
  const DetailedPersonPage({Key? key, required this.user_d}) : super(key: key);

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
              SideScreen(user_d: user_d),
              InfoCards(user_d: user_d),
            ],
          ),
        ],
      ),
    );
  }
}
