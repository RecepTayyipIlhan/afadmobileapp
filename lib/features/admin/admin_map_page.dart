import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/prov/auth_prov.dart';
import 'detailed_person_page.dart';

class AdminMapPage extends ConsumerStatefulWidget {
  const AdminMapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminMapPage> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<AdminMapPage> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  // ignore: prefer_final_fields
  Set<Marker> _mapMarkers = {};
  int _selectedRowIndex = -1;
  var show = true;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.086058, 28.918416),
    zoom: 10.0,
  );

  List<String> konumDataList = [
    "41.086058, 28.918416",
    "40.97395773143526, 29.0648756708183",
    "40.984714124858435, 29.13525683248053",
    "41.0101078007604, 28.92720324561098",
    "40.98730576471651, 28.85235888907946",
    "41.08183089187888, 29.02161699811633",
    "41.01347561463252, 28.80189044683114",
    "41.08778272358708, 29.038783134935485",
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _routeDetailedPersonPage() {
    GoRouter.of(context).pushNamed(
      RouteTable.rAdminDetailedPersonPage,
    );
  }

  void _onRowSelect(int index) {
    setState(() {
      _selectedRowIndex = index;

      if (index >= 0 && index < konumDataList.length) {
        var location = konumDataList[index].split(', ');
        selectedLocation =
            LatLng(double.parse(location[0]), double.parse(location[1]));
        print("Seçilen Konum: $selectedLocation");
        _addMarker(location[0], location[1]);
      } else {
        selectedLocation = null;
        _loadAllMarkers();
      }
    });
  }

  void _addMarker(String lat, String loc) {
    if (mapController != null) {
      setState(() {
        _mapMarkers.clear();
        _mapMarkers.add(
          Marker(
            markerId: MarkerId(DateTime.now().toString()),
            position: LatLng(double.parse(lat), double.parse(loc)),
            infoWindow: InfoWindow(
              title: 'Enkaz Altındayım',
              onTap: _routeDetailedPersonPage,
            ),
          ),
        );
      });
    }
  }

  void _loadAllMarkers() {
    _mapMarkers.clear();
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    for (var i = 0; i < konumDataList.length; i++) {
      var loc = konumDataList[i].split(", ");
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(loc[0]), double.parse(loc[1])),
          infoWindow: InfoWindow(
            title: 'Enkaz Altındayım',
            onTap: _routeDetailedPersonPage,
          ),
        ),
      );
    }
  }

  void logout() async {
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Çıkış Yap',
          ),
          content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).error),
              ),
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );

    if (res == true) {
      ref.read(authProvider.notifier).logout();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAllMarkers();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screen.size.height,
            width: screen.size.width,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(41.0122, 28.976),
                zoom: 10.0,
              ),
              markers: _mapMarkers,
              onMapCreated: _onMapCreated,
            ),
          ),
          PositionedDirectional(
            end: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      child: Text(show ? 'Gizle' : 'Göster'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Theme.of(context).error),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: logout,
                      child: const Text('Çıkış Yap'),
                    ),
                  ].joinWidgetList(
                    (index) => const SizedBox(width: 10),
                  ),
                ),
                if (show) ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      height: screen.size.width * 0.4,
                      width: screen.size.width * 0.4,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(label: Text("Id")),
                            DataColumn(label: Text("İsim")),
                            DataColumn(label: Text("Tür")),
                            DataColumn(label: Text("Mesaj")),
                            DataColumn(label: Text("Konum")),
                          ],
                          rows: List<DataRow>.generate(
                            konumDataList.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text("142")),
                                DataCell(Text("Recep Tayyip")),
                                DataCell(Text("İhbar")),
                                DataCell(Text("Enkaz Altı")),
                                DataCell(Text(konumDataList[index])),
                              ],
                              onSelectChanged: (selected) {
                                _onRowSelect(selected! ? index : -1);
                                if (selected) {
                                  var location =
                                      konumDataList[index].split(', ');
                                  print("deneme :" +
                                      location[0] +
                                      " ---- " +
                                      location[1]);

                                  CameraPosition cameraPosition =
                                      CameraPosition(
                                    target: LatLng(double.parse(location[0]),
                                        double.parse(location[1])),
                                    zoom: 15.0,
                                  );

                                  mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          cameraPosition));
                                  _addMarker(location[0], location[1]);

                                  setState(() {});
                                }
                              },
                              selected: index == _selectedRowIndex,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ].joinWidgetList(
                (index) => const SizedBox(
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
