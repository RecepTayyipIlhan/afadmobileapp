<<<<<<< HEAD
import 'package:afad_app/features/auth/models/app_user.dart';
=======
import 'package:afad_app/features/mayday_call/help_message.dart';
>>>>>>> 712849b885e185af3c125e8ce6660b97dcb09d88
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

  Marker _markerFromMessage({
    required int index,
    required BuildContext context,
  }) {
    final message = state.messages[index];

    final location = message.loc;
    final locationLatLng = LatLng(location.latitude, location.longitude);

    return Marker(
      markerId: MarkerId(index.toString()),
      position: locationLatLng,
      infoWindow: InfoWindow(
        title: 'Enkaz Altındayım',
        onTap: () {
          _routeDetailedPersonPage(context);
        },
      ),
    );
  }

  void _loadAllMarkers({
    required BuildContext context,
    required GoogleMapController? mapController,
  }) {
    state = state.copyWith(
      mapMarkers: {},
      mapController: mapController,
    );

<<<<<<< HEAD
      state = state.copyWith(
        mapMarkers: {
          ...state.mapMarkers,
          Marker(
            markerId: MarkerId(i.toString()),
            position: locationLatLng,
            infoWindow: InfoWindow(
              title: 'Enkaz Altındayım',
              onTap: () {
                String ui = state.messages[i].ui;
                var user = state.users.firstWhere(
                      (element) => element.id == ui,
                );
                _routeDetailedPersonPage(context, user);
              },
            ),
          ),
        },
      );
=======
    var newMarkers = <Marker>{};
    for (var i = 0; i < state.messages.length; i++) {
      newMarkers = {
        ...newMarkers,
        _markerFromMessage(
          index: i,
          context: context,
        ),
      };
>>>>>>> 712849b885e185af3c125e8ce6660b97dcb09d88
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
        mapController: state.mapController,
      );
    });
  }
}
