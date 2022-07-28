import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:afad_app/screens/mayday_call/components/place_icon.dart';

import '../home/menu_page.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class Person {
  String id;
  String location;

  Person(String id, String location) {
    this.id = id;
    this.location = location;
  }
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = <_Message>[];
  //List<_Message> messages = List<_Message>();

  String _messageBuffer = '';
  Person p = Person("186", "41.208277°K 28.957777°D");

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
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
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  int location;
  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFE63946),
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
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Text(
                      "Afad Destek ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,)
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: <Widget>[
                    Text(
                      "25 July, 2021",
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  //Search Bar
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Row(
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
                  SizedBox(
                    height: 20,
                  ),
                  //Where are u
                  Row(
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PlaceIcon(
                        path: "assets/icons/home.png",
                        title: "Evdeyim",
                      ),
                      PlaceIcon(
                        path: "assets/icons/assembly-point.png",
                        title: "Toplanma Alanı",
                      ),
                      PlaceIcon(
                        path: "assets/icons/lost.png",
                        title: "Kayboldum",
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /*GestureDetector(
                          onTap:(){print("debeeeee");} ,
                          child: Icon(
                            Icons.minimize_rounded,
                            color: Colors.grey,
                          ),
                        ),*/
                        Container(
                          color: Colors.grey[200],
                          width: size.width,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.emergency,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Ambulans",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle:
                                      Text("Şuanki konumunuza ambulans gönderir"),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.food_bank_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Gıda Talebi",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle:
                                      Text("Şuanki konumunuza gıda yardımı gönderir"),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.local_hospital,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "İlaç Talebi",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle:
                                      Text("Şuanki konumunuza ilaç yardımı gönderir"),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.local_hotel_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Barınma Talebi",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle: Text(
                                      "Bu bilgiyi Afad size en uygun barınma yerlerine Yönlendirmek için kullanıcaktır"),
                                ),
                              ),

                              //ikinci sayfa
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house_siding_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Enkaz",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle: Text(
                                      "Yakınımda enkaz altında kurtarılmayı bekleyen insanlar var"),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.fireplace_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Yangın",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle: Text("Konumumun yakınlarında yangın var"),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.dangerous_outlined,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Gaz Kaçağı",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  subtitle: Text(
                                      "Bu bilgi Afadın gaz kaçaklarını tespit edebilmesi için kullanılıcaktır"),
                                ),
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

            /* Container(
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.amberAccent),
                  child: Text('help'),
                  onPressed: isConnected
                      ? () =>
                          _sendMessage(p.id + "," + " 0" + ", " + p.location)
                      : null),
            ),
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  child: Text('Aid'),
                  onPressed: isConnected
                      ? () =>
                          _sendMessage(p.id + "," + " 1" + ", " + p.location)
                      : null),
            ),
            Container(
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.greenAccent),
                  child: Text('Water'),
                  onPressed: isConnected
                      ? () =>
                          _sendMessage(p.id + "," + " 2" + ", " + p.location)
                      : null),
            ),
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Food'),
                  onPressed: isConnected
                      ? () =>
                          _sendMessage(p.id + "," + " 3" + ", " + p.location)
                      : null),
            ),*/
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
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

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
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
    Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key);

  void card_pressed(var title, BuildContext context) {
    switch (title) {
      case "Ev":
        print("Evdeyim");
        break;
      case "Toplanma Alanaı":
        print("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed: () => card_pressed(title, context),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
