import 'dart:async';
import 'package:flutter/material.dart';
import 'package:afad_app/services/bluetooth/communication.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './SelectBondedDevicePage.dart';
import '../../screens/mayday_call/ChatPage.dart';

//import './ChatPage2.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "40:83:1D:28:81:48"; //B8:27:EB:F6:81:D1
  String _name = "iphone2"; //raspberrypi

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
        print("**********" + name);
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  // This code is just a example if you need to change page and you need to communicate to the raspberry again
  void init() async {
    Communication com = Communication();
    await com.connectBl(_address);
    print(_address);
    com.sendMessage("Hello");
    setState(() {});
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    BluetoothDevice b =
        new BluetoothDevice(name: "raspberrypi", address: "B8:27:EB:F6:81:D1");
    final BluetoothDevice selectedDevice = b;

    if (selectedDevice != null) {
      print('Connect -> selected ' + selectedDevice.address);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(server: b,)));
      /*Future.delayed(Duration.zero, () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(server: b,)));
      });*/

      //_startChat(context, selectedDevice);
    } else {
      print('------------------Connect -> no device selected');
      return Container();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Color(0xFFE63946),
      appBar: AppBar(

        backgroundColor: Color(0xFF003399).withOpacity(0.9),

        title: const Text('Lora Sensörüne Bağlanın'),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height/50,),
          Column(
            children: [
              ElevatedButton(
                child: Icon(Icons.bluetooth_audio_rounded,size: 45,color: _bluetoothState.isEnabled ? Colors.white: Colors.red.withOpacity(0.6),),
                onPressed: _bluetoothState.isEnabled ? () async {
                  final BluetoothDevice selectedDevice = b;
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      } ,
                    ),
                  );
                  //print(selectedDevice.name+","+selectedDevice.address+","+selectedDevice.bondState.toString()+","+selectedDevice.isConnected.toString()+","+selectedDevice.type.toString());
                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('----Connect -> no device selected');
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                  primary: _bluetoothState.isEnabled ?  Color(0xFF003399).withOpacity(0.7): Colors.white70,

                  shadowColor: Colors.blueAccent,
                  fixedSize: const Size(140, 140),
                  shape: const CircleBorder(),
                ),
              ),
              SizedBox(height: 10,),
              Text( _bluetoothState.isEnabled ? "Lora Sensörü Ara ": "Önce Blutoothu Aktif Edin", style: TextStyle(fontWeight:FontWeight.normal,fontSize: 17),),
            ],
          ),
          Container(
            color : Color(0xFF003399).withOpacity(0.9),
            height: size.height/3,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 15) ,
            child: ListView(
              children: <Widget>[
                Divider(color: Colors.white,thickness: 2),
                //ListTile(title: const Text('General')),
                SwitchListTile(
                  activeColor: Colors.white,
                  title: const Text("Bluetooth'u Aktif Edin",style: TextStyle(color: Colors.white),),
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();
                    };

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
                Divider(color: Colors.white,thickness: 2),
                ListTile(
                  title: const Text('Bluetooth Durumu',style: TextStyle(color: Colors.white)),
                  subtitle: Text( _bluetoothState.isEnabled ? "Açık":"Kapalı",style: TextStyle(color: Colors.white)),
                  //subtitle: Text(returnStatus(_bluetoothState)),
                  trailing: MaterialButton(
                    color: Colors.white,
                    child: const Text('Ayarlar'),
                    onPressed: () {
                      FlutterBluetoothSerial.instance.openSettings();
                    },
                  ),
                ),
                Divider(color: Colors.white,thickness: 2),

                /*ListTile(
                  title: const Text('Local adapter address'),
                  subtitle: Text(_address),
                ),
                ListTile(
                  title: const Text('Local adapter name'),
                  subtitle: Text(_name),
                  onLongPress: null,
                ),*/
                /*Divider(),
                ListTile(title: const Text('Devices discovery and connection')),
                ListTile(
                  title: RaisedButton(
                    child: const Text('Connect to paired device to chat'),
                    onPressed: () async {
                      final BluetoothDevice selectedDevice = b;
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectBondedDevicePage(checkAvailability: false);
                          },
                        ),
                      );
                      //print(selectedDevice.name+","+selectedDevice.address+","+selectedDevice.bondState.toString()+","+selectedDevice.isConnected.toString()+","+selectedDevice.type.toString());
                      if (selectedDevice != null) {
                        print('Connect -> selected ' + selectedDevice.address);
                        _startChat(context, selectedDevice);
                      } else {
                        print('------------------Connect -> no device selected');
                      }
                    },
                  ),
                ),*/

              ],
            ),
          ),


        ],
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}
