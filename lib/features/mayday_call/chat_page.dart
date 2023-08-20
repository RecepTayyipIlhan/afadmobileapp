import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:afad_app/ui/widgets/error_widget.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class Person {
  final String id;
  final String location;

  const Person(
    this.id,
    this.location,
  );
}

class _Message {
  String whom;
  String text;

  _Message(this.whom, this.text);
}

class ChatPage extends ConsumerStatefulWidget {
  final BluetoothDevice? server;

  const ChatPage({
    super.key,
    required this.server,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends ConsumerState<ChatPage> {
  LocationData? locationData;

  StreamSubscription<LocationData>? locationSubscription;

  Location? _locationObj;
  Location get locationObj {
    _locationObj ??= Location();
    _locationObj!.changeSettings(accuracy: LocationAccuracy.high);

    return _locationObj!;
  }

  void initLocation() async {
    locationSubscription = locationObj.onLocationChanged.listen(
      (LocationData currentLocation) {
        locationData = currentLocation;
      },
    );
  }

  Future<LocationData> getCurrentLocation() async {
    final loc = await locationObj.getLocation();
    locationData = loc;
    return loc;
  }

  BluetoothConnection? connection;

  final textEditingController = TextEditingController();

  bool get isConnected => connection != null && connection?.isConnected == true;

  void onSentMessageSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Mesaj gönderildi",
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void onSentMessageError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Mesaj gönderilemedi",
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<bool> sendMessageOfType(int type) async {
    final userid = ref.read(authProvider).appUser?.id;

    if (userid == null) {
      debugPrint("userid is null");

      onSentMessageError();
      return false;
    }

    final loc = locationData ?? await getCurrentLocation();

    final lat = loc.latitude, lon = loc.longitude;

    var message = "$userid,$type,$lat,$lon";

    debugPrint("sendinggggg $message");

    textEditingController.clear();

    try {
      final newMsg = Uint8List.fromList(
        utf8.encode("$message\r\n"),
      );
      connection?.output.add(newMsg);
      await connection?.output.allSent;

      setState(() {});

      onSentMessageSuccess();
      return true;
    } catch (e) {
      // Ignore error, but notify state
      debugPrint("SEND MESSAGEE EROORRR $e");
      setState(() {});

      onSentMessageError();
      return false;
    }
  }

  void initBtConnection() async {
    try {
      final con = await BluetoothConnection.toAddress(
        widget.server?.address,
      );

      debugPrint('Connected to the device');
      connection = con;
      debugPrint("connection is connected: ${connection?.isConnected}");
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    initLocation();
    initBtConnection();
    debugPrint("addressss is ${widget.server?.address}");
  }

  @override
  void dispose() {
    connection?.dispose();
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return const Scaffold(
        body: Center(
          child: Text('Bağlanıyor...'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).bgColorAfad,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final userid = ref.watch(authProvider).appUser?.id;

            if (userid == null) {
              return const Center(
                child: ErrWidget.empty(),
              );
            }

            return Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      BackButton(
                        color: Colors.white,
                      ),
                      Text(
                        "Afad Destek ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 25,
                    end: 25,
                    bottom: 25,
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 8,
                      ),
                      Row(children: <Widget>[
                        Text(
                          DateFormat('dd MMMM, yyyy', 'tr')
                              .format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      //Where are u
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Şuanda Nerdesin ? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          LocationNotifyItem(
                            item: (
                              title: "Enkaz Altındayım",
                              imagePath: 'assets/icons/sos.png',
                              onTap: () => sendMessageOfType(0),
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Evdeyim",
                              imagePath: 'assets/icons/home.png',
                              onTap: isConnected
                                  ? () => sendMessageOfType(8)
                                  : null,
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Toplanma Alanı",
                              imagePath: 'assets/icons/meeting.png',
                              onTap: isConnected
                                  ? () => sendMessageOfType(9)
                                  : null,
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Kayboldum",
                              imagePath: 'assets/icons/lost.png',
                              onTap: isConnected
                                  ? () => sendMessageOfType(10)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  child: Flexible(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Yardım Talepleri',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  HelpRequestItem(
                                    item: (
                                      title: "Ambulans",
                                      subtitle:
                                          "Şuanki konumunuza ambulans gönderir",
                                      icon: Icons.emergency,
                                      onTap: () => sendMessageOfType(1),
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Gıda Talebi",
                                      subtitle:
                                          "Şuanki konumunuza gıda gönderir",
                                      icon: Icons.food_bank_rounded,
                                      onTap: () => sendMessageOfType(2),
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "İlaç Talebi",
                                      subtitle:
                                          "Şuanki konumunuza ilaç gönderir",
                                      icon: Icons.local_hospital,
                                      onTap: () => sendMessageOfType(3),
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Barınma Talebi",
                                      subtitle:
                                          "Şuanki konumunuza barınma gönderir",
                                      icon: Icons.local_hotel_rounded,
                                      onTap: () => sendMessageOfType(4),
                                    ),
                                  ),
                                ].joinWidgetList(
                                  (index) => const SizedBox(
                                    height: 20,
                                  ),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'İhbarlar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  HelpRequestItem(
                                    item: (
                                      title: "Gaz Sızıntısı",
                                      subtitle:
                                          "Bu bilgi Afadın gaz sızıntılarını tespit etmesi için kullanılacaktır",
                                      icon: Icons.dangerous_outlined,
                                      onTap: () => sendMessageOfType(5),
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Yangın",
                                      subtitle:
                                          "Bu bilgi Afadın yangınları tespit etmesi için kullanılacaktır",
                                      icon: Icons.fireplace_rounded,
                                      onTap: () => sendMessageOfType(6),
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Enkaz",
                                      subtitle:
                                          "Bu bilgi Afadın enkazları tespit etmesi için kullanılacaktır",
                                      icon: Icons.house_siding_rounded,
                                      onTap: () => sendMessageOfType(7),
                                    ),
                                  ),
                                ].joinWidgetList(
                                  (index) => const SizedBox(
                                    height: 20,
                                  ),
                                ),
                              ),
                            ].joinWidgetList(
                              (index) => const SizedBox(
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HelpRequestItem extends StatelessWidget {
  final ({
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
  }) item;
  const HelpRequestItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Material(
        child: ListTile(
          tileColor: Colors.white,
          onTap: item.onTap,
          leading: Icon(
            item.icon,
            color: Theme.of(context).bgColorAfad,
          ),
          title: Text(
            item.title,
            style: TextStyle(color: Theme.of(context).bgColorAfad),
          ),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }
}

class LocationNotifyItem extends StatelessWidget {
  final ({
    String title,
    String imagePath,
    VoidCallback? onTap,
  }) item;
  const LocationNotifyItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: item.onTap,
          child: Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(item.imagePath),
                  scale: 0.2,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
