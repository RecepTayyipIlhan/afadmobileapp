import 'dart:async';
import 'package:afad_app/constants.dart';
import 'package:afad_app/ui/widgets/btns/primary_btn.dart';
import 'package:afad_app/ui/widgets/btns/secondary_btn.dart';
import 'package:afad_app/ui/widgets/btns/tertiary_btn.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/services/bluetooth/communication.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'select_bonded_device_page.dart';
import '../../features/mayday_call/chat_page.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _MainPage();
}

class _MainPage extends State<DevicesScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = deviceAddress;
  // ignore: unused_field
  String _name = deviceName;

  @override
  void initState() {
    super.initState();

    init();

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
            print("**********$name");
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
  Communication com = Communication();
  void init() async {
    await com.connectToBluetooth(_address);
    print("address is " + _address);
    com.sendMessage("Hello");
    setState(() {});
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    com.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BluetoothDevice b = const BluetoothDevice(
      name: deviceName,
      address: deviceAddress,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Color(0xFFE63946),
      appBar: AppBar(
        title: const Text('Cihazlarım'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: _bluetoothState.isEnabled
                    ? () async {
                        final navigator = Navigator.of(context);

                        await navigator.push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const SelectBondedDevicePage(
                                  checkAvailability: false);
                            },
                          ),
                        );
                        _startChat(navigator, b);
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
              Text(
                _bluetoothState.isEnabled
                    ? "Lora Sensörü Ara "
                    : "Önce Blutoothu Aktif Edin",
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 17),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: const Text(
                    'Bluetooth Durumu',
                  ),
                  subtitle: Text(
                    _bluetoothState.isEnabled ? "Açık" : "Kapalı",
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

                    // FlutterBluetoothSerial.instance.openSettings();

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
        ].joinWidgetList(
          (index) => const SizedBox(
            height: 20,
          ),
        ),
      ),
    );
  }

  void _startChat(NavigatorState navigator, BluetoothDevice server) {
    navigator.push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}
