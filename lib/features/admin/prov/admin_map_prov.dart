import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/admin_map_state.dart';

final adminMapStateProvider =
    StateNotifierProvider<AdminMapStateNotifier, AdminMapState>(
  AdminMapStateNotifier.new,
);

class AdminMapStateNotifier extends StateNotifier<AdminMapState> {
  final Ref ref;
  AdminMapStateNotifier(this.ref) : super(AdminMapState.initial());

  void onMapCreated(GoogleMapController controller) {
    state = state.copyWith(mapController: controller);
  }

  void _routeDetailedPersonPage(BuildContext context) {
    GoRouter.of(context).pushNamed(
      RouteTable.rAdminDetailedPersonPage,
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
      final locationLatLng = LatLng(location.latitude, location.longitude);

      CameraPosition cameraPosition = CameraPosition(
        target: locationLatLng,
        zoom: 15.0,
      );

      state.mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      _addMarker(
        loc: locationLatLng,
        context: context,
      );
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
      _addMarker(
        loc: locationLatLng,
        context: context,
      );
    } else {
      // state.selectedLocation = null;
      state = state.copyWith(selectedLocation: null);
      _loadAllMarkers(
        context: context,
      );
    }
  }

  void _addMarker({
    required LatLng loc,
    required BuildContext context,
  }) {
    if (state.mapController != null) {
      state.mapMarkers.clear();
      state.mapMarkers.add(
        Marker(
          markerId: MarkerId(DateTime.now().toString()),
          position: loc,
          infoWindow: InfoWindow(
            title: 'Enkaz Altındayım',
            onTap: () => _routeDetailedPersonPage(context),
          ),
        ),
      );
    }
  }

  void _loadAllMarkers({
    required BuildContext context,
  }) {
    state.mapMarkers.clear();
    state.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        state.cameraPosition,
      ),
    );
    for (var i = 0; i < state.messages.length; i++) {
      final location = state.messages[i].loc;
      final locationLatLng = LatLng(location.latitude, location.longitude);

      state.mapMarkers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: locationLatLng,
          infoWindow: InfoWindow(
            title: 'Enkaz Altındayım',
            onTap: () => _routeDetailedPersonPage(context),
          ),
        ),
      );
    }
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
    _loadAllMarkers(
      context: context,
    );

    ref.read(fbDbProv).getUsers().listen(
      (event) {
        state = state.copyWith(
          users: event ?? [],
        );
      },
    );

    ref.read(fbDbProv).getMessages().listen((event) {
      state = state.copyWith(messages: event ?? []);
    });
  }
}