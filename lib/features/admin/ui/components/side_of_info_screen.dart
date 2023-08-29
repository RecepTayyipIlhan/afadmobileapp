import 'package:afad_app/features/admin/ui/detailed_person_page.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/features/auth/models/app_user.dart';

class SideScreen extends StatefulWidget {
  final AppUser user_d;
  final void Function(SelectedScreen) onSelectedChanged;
  final SelectedScreen selectedScreen;
  const SideScreen(
      {Key? key,
      required this.user_d,
      required this.selectedScreen,
      required this.onSelectedChanged})
      : super(key: key);

  @override
  State<SideScreen> createState() => _SideScreenState();
}

class _SideScreenState extends State<SideScreen> {
  void listTileTab(int index) {
    widget.onSelectedChanged(SelectedScreen.values[index]);
  }

  /*BoxDecoration tileDecoration() {
    return BoxDecoration(
      //borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
      border: Border.all(
        color: Colors.black54,
        width: 1.5, // Adjust the border width as needed
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    final img = widget.user_d.profilePicUrl;
    return Container(
      width: screen.width * 0.25,
      height: screen.height * 0.88,
      child: Column(
        children: <Widget>[
          ClipOval(
            child: SizedBox(
              height: 175,
              width: 175,
              child: img != null
                  ? Image.network(
                      img,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Theme.of(context).primaryColor,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.user_d.fullName,
            style: const TextStyle(
              fontFamily: "Roboto",
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.user_d.email,
            style: const TextStyle(
                fontFamily: "Roboto", color: Colors.black26, fontSize: 18),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  //decoration: tileDecoration(),
                  child: ListTile(
                    selected:
                        widget.selectedScreen == SelectedScreen.infoScreen,
                    selectedTileColor:
                        Colors.cyanAccent.shade100.withOpacity(0.2),
                    leading: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.black,
                    ),
                    title: const Center(
                        child: Text(
                      'Kullanıcı Bilgileri',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                    onTap: () => listTileTab(0),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //decoration: tileDecoration(),
                  child: ListTile(
                    selected:
                        widget.selectedScreen == SelectedScreen.messageScreen,
                    selectedTileColor:
                        Colors.cyanAccent.shade200.withOpacity(0.2),
                    leading:
                        const Icon(Icons.message_rounded, color: Colors.black),
                    title: const Center(
                        child: Text(
                      'Kullanıcının Mesajları',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                    onTap: () => listTileTab(1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
