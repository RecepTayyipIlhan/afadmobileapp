import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminMapPage extends StatefulWidget {
  const AdminMapPage({Key? key}) : super(key: key);

  @override
  State<AdminMapPage> createState() => _MyAppState();
}

class _MyAppState extends State<AdminMapPage> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _mapMarkers = {};

  LatLng? selectedLocation;
  List<String> konumDataList = [
    "41.086058, 28.918416",
    "41.087155418099776, 28.916931295935033",
    "39.75510570639219, 37.02975100383928",
    "37.381427550791805, 37.298054480432",
    "38.65255938228235, 39.43972522579789",
    "40.94337306283641, 39.96710905032397",
    "39.81118967341674, 42.09262566087216",
    "39.17365417753253, 34.16638597509952",
  ];

  int _selectedRowIndex = -1;

  void _onRowSelect(int index) {
    setState(() {
      _selectedRowIndex = index;

      if (index >= 0 && index < konumDataList.length) {
        var location = konumDataList[index].split(', ');
        selectedLocation =
            LatLng(double.parse(location[0]), double.parse(location[1]));
        print("Seçilen Konum: $selectedLocation");
      } else {
        selectedLocation = null;
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
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
              height: screen.size.height * 0.5,
              width: screen.size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screen.size.width * 0.4,
                    width: screen.size.width * 0.4,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(39.88204347624524, 31.56168212399377),
                        zoom: 12.0,
                      ),
                      //markers: Set<Marker>.of(markers),
                      markers: _mapMarkers,
                      onMapCreated: _onMapCreated,
                    ),
                  ),
                  Container(
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
                                var location = konumDataList[index].split(', ');
                                print("deneme :" +
                                    location[0] +
                                    " ---- " +
                                    location[1]);

                                CameraPosition cameraPosition = CameraPosition(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
