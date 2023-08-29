import 'dart:convert';

import 'package:afad_app/features/admin/models/map_style.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:afad_app/features/admin/models/il_ilce_model.dart';
import '../models/admin_map_state.dart';

const mapStyle = MapStyle(
  styleItems: [
    MapStyleItem(
      elementType: "geometry",
      stylers: [
        {"color": "#1d2c4d"}
      ],
    ),
    MapStyleItem(
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#8ec3b9"}
      ],
    ),
    MapStyleItem(
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#1a3646"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative",
      elementType: "geometry",
      stylers: [
        {"visibility": "off"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative.country",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#4b6878"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative.land_parcel",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#64779e"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative.province",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#4b6878"}
      ],
    ),
    MapStyleItem(
      featureType: "landscape.man_made",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#334e87"}
      ],
    ),
    MapStyleItem(
      featureType: "landscape.natural",
      elementType: "geometry",
      stylers: [
        {"color": "#023e58"}
      ],
    ),
    MapStyleItem(
      featureType: "poi",
      stylers: [
        {"visibility": "off"}
      ],
    ),
    MapStyleItem(
      featureType: "poi",
      elementType: "geometry",
      stylers: [
        {"color": "#283d6a"}
      ],
    ),
    MapStyleItem(
      featureType: "poi",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#6f9ba5"}
      ],
    ),
    MapStyleItem(
      featureType: "poi",
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#1d2c4d"}
      ],
    ),
    MapStyleItem(
      featureType: "poi.park",
      elementType: "geometry.fill",
      stylers: [
        {"color": "#023e58"}
      ],
    ),
    MapStyleItem(
      featureType: "poi.park",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#3C7680"}
      ],
    ),
    MapStyleItem(
      featureType: "road",
      elementType: "geometry",
      stylers: [
        {"color": "#304a7d"}
      ],
    ),
    MapStyleItem(
      featureType: "road",
      elementType: "labels.icon",
      stylers: [
        {"visibility": "off"}
      ],
    ),
    MapStyleItem(
      featureType: "road",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#98a5be"}
      ],
    ),
    MapStyleItem(
      featureType: "road",
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#1d2c4d"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "geometry",
      stylers: [
        {"color": "#2c6675"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#255763"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#b0d5ce"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#023e58"}
      ],
    ),
    MapStyleItem(
      featureType: "transit",
      stylers: [
        {"visibility": "off"}
      ],
    ),
    MapStyleItem(
      featureType: "transit",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#98a5be"}
      ],
    ),
    MapStyleItem(
      featureType: "transit",
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#1d2c4d"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.line",
      elementType: "geometry.fill",
      stylers: [
        {"color": "#283d6a"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.station",
      elementType: "geometry",
      stylers: [
        {"color": "#3a4762"}
      ],
    ),
    MapStyleItem(
      featureType: "water",
      elementType: "geometry",
      stylers: [
        {"color": "#0e1626"}
      ],
    ),
    MapStyleItem(
      featureType: "water",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#4e6d70"}
      ],
    ),
  ],
);

final adminMapStateProvider =
    StateNotifierProvider<AdminMapStateNotifier, AdminMapState>(
  AdminMapStateNotifier.new,
);

class AdminMapStateNotifier extends StateNotifier<AdminMapState> {
  final Ref ref;
  AdminMapStateNotifier(this.ref) : super(AdminMapState.initial());

  void onMapCreated(GoogleMapController controller) async {
    state = state.copyWith(mapController: controller);

    final st = json.encode(mapStyle.toJsonForMap());
    state.mapController?.setMapStyle(st);
  }

  List<DataColumn> get dataTableColumns => <DataColumn>[
        const DataColumn(
          label: Text("İsim"),
        ),
        const DataColumn(
          label: Text("Talep"),
          /* onSort: (columnIndex, ascending) {
            state = state.copyWith(
              sortColumnIndex: columnIndex,
            );
            state = state.copyWith(
              sortAscending: ascending,
            );
            if (ascending) {
              state.messages.sort((a, b) => a.mt.index.compareTo(b.mt.index));
            } else {
              state.messages.sort((a, b) => b.mt.index.compareTo(a.mt.index));
            }
          },*/
        ),
        const DataColumn(label: Text("İl")),
        const DataColumn(label: Text("İlçe")),
      ];

  void _routeDetailedPersonPage(BuildContext context, AppUser user) {
    GoRouter.of(context).pushNamed(
      RouteTable.rAdminDetailedPersonPage,
      extra: user,
    );
  }

  void toggleShow() {
    state = state.copyWith(
      show: !state.show,
    );
  }

  void onSelectChanged({
    required bool? selected,
    required int index,
    required BuildContext context,
  }) {
    onRowSelect(
      index: selected! ? index : -1,
      context: context,
    );
    if (selected) {
      //var location = konumDataList[index].split(', ');
      var location = state.messages[index].loc;
      var locationLatLng = LatLng(location.latitude, location.longitude);

      CameraPosition cameraPosition = CameraPosition(
        target: locationLatLng,
        zoom: 15.0,
      );

      state.mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          cameraPosition,
        ),
      );

