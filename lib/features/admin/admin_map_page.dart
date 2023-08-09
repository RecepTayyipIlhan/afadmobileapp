import 'package:afad_app/ui/widgets/btns/secondary_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminMapPage extends StatefulWidget {
  const AdminMapPage({Key? key}) : super(key: key);

  @override
  State<AdminMapPage> createState() => _MyAppState();
}

class _MyAppState extends State<AdminMapPage> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  Set<Marker> _mapMarkers = {};
  int _selectedRowIndex = -1;
  var show = true;

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
            infoWindow: const InfoWindow(
              title: 'Enkaz Altındayım',
            ),
          ),
        );
      });
    }
  }

  void _loadAllMarkers() {
    _mapMarkers.clear();

    for (var i = 0; i < konumDataList.length; i++) {
      var loc = konumDataList[i].split(", ");
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(loc[0]), double.parse(loc[1])),
          infoWindow: const InfoWindow(
            title: 'Enkaz Altındayım',
          ),
        ),
      );
    }
  }


  /*void loadAllMarkers(List<String> markers){
    _mapMarkers.clear();
    setState(() {

      for (var i= 0; i<konumDataList.length; i++){
        var loc = markers[i].split(", ");
        _mapMarkers.add(
            Marker(markerId: MarkerId(DateTime.now().toString()),
              position: LatLng(double.parse(loc[0]), double.parse(loc[1])),
              infoWindow: const InfoWindow(
                title: 'Enkaz Altındayım',
              ),)
        );
      }

    });
  }*/



@override
  void initState() {
    // TODO: implement initState
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
                target: LatLng(41.0122, 28.976 ),
                zoom: 10.0,
              ),
              markers: _mapMarkers,
              onMapCreated: _onMapCreated,
            ),
          ),
          Builder(
            builder: (context) {
              if (!show) {
                return SecondaryBtn(
                  onPressed: () {
                    setState(() {
                      show = true;
                    });
                  },
                  eventName: '',
                  text: 'Gizle',
                );
              }
              return PositionedDirectional(
                end: 50,
                top: 50,
                child: Column(
                  children: [
                    SecondaryBtn(
                      onPressed: () {
                        setState(() {
                          show = false;
                        });
                      },
                      eventName: '',
                      text: 'Göster',
                    ),
                    Container(
                      color: Colors.white,
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
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
