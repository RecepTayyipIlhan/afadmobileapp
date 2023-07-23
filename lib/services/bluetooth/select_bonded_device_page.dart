import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_device_list_entry.dart';

class SelectBondedDevicePage extends StatefulWidget {
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool checkAvailability;

  const SelectBondedDevicePage({super.key, this.checkAvailability = true});

  @override
  State<SelectBondedDevicePage> createState() => _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  // ignore: unused_field
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(BluetoothDevice device, this.availability)
      : super(
          address: device.address,
          name: device.name,
          type: device.type,
          isConnected: device.isConnected,
          bondState: device.bondState,
        );
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  //List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>();
  List<_DeviceWithAvailability> devices = <_DeviceWithAvailability>[];

  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final i = devices.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map((device) => BluetoothDeviceListEntry(
              device: device,
              rssi: device.rssi,
              enabled: device.availability == _DeviceAvailability.yes,
              onTap: () {
                Navigator.of(context).pop(device);
              },
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003399).withOpacity(0.9),
        title: const Text('Lora Cihazınızı Seçiniz'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen()));
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          _isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView(children: list),
    );
  }
}
