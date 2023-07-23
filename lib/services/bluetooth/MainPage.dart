import 'dart:async';
import 'package:flutter/material.dart';
import 'package:afad_app/services/bluetooth/communication.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './SelectBondedDevicePage.dart';
import '../../screens/mayday_call/ChatPage.dart';

//import './ChatPage2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "00:19:07:34:C2:BA"; //B8:27:EB:F6:81:D1
  String _name = "HC-06"; //raspberrypi

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
      if ((await FlutterBluetoothSerial.instance.isEnabled) == true) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then(
        (address) {
          if (address == null) return;
          setState(
            () {
              _address = address;
            },
          );
        },
      );
    });

    FlutterBluetoothSerial.instance.name.then(
      (name) {
        if (name == null) return;
        setState(
          () {
            _name = name;
            debugPrint("**********$name");
          },
        );
      },
    );

    // Listen for futher state changes
    FlutterBluetoothSerial.instance.onStateChanged().listen(
      (BluetoothState state) {
        setState(
          () {
            _bluetoothState = state;
          },
        );
      },
    );
  }

  // This code is just a example if you need to change page and you need to communicate to the raspberry again
  void init() async {
    Communication com = Communication();
    await com.connectBl(_address);
    debugPrint(_address);
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
        const BluetoothDevice(name: "HC-06", address: "00:19:07:34:C2:BA");
    final BluetoothDevice selectedDevice = b;

    if (selectedDevice != null) {
      debugPrint('Connect -> selected ${selectedDevice.address}');
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(server: b,)));
      /*Future.delayed(Duration.zero, () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(server: b,)));
      });*/

      //_startChat(context, selectedDevice);
    } else {
      debugPrint('------------------Connect -> no device selected');
      return Container();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Color(0xFFE63946),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003399).withOpacity(0.9),
        title: const Text('Lora Sensörüne Bağlanın'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height / 50,
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: _bluetoothState.isEnabled
                    ? () async {
                        final BluetoothDevice selectedDevice = b;
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const SelectBondedDevicePage(
                                  checkAvailability: false);
                            },
                          ),
                        );
                        //debugPrint(selectedDevice.name+","+selectedDevice.address+","+selectedDevice.bondState.toString()+","+selectedDevice.isConnected.toString()+","+selectedDevice.type.toString());
                        if (selectedDevice != null) {
                          debugPrint(
                              'Connect -> selected ${selectedDevice.address}');
                          _startChat(context, selectedDevice);
                        } else {
                          debugPrint('----Connect -> no device selected');
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _bluetoothState.isEnabled
                      ? const Color(0xFF003399).withOpacity(0.7)
                      : Colors.white70,
                  shadowColor: Colors.blueAccent,
                  fixedSize: const Size(140, 140),
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.bluetooth_audio_rounded,
                  size: 45,
                  color: _bluetoothState.isEnabled
                      ? Colors.white
                      : Colors.red.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _bluetoothState.isEnabled
                    ? "Lora Sensörü Ara "
                    : "Önce Blutoothu Aktif Edin",
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
              ),
            ],
          ),
          Container(
            color: const Color(0xFF003399).withOpacity(0.9),
            height: size.height / 3,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ListView(
              children: <Widget>[
                const Divider(color: Colors.white, thickness: 2),
                //ListTile(title: const Text('General')),
                SwitchListTile(
                  activeColor: Colors.white,
                  title: const Text(
                    "Bluetooth'u Aktif Edin",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value) {
                        await FlutterBluetoothSerial.instance.requestEnable();
                      } else {
                        await FlutterBluetoothSerial.instance.requestDisable();
                      }
                    }


                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
                const Divider(color: Colors.white, thickness: 2),
                ListTile(
                  title: const Text('Bluetooth Durumu',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(_bluetoothState.isEnabled ? "Açık" : "Kapalı",
                      style: const TextStyle(color: Colors.white)),
                  //subtitle: Text(returnStatus(_bluetoothState)),
                  trailing: MaterialButton(
                    color: Colors.white,
                    child: const Text('Ayarlar'),
                    onPressed: () {
                      FlutterBluetoothSerial.instance.openSettings();
                    },
                  ),
                ),
                const Divider(color: Colors.white, thickness: 2),

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
                      //debugPrint(selectedDevice.name+","+selectedDevice.address+","+selectedDevice.bondState.toString()+","+selectedDevice.isConnected.toString()+","+selectedDevice.type.toString());
                      if (selectedDevice != null) {
                        debugPrint('Connect -> selected ' + selectedDevice.address);
                        _startChat(context, selectedDevice);
                      } else {
                        debugPrint('------------------Connect -> no device selected');
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
