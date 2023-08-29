import 'package:flutter/material.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'components/side_of_info_screen.dart';
import 'components/info_cards.dart';
import 'components/message_list.dart';

class DetailedPersonPage extends StatefulWidget {
  final AppUser user;
  const DetailedPersonPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DetailedPersonPage> createState() => _DetailedPersonPageState();
}

enum SelectedScreen {
  infoScreen,
  messageScreen,
}

class _DetailedPersonPageState extends State<DetailedPersonPage> {
  SelectedScreen selectedIndex = SelectedScreen.infoScreen;

  void onSelecteChange(SelectedScreen selectedScreen) {
    setState(() {
      selectedIndex = selectedScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(selectedIndex == SelectedScreen.infoScreen
            ? "Kullanıcı Bilgileri"
            : "Kullanıcının Mesajları"),
      ),
      body: Row(
        children: <Widget>[
          SideScreen(
            selectedScreen: selectedIndex,
            onSelectedChanged: onSelecteChange,
            user_d: widget.user,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (selectedIndex == SelectedScreen.infoScreen) {
                  return InfoCards(
                    selectedScreen: selectedIndex,
                    user_d: widget.user,
                  );
                } else {
                  return MessagesList(user_d: widget.user);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
