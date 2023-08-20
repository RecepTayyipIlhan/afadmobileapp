import 'dart:convert';
import 'dart:typed_data';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'package:afad_app/screens/mayday_call/components/place_icon.dart';
//import '../../services/location/get_loc.dart';
import '../../global_data.dart';
import '../../services/location/get_loc.dart';
//import 'components/all_requests.dart';
//import '../home/menu_page.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;

  const ChatPage({
    super.key,
    required this.server,
  });

  @override
  State<ChatPage> createState() => _ChatPage();
}

class Person {
  final String id;
  final String location;

  const Person(
    this.id,
    this.location,
  );
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  Loc latLon = Loc();
  //get location from gps

  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = <_Message>[];
  //List<_Message> messages = List<_Message>();

  String _messageBuffer = '';
  Person p = const Person("186", "41.208277°K 28.957777°D");

  final TextEditingController textEditingController = TextEditingController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection?.isConnected == true;

  bool isDisconnecting = false;

  bool zoom0 = true;
  bool zoom1 = true;
  bool zoom2 = true;
  bool zoom3 = true;

  @override
  void initState() {
    super.initState();

    print("addressss is ${widget.server?.address}");

    BluetoothConnection.toAddress(
      widget.server?.address,
    ).then(
      (con) {
        print('Connected to the device');
        connection = con;
        print("connection is connected: ${connection?.isConnected}");
        isConnecting = false;
        isDisconnecting = false;
        setState(() {});

        connection!.input?.listen(_onDataReceived).onDone(
          () {
            // Example: Detect which side closed the connection
            // There should be `isDisconnecting` flag to show are we are (locally)
            // in middle of disconnecting process, should be set before calling
            // `dispose`, `finish` or `close`, which all causes to disconnect.
            // If we except the disconnection, `onDone` should be fired as result.
            // If we didn't except this (no flag set), it means closing by remote.
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (mounted) {
              setState(() {});
            }
          },
        );
      },
    ).catchError(
      (error) {
        print('Cannot connect, exception occured');
        print(error.toString());
      },
    );
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // to avoid dead code warnings
    bool initialValue = () {
      return true;
    }();

    List loc = latLon.getLocation();
    print("-------------------------");
    print((loc).toString());
    print("------------");
    print((personList).toString());

    String lat = loc[0].toString();
    String lon = loc[1].toString();
    // String id = personList?[0]["id"];
    // TODO(adnanjpg)
    String id = "111";

    if (!isConnected || isConnecting) {
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
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          /* Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()));*/
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Afad Destek ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
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
                          "10 Ağustos, 2021",
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      //Search Bar
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Arama',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
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
                              onTap: isConnected
                                  ? () => sendMessage("$id,0,$lat,$lon")
                                  : null,
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Evdeyim",
                              imagePath: 'assets/icons/home.png',
                              onTap: isConnected
                                  ? () => sendMessage("$id,8,$lat,$lon")
                                  : null,
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Toplanma Alanı",
                              imagePath: 'assets/icons/meeting.png',
                              onTap: isConnected
                                  ? () => sendMessage("$id,9,$lat,$lon")
                                  : null,
                            ),
                          ),
                          LocationNotifyItem(
                            item: (
                              title: "Kayboldum",
                              imagePath: 'assets/icons/lost.png',
                              onTap: isConnected
                                  ? () => sendMessage("$id,10,$lat,$lon")
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
                                  Icon(Icons.more_horiz)
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
                                      onTap: isConnected
                                          ? () => sendMessage("$id,1,$lat,$lon")
                                          : null,
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Gıda Talebi",
                                      subtitle:
                                          "Şuanki konumunuza gıda gönderir",
                                      icon: Icons.food_bank_rounded,
                                      onTap: isConnected
                                          ? () => sendMessage("$id,2,$lat,$lon")
                                          : null,
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "İlaç Talebi",
                                      subtitle:
                                          "Şuanki konumunuza ilaç gönderir",
                                      icon: Icons.local_hospital,
                                      onTap: isConnected
                                          ? () => sendMessage("$id,3,$lat,$lon")
                                          : null,
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Barınma Talebi",
                                      subtitle:
                                          "Şuanki konumunuza barınma gönderir",
                                      icon: Icons.local_hotel_rounded,
                                      onTap: isConnected
                                          ? () => sendMessage("$id,4,$lat,$lon")
                                          : null,
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
                                  Icon(Icons.more_horiz)
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
                                      onTap: isConnected
                                          ? () => sendMessage("$id,5,$lat,$lon")
                                          : null,
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Yangın",
                                      subtitle:
                                          "Bu bilgi Afadın yangınları tespit etmesi için kullanılacaktır",
                                      icon: Icons.fireplace_rounded,
                                      onTap: isConnected
                                          ? () => sendMessage("$id,6,$lat,$lon")
                                          : null,
                                    ),
                                  ),
                                  HelpRequestItem(
                                    item: (
                                      title: "Enkaz",
                                      subtitle:
                                          "Bu bilgi Afadın enkazları tespit etmesi için kullanılacaktır",
                                      icon: Icons.house_siding_rounded,
                                      onTap: isConnected
                                          ? () => sendMessage("$id,7,$lat,$lon")
                                          : null,
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

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void printt(String text) {
    print(text.toString());
  }

  void sendMessage(String text) async {
    print("sendinggggg $text");

    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection?.output.add(
          Uint8List.fromList(
            utf8.encode("$text\r\n"),
          ),
        );
        await connection?.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });
      } catch (e) {
        // Ignore error, but notify state
        print("SEND MESSAGEE EROORRR $e");
        setState(() {});
      }
    }
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
