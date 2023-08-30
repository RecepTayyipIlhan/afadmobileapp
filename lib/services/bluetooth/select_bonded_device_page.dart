import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_device_list_entry.dart';

enum DeviceAvailability {
  // ignore: unused_field
  no,
  maybe,
  yes,
}

class DeviceWithAvailability extends BluetoothDevice {
  DeviceAvailability availability;
  int? rssi;

  DeviceWithAvailability(BluetoothDevice device, this.availability)
      : super(
          address: device.address,
          name: device.name,
          type: device.type,
          isConnected: device.isConnected,
          bondState: device.bondState,
        );

  bool get isFake => address == fakeViewDeviceId;
}

const fakeViewDeviceId = "33:44:EE:YY";

class SelectBondedDevicePage extends StatefulWidget {
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool initiallyCheckAvailability;

  const SelectBondedDevicePage(
      {super.key, this.initiallyCheckAvailability = true});

  @override
  State<SelectBondedDevicePage> createState() => _SelectBondedDevicePage();
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  bool viewFakeDevice = false;

  void toggleViewFakeDevice() {
    setState(() {
      viewFakeDevice = !viewFakeDevice;
    });
  }

  List<DeviceWithAvailability> devices = <DeviceWithAvailability>[];

  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.initiallyCheckAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    initBondedDevices();
  }

  FlutterBluetoothSerial get bluetooth => FlutterBluetoothSerial.instance;

  Future<void> initBondedDevices() async {
    // final bondedDevs = await bluetooth.getBondedDevices();
    // devices = bondedDevs
    //     .map(
    //       (device) => _DeviceWithAvailability(
    //         device,
    //         widget.checkAvailability
    //             ? _DeviceAvailability.maybe
    //             : _DeviceAvailability.yes,
    //       ),
    //     )
    //     .toList();
    // setState(() {});
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    print("startDiscovery()");

    final discStream = bluetooth.startDiscovery();
    _discoveryStreamSubscription = discStream.listen(
      (r) {
        final alreadyExistingDeviceIndex = devices.indexWhere(
          (device) => device.address == r.device.address,
        );

        if (alreadyExistingDeviceIndex != -1) {
          devices[alreadyExistingDeviceIndex].rssi = r.rssi;
        } else {
          devices.add(
            DeviceWithAvailability(
              r.device,
              DeviceAvailability.yes,
            ),
          );
        }

        print(devices.toString());
        setState(() {});
      },
    );

    _discoveryStreamSubscription?.onDone(
      () {
        _isDiscovering = false;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedDevs = [
      ...devices,
      ...[
        if (viewFakeDevice)
          DeviceWithAvailability(
            const BluetoothDevice(
              name: "ESP32testf",
              address: fakeViewDeviceId,
            ),
            DeviceAvailability.yes,
          ),
      ]
    ];
    // put the device names "ESP32test"
    sortedDevs.sort(
      (d1, d2) => d1.name?.startsWith("ESP32test") == true ? -1 : 1,
    );
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onLongPress: () {
            toggleViewFakeDevice();
          },
          child: const Text(
            'Lora Cihazınızı Seçiniz',
          ),
        ),
        actions: <Widget>[
          if (_isDiscovering)
            FittedBox(
              child: Container(
                height: 10,
                width: 10,
                margin: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: _restartDiscovery,
            )
        ],
      ),
      body: ListView(
        children: sortedDevs.map(
          (device) {
            return BluetoothDeviceListEntry(
              device: device,
              rssi: device.rssi,
              enabled: device.availability == DeviceAvailability.yes,
              onTap: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);
                if (!device.isFake && !device.isBonded) {
                  final isBondedSuccess = await bluetooth.bondDeviceAtAddress(
                    device.address,
                  );

                  if (isBondedSuccess == true) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Bağlantı Başarılı",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Bağlantı Başarısız",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }

                navigator.pop(device);
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
