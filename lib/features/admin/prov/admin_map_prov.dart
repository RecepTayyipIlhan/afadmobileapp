import 'dart:convert';

import 'package:afad_app/features/admin/models/map_style.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/admin_map_state.dart';

const mapStyle = MapStyle(
  styleItems: [
    MapStyleItem(
      elementType: "geometry",
      stylers: [
        {"color": "#ebe3cd"}
      ],
    ),
    MapStyleItem(
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#523735"}
      ],
    ),
    MapStyleItem(
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#f5f1e6"}
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
      featureType: "administrative",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#c9b2a6"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative.land_parcel",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#dcd2be"}
      ],
    ),
    MapStyleItem(
      featureType: "administrative.land_parcel",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#ae9e90"}
      ],
    ),
    MapStyleItem(
      featureType: "landscape.natural",
      elementType: "geometry",
      stylers: [
        {"color": "#dfd2ae"}
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
        {"color": "#dfd2ae"}
      ],
    ),
    MapStyleItem(
      featureType: "poi",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#93817c"}
      ],
    ),
    MapStyleItem(
      featureType: "poi.park",
      elementType: "geometry.fill",
      stylers: [
        {"color": "#a5b076"}
      ],
    ),
    MapStyleItem(
      featureType: "poi.park",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#447530"}
      ],
    ),
    MapStyleItem(
      featureType: "road",
      elementType: "geometry",
      stylers: [
        {"color": "#f5f1e6"}
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
      featureType: "road.arterial",
      elementType: "geometry",
      stylers: [
        {"color": "#fdfcf8"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "geometry",
      stylers: [
        {"color": "#f8c967"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#e9bc62"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway.controlled_access",
      elementType: "geometry",
      stylers: [
        {"color": "#e98d58"}
      ],
    ),
    MapStyleItem(
      featureType: "road.highway.controlled_access",
      elementType: "geometry.stroke",
      stylers: [
        {"color": "#db8555"}
      ],
    ),
    MapStyleItem(
      featureType: "road.local",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#806b63"}
      ],
    ),
    MapStyleItem(
      featureType: "transit",
      stylers: [
        {"visibility": "off"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.line",
      elementType: "geometry",
      stylers: [
        {"color": "#dfd2ae"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.line",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#8f7d77"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.line",
      elementType: "labels.text.stroke",
      stylers: [
        {"color": "#ebe3cd"}
      ],
    ),
    MapStyleItem(
      featureType: "transit.station",
      elementType: "geometry",
      stylers: [
        {"color": "#dfd2ae"}
      ],
    ),
    MapStyleItem(
      featureType: "water",
      elementType: "geometry.fill",
      stylers: [
        {"color": "#b9d3c2"}
      ],
    ),
    MapStyleItem(
      featureType: "water",
      elementType: "labels.text.fill",
      stylers: [
        {"color": "#92998d"}
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

  AppUser queryUser({
    required String ui,
  }) {
    AppUser user = state.users.firstWhere((element) => element.id == ui);
    return user;
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
    ref.read(fbDbProv).getUsers().listen(
      (event) {
        state = state.copyWith(
          users: event ?? [],
        );
      },
    );

    ref.read(fbDbProv).getMessages().listen((event) {
      state = state.copyWith(
        messages: event ?? [],
      );
      _loadAllMarkers(
        context: context,
      );
    });
  }
}