      _removeOtherMarkers(
        index: index,
        context: context,
      );
    } else {
      _loadAllMarkers(context: context);
    }
  }

  void onRowSelect({
    required int index,
    required BuildContext context,
  }) {
    state = state.copyWith(selectedRowIndex: index);

    if (index >= 0 && index < state.messages.length) {
      final location = state.messages[index].loc;
      final locationLatLng = LatLng(location.latitude, location.longitude);

      state = state.copyWith(
        selectedLocation: locationLatLng,
      );

      print("Seçilen Konum: $state.selectedLocation");
      // _addMarker(
      //   loc: locationLatLng,
      //   context: context,
      // );
    } else {
      state = state.copyWith(selectedLocation: null);
      _resetCameraToDefault();
    }
  }

  void _removeOtherMarkers({
    required int index,
    required BuildContext context,
  }) {
    if (state.mapController != null) {
      state = state.copyWith(mapMarkers: {
        _markerFromMessage(
          index: index,
          context: context,
        ),
      });
    }
  }

  void _resetCameraToDefault() {
    state.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        state.defaultCamerapPosition,
      ),
    );
  }

  AppUser? queryUser({
    required String ui,
  }) {
    try {
      AppUser user = state.users.firstWhere((element) => element.id == ui);
      return user;
    } catch (e) {
      return null;
    }
  }

  Marker _markerFromMessage({
    required int index,
    required BuildContext context,
  }) {
    final message = state.messages[index];

    final location = message.loc;
    final locationLatLng = LatLng(location.latitude, location.longitude);

    AppUser user = state.users.firstWhere(
      (element) => element.id == message.ui,
    );

    return Marker(
      markerId: MarkerId(index.toString()),
      position: locationLatLng,
      infoWindow: InfoWindow(
        title: 'Enkaz Altındayım',
        onTap: () {
          _routeDetailedPersonPage(context, user);
        },
      ),
    );
  }

  String getMessageFromEnum(int enum_index) {
    MessageType mt = MessageType.values[enum_index];
    switch (mt) {
      case MessageType.EnkazAltindayim:
        return "Enkaz Altında";
      case MessageType.Ambulans:
        return "Ambulans Talebi";
      case MessageType.KonaklamaTalebi:
        return "Konaklama Talebi";
    }
  }

  void _loadAllMarkers({
    required BuildContext context,
  }) {
    state = state.copyWith(
      mapMarkers: {},
    );

    var newMarkers = <Marker>{};
    for (var i = 0; i < state.messages.length; i++) {
      newMarkers = {
        ...newMarkers,
        _markerFromMessage(
          index: i,
          context: context,
        ),
      };
    }

    state = state.copyWith(
      mapMarkers: newMarkers,
    );
  }

  Future<void> _setCityList() async {
    final json = await rootBundle.loadString('assets/il_ilce.json');

    final map = jsonDecode(json) as Map<String, dynamic>;

    final iller = (map['data'] as List<dynamic>).map(
      (e) {
        return IlModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();

    state = state.copyWith(
      iller: iller,
    );
  }

  String getCity(String num) {
    int number = int.parse(num);
    for (int i = 0; i < state.iller.length; i++) {
      if (int.parse(state.iller[i].plakaKodu) == number) {
        return state.iller[i].ilAdi.toString();
      }
    }
    return "Not Found";
  }

  String getDistrict(String number) {
    int num = int.parse(number);

    for (int i = 0; i < state.iller.length; i++) {
      for (int j = 0; j < state.iller[i].ilceler.length; j++) {
        if (int.parse(state.iller[i].ilceler[j].ilceKodu) == num) {
          return state.iller[i].ilceler[j].ilceAdi.toString();
        }
      }
    }
    return "Not Found";
  }

  /*Future<String> getDistrict(String number) async {
    final json = await rootBundle.loadString('assets/il_ilce.json');

    final map = jsonDecode(json) as Map<String, dynamic>;

    final iller = (map['data'] as List<dynamic>).map(
      (e) {
        return IlModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();

    int num = int.parse(number);

    for (int i = 0; i < iller.length; i++) {
      for (int j = 0; j < iller[i].ilceler.length; j++) {
        if (int.parse(iller[i].ilceler[j].ilceKodu) == num) {
          return iller[i].ilceler[j].ilceAdi.toString();
        }
      }
    }
    return "Not Found";
  }*/

  void logout(BuildContext context) async {
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

  Future<void> init({
    required BuildContext context,
  }) async {
    await _setCityList();
    ref.read(fbDbProv).getUsers().listen(
      (event) {
        state = state.copyWith(
          users: event ?? [],
        );
      },
    );

    ref.read(fbDbProv).allMsgsOfTest().listen((event) {
      state = state.copyWith(
        messages: event,
      );
      _loadAllMarkers(
        context: context,
      );
    });
  }
}
