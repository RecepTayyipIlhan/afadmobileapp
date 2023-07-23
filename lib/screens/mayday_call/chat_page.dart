import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:afad_app/screens/home/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'package:afad_app/screens/mayday_call/components/place_icon.dart';
//import '../../services/location/get_loc.dart';
import '../../services/location/get_loc.dart';
//import 'components/all_requests.dart';
import 'package:afad_app/person.dart';
//import '../home/menu_page.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;
  //final Function() foo;

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
  MenuScreen ms = const MenuScreen();
  //get location from gps

  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = <_Message>[];
  //List<_Message> messages = List<_Message>();

  String _messageBuffer = '';
  Person p = const Person("186", "41.208277°K 28.957777°D");

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

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

    BluetoothConnection.toAddress(
      widget.server?.address,
    ).then(
      (connection) {
        debugPrint('Connected to the device');
        connection = connection;
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });

        connection.input?.listen(_onDataReceived).onDone(
          () {
            // Example: Detect which side closed the connection
            // There should be `isDisconnecting` flag to show are we are (locally)
            // in middle of disconnecting process, should be set before calling
            // `dispose`, `finish` or `close`, which all causes to disconnect.
            // If we except the disconnection, `onDone` should be fired as result.
            // If we didn't except this (no flag set), it means closing by remote.
            if (isDisconnecting) {
              debugPrint('Disconnecting locally!');
            } else {
              debugPrint('Disconnected remotely!');
            }
            if (mounted) {
              setState(() {});
            }
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('Cannot connect, exception occured');
        debugPrint(error);
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
    var size = MediaQuery.of(context).size;

    // to avoid dead code warnings
    bool initialValue = () {
      return true;
    }();

    List loc = latLon.getLocation();
    debugPrint("-------------------------");
    debugPrint((loc).toString());
    debugPrint("------------");
    debugPrint((personList).toString());

    String lat = loc[0].toString();
    String lon = loc[1].toString();
    String id = personList?[0]["id"];

    // final List<Row> list = messages.map((message) {
    //   return Row(
    //     mainAxisAlignment: message.whom == clientID
    //         ? MainAxisAlignment.end
    //         : MainAxisAlignment.start,
    //     children: <Widget>[
    //       Container(
    //         padding: const EdgeInsets.all(12.0),
    //         margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
    //         width: 222.0,
    //         decoration: BoxDecoration(
    //             color:
    //                 message.whom == clientID ? Colors.blueAccent : Colors.grey,
    //             borderRadius: BorderRadius.circular(7.0)),
    //         child: Text(
    //             (text) {
    //               return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
    //             }(message.text.trim()),
    //             style: const TextStyle(color: Colors.white)),
    //       ),
    //     ],
    //   );
    // }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF003399),
      /*appBar: AppBar(
          backgroundColor: Color(0xFFE63946),
          title: (isConnecting
              ? Text('Connecting chat to ' + widget.server.name + '...')
              : isConnected
                  ? Text('Afad Serverına Bağlandı ' + widget.server.name)
                  : Text('Afad Serverına Bağlandı ' + widget.server.name))),*/
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Afad Destek ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              /* Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));*/
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                      ]),
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
                      Column(
                        children: [
                          GestureDetector(
                            onTap: isConnected
                                ? () => sendMessage("$id,0,$lat,$lon")
                                : null,

                            /*onTap: () {
                              isConnected
                                  ? () =>
                                  sendMessage(id + "," + "0" + "," +lat+ ","+lon)
                                  : null;

                              setState(() {
                                zoom0 = !zoom0;
                              });
                            },*/
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              //color: Colors.amber,
                              height: zoom0 ? 50 : 60,
                              width: zoom0 ? 50 : 60,

                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],

                                color: Colors.white,
                                //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 700),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                  image: DecorationImage(
                                    scale: 0.2,
                                    alignment: Alignment.topCenter,
                                    image: AssetImage("assets/icons/sos.png"),
                                    // opacity: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Enkaz Altındayım",
                            style: TextStyle(
                              color: Colors.white,
                              //color: _initialValue ? Colors.white : Colors.black,
                              fontSize: initialValue ? 12 : 13,
                              fontWeight: initialValue
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: isConnected
                                ? () => sendMessage("$id,8,$lat,$lon")
                                : null,
                            /*onTap: () {
                              isConnected
                                  ? () =>
                                  sendMessage(id + "," + "8" + "," +lat+ ","+lon)
                                  : null;
                              setState(() {
                                zoom1 = !zoom1;
                              });
                            },*/
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              //color: Colors.amber,
                              height: zoom1 ? 50 : 60,
                              width: zoom1 ? 50 : 60,

                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],

                                color: Colors.white,
                                //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 700),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                  image: DecorationImage(
                                    scale: 0.2,
                                    alignment: Alignment.topCenter,
                                    image: AssetImage("assets/icons/home.png"),
                                    // opacity: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Evdeyim",
                            style: TextStyle(
                              color: Colors.white,
                              //color: _initialValue ? Colors.white : Colors.black,
                              fontSize: initialValue ? 12 : 13,
                              fontWeight: initialValue
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: isConnected
                                ? () => sendMessage("$id,9,$lat,$lon")
                                : null,
                            /*onTap: () {

                              isConnected
                                  ? () =>
                                  sendMessage(id + "," + "9" + "," +lat+ ","+lon)
                                  : null;
                              setState(() {
                                zoom2 = !zoom2;
                              });
                            },*/
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              //color: Colors.amber,
                              height: zoom2 ? 50 : 60,
                              width: zoom2 ? 50 : 60,

                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],

                                color: Colors.white,
                                //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 700),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                  image: DecorationImage(
                                    scale: 0.2,
                                    alignment: Alignment.topCenter,
                                    image:
                                        AssetImage("assets/icons/meeting.png"),
                                    // opacity: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Toplanma Alanı",
                            style: TextStyle(
                              color: Colors.white,
                              //color: _initialValue ? Colors.white : Colors.black,
                              fontSize: initialValue ? 12 : 13,
                              fontWeight: initialValue
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: isConnected
                                ? () => sendMessage("$id,10,$lat,$lon")
                                : null,
                            /*onTap: () {
                              isConnected
                                  ? () =>
                                  sendMessage(id + "," + "10" + "," +lat+ ","+lon)
                                  : null;
                              setState(() {
                                zoom3 = !zoom3;
                              });
                            },*/
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              //color: Colors.amber,
                              height: zoom3 ? 50 : 60,
                              width: zoom3 ? 50 : 60,

                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],

                                color: Colors.white,
                                //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 700),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                                  image: DecorationImage(
                                    scale: 0.2,
                                    alignment: Alignment.topCenter,
                                    image: AssetImage("assets/icons/lost.png"),
                                    // opacity: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Kayboldum",
                            style: TextStyle(
                              color: Colors.white,
                              //color: _initialValue ? Colors.white : Colors.black,
                              fontSize: initialValue ? 12 : 13,
                              fontWeight: initialValue
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          )
                        ],
                      ),

                      /*PlaceIcon(
                        path: "assets/icons/home.png",
                        title: "Evdeyim",
                        //value: x,
                      ),
                      PlaceIcon(
                        path: "assets/icons/meeting.png",
                        title: "Toplanma Alanı",
                      ),
                      PlaceIcon(
                        path: "assets/icons/lost.png",
                        title: "Kayboldum",
                      ),*/
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
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          width: size.width,
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
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,1,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.emergency,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Ambulans",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Şuanki konumunuza ambulans gönderir"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,2,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.food_bank_rounded,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Gıda Talebi",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Şuanki konumunuza gıda yardımı gönderir"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,3,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.local_hospital,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "İlaç Talebi",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Şuanki konumunuza ilaç yardımı gönderir"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,4,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.local_hotel_rounded,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Barınma Talebi",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Bu bilgiyi Afad size en uygun barınma yerlerine Yönlendirmek için kullanıcaktır"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
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
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,5,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.dangerous_outlined,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Gaz Kaçağı",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Bu bilgi Afadın gaz kaçaklarını tespit edebilmesi için kullanılıcaktır"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,6,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.fireplace_rounded,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Yangın",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Konumunun Yakınında yangın varsa basınız."),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    onPressed: isConnected
                                        ? () => sendMessage("$id,7,$lat,$lon")
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const ListTile(
                                        leading: Icon(
                                          Icons.house_siding_rounded,
                                          color: Color(0xFF003399),
                                        ),
                                        title: Text(
                                          "Enkaz",
                                          style: TextStyle(
                                              color: Color(0xFF003399)),
                                        ),
                                        subtitle: Text(
                                            "Yakınımda enkaz altında kurtarılmayı bekleyen insanlar var"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
    debugPrint(text);
  }

  void sendMessage(String text) async {
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

        Future.delayed(
          const Duration(
            milliseconds: 333,
          ),
        ).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(
                milliseconds: 333,
              ),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}

class HelpCard extends StatelessWidget {
  final String title;
  final String path;

  const HelpCard({
    super.key,
    required this.title,
    required this.path,
  });

  void cardPressed(var title, BuildContext context) {
    switch (title) {
      case "Ev":
        debugPrint("Evdeyim");
        break;
      case "Toplanma Alanaı":
        debugPrint("Toplanma Alanındayım");
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
      onPressed: () => cardPressed(title, context),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
